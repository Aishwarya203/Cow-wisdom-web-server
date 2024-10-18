#!/bin/bash

# Check if a log file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE=$1

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found!"
    exit 1
fi

# Count 404 errors
echo "Counting 404 errors..."
ERROR_404_COUNT=$(grep -c " 404 " "$LOG_FILE")
echo "Number of 404 errors: $ERROR_404_COUNT"

# Most requested pages
echo "Finding most requested pages..."
MOST_REQUESTED_PAGES=$(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 10)
echo "Most requested pages:"
echo "$MOST_REQUESTED_PAGES"

# IP addresses with the most requests
echo "Finding IP addresses with the most requests..."
MOST_REQUESTING_IPS=$(awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 10)
echo "IP addresses with the most requests:"
echo "$MOST_REQUESTING_IPS"

# Summary report
echo "Summary Report:"
echo "-----------------------------"
echo "404 Errors: $ERROR_404_COUNT"
echo "Most Requested Pages:"
echo "$MOST_REQUESTED_PAGES"
echo "IP Addresses with Most Requests:"
echo "$MOST_REQUESTING_IPS"