# Start with a base image containing Java runtime (Java 17)
FROM openjdk:17-jdk-alpine

# Add a volume pointing to /tmp (optional)
VOLUME /tmp

# Make port 8080 available to the world outside this container
EXPOSE 8080

# The application's jar file
ARG JAR_FILE=target/jenkins_cicd.jar

# Add the application's jar to the container
ADD ${JAR_FILE} jenkins_cicd.jar

# Run the jar file
ENTRYPOINT ["java","-jar","/jenkins_cicd.jar"]
