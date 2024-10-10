FROM maven:3.8.4-openjdk-11 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim

WORKDIR /app

COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]

#On peut egalement utiliser des outils comme paketo qui generent les images docker optimisee au maximum sans dockerfile avec la commande
#./mvnw spring-boot:build-image "-Dspring-boot.build-image.imageName=demo-app:latest"