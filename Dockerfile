# Stage 1: Build the application
FROM maven:3.8.3-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy source code from local to container
COPY . .

# Build the jar file
RUN mvn clean install -DskipTests=true

# Stage 2: Run the application
FROM openjdk:17-alpine

# Set working directory
WORKDIR /app

# Copy the jar file from the builder stage
COPY --from=builder /app/target/*.jar /app/expenseapp.jar

# Set the command to run the application
CMD ["java", "-jar", "/app/expenseapp.jar"]
