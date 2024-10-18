# Step 1: Use an official OpenJDK runtime as a parent image
FROM openjdk:8-jdk-alpine

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy the current directory contents into the container at /app
COPY . .

# Step 4: Expose the port the app runs on
EXPOSE 8080

# Step 5: Run the application
CMD ["java", "-jar", "target/wisecow.jar"]