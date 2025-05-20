# Use an official Maven image to build the app
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Use a lightweight base image to run the app
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Expose port 8080 and run the application
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
