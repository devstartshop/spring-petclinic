# Spring PetClinic Sample Application [![Build Status](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml/badge.svg)](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml)

## Understanding the Spring Petclinic application with a few diagrams
<a href="https://speakerdeck.com/michaelisvy/spring-petclinic-sample-application">See the presentation here</a>

## Running petclinic locally
Petclinic is a [Spring Boot](https://spring.io/guides/gs/spring-boot) application built using [Maven](https://spring.io/guides/gs/maven/). You can build a jar file and run it from the command line (it should work just as well with Java 8, 11 or 17):

### Docker Hub Location for container images
https://hub.docker.com/repository/docker/devstartshop/spring-petclinic

Find tagname from this location and use it with below command to run the petclinic application as docker container
```
docker run -p8080:8080 devstartshop/spring-petclinic:<tagname>
```

You can then access petclinic here: http://localhost:8080/

<img width="1042" alt="petclinic-screenshot" src="https://cloud.githubusercontent.com/assets/838318/19727082/2aee6d6c-9b8e-11e6-81fe-e889a5ddfded.png">

## Deployment Process
The project contains 2 files important for deployment
1. **Dockerfile** - used to build a docker image using the _app.jar_ file that gets generated in _target/_ folder when application is build using maven build tool. the container is set to run with a non root user 1001 and exposes port 8080
2. **Jenkinsfile** - used to declare step-by-step stages to checkout, compile, test, build and publish the application. The Declarative pipeline defined in Jenkinsfile has some prerequisites to run successfully on the Jenkins server.

I have used a Jenkins DIND setup using a docker compose file. this runs Jenkins server as a docker container and enables us to run docker commands from within the container to build the application docker image.

I have configured below tools in Jenkins Global Tool Configuration:

1. All defaults plugins
2. **Managed File** plugin to define custom Maven settings.xml file that helps to resolve maven dependencies from JFrog Artifactory (JCenter Remote)
3. **Maven Pipeline** plugin for withMaven DSL commands
4. **Docker pipeline** plugin for withDockerRegistry DSL command.
5. JAVA 11
6. MAVEN 3.8.4
7. Credentials (Personal Access Token) for repository on the guthub.com to push code.

### Run Tests
Below screenshot shows Maven Test run report.

![img.png](img.png)
