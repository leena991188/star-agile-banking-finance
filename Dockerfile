# Stage 1: Build with Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime image with just the jar
FROM eclipse-temurin:17-jdk AS runtime
WORKDIR /app

# Cloud Run expects app to listen on $PORT
ENV PORT=8080
EXPOSE 8080

COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
