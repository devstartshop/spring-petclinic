FROM adoptopenjdk:11-jre-openj9-focal
MAINTAINER Anmol Jain
COPY target/app.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
USER 1001
EXPOSE 8080
