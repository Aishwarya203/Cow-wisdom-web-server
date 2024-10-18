#!/bin/bash

# Configuration
SOURCE_DIR="$1"  # Directory to back up
REMOTE_SERVER="$2"  # Remote server address
REMOTE_DIR="$3"  # Directory on the remote server
LOG_FILE="backup_report.log"

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <source_directory> <remote_server> <remote_directory>"
    exit 1
fi

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist!"
    exit 1
fi

# Create a timestamp for the backup
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"

# Create a backup
echo "Creating backup of $SOURCE_DIR..."
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .

# Check if the backup was created successfully
if [ $? -ne 0 ]; then
    echo "Backup creation failed!" | tee -a "$LOG_FILE"
    exit 1
fi

# Transfer the backup to the remote server
echo "Transferring backup to $REMOTE_SERVER:$REMOTE_DIR..."
scp "$BACKUP_FILE" "$REMOTE_SERVER:$REMOTE_DIR"

# Check if the transfer was successful
if [ $? -eq 0 ]; then
    echo "Backup successful! Backup file: $BACKUP_FILE" | tee -a "$LOG_FILE"
else
    echo "Backup transfer failed!" | tee -a "$LOG_FILE"
    exit 1
fi

# Clean up the local backup file
rm "$BACKUP_FILE"