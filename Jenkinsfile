#!/usr/bin/env groovy
def app
pipeline {

    agent any

    tools {
        jdk 'JAVA_17'
        maven 'MAVEN'
    }
    stages {

        stage('Compile') {
            steps {
                script {
                    sh "mvn clean compile"
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    sh "mvn clean test"
                }
            }
        }
        stage('Package & Build') {
            steps {
                script {
                    sh "mvn clean package -DskipTest=true"
                }
            }
        }
        stage('Build Docker image') {
            steps {
                script {
                    app = docker.build("devstartshop/spring-petclinic")
                }
            }
        }
        stage('Push image to DockerHub') {
            script {
                docker.withRegistry('https://registry.hub.docker.com', 'git') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                }
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
