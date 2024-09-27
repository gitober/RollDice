# Stage 1: Build the application
FROM maven:3.8.8-eclipse-temurin-17 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml /app/
RUN mvn dependency:go-offline

# Copy the source code
COPY . /app/

# Build the application
RUN mvn package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jdk

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/DiceRoll-1.0-SNAPSHOT.jar /app/DiceRoll.jar

# Run the application
CMD ["java", "-jar", "/app/DiceRoll.jar"]
