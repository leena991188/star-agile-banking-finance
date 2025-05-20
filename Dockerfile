# Build the app with Maven
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Run the app on a lightweight JDK image
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Expose port 9090 (matches the app's internal server port)
EXPOSE 9090

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
