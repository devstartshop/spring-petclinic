#!/usr/bin/env groovy
pipeline {

    agents any

    tools {
        jdk 'JAVA_17'
        maven 'MAVEN'
    }
    stages {
        def app
        stage('Compile') {
            sh "mvn clean compile"
        }
        stage('Run Tests') {
            sh "mvn clean test"
        }
        stage('Package & Build') {
            sh "mvn clean package -DskipTest=true"
        }
        stage('Build Docker image') {
            app = docker.build("devstartshop/spring-petclinic")
        }
        stage('Push image to DockerHub') {
            docker.withRegistry('https://registry.hub.docker.com', 'git') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }
        }
    }

    post {
        success {
            echo "Build Success!!"
            cleanWs()
        }
        failure {
            echo "Build Success!!"
            cleanWs()
        }
    }
}
