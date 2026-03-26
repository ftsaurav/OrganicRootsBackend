# Stage 1: Build the app
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/organica-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 9090

CMD ["sh", "-c", "java -jar app.jar --server.port=${PORT:9090}"]