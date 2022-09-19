FROM maven:3.6.3-jdk-8 AS build
COPY pspipeline/src /usr/src/app/src
COPY pspipeline/pom.xml /usr/src/app
RUN pwd
RUN echo $WORKSPACE
RUN ls 
RUN mvn -f /usr/src/app/pom.xml clean package
FROM openjdk:9
COPY --from=build /usr/src/app/target/*.jar /usr/app/*.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/*.jar"]
