# ---------- Stage 1: Build the app ----------
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /src

COPY . .

RUN mvn clean install -DskipTests=true


# ---------- Stage 2: Run the app ----------
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /src/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
