FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy Oracle Wallet
COPY wallet /app/wallet

# Copy Spring Boot jar
COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]

