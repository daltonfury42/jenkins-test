FROM openjdk:11-jre-slim

EXPOSE 8080

RUN mkdir /app

COPY target/*.jar /app/spring-boot-application.jar

ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/spring-boot-application.jar"]

