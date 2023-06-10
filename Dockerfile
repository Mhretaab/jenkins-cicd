# Start with a base image containing Java runtime (Java 17)
FROM openjdk:17-jdk-alpine

# Add a volume pointing to /tmp (optional)
VOLUME /tmp

# Make port 8080 available to the world outside this container
EXPOSE 8080

# The application's jar file
ARG JAR_FILE=target/jenkins-cicd-0.0.1-SNAPSHOT.jar

# Add the application's jar to the container
ADD ${JAR_FILE} jenkins-cicd-0.0.1-SNAPSHOT.jar

# Run the jar file
ENTRYPOINT ["java","-jar","/jenkins-cicd-0.0.1-SNAPSHOT.jar"]
