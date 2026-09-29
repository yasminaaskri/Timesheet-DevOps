FROM eclipse-temurin:21-jre
WORKDIR /app
COPY target/timesheet-devops-1.0.jar app.jar
EXPOSE 8088
ENTRYPOINT ["java", "-jar", "app.jar"]
