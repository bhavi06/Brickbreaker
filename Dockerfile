FROM openjdk:8
EXPOSE 86
ENTRYPOINT ["java","-jar","/devops-integration.jar"]