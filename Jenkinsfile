#!/usr/bin/env groovy
def app
pipeline {

    agent any

    tools {
        jdk 'JFROG_JDK'
        maven 'JFROG_MAVEN'
    }
    stages {
        stage('Checkout') {
            steps {
                step([$class: 'WsCleanup'])
                git url: 'https://github.com/devstartshop/spring-petclinic.git', branch:'main'
            }
        }

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
                    sh "docker build -t devstartshop/spring-petclinic:${env.BUILD_NUMBER} ."
                }
            }
        }
        stage('Push image to DockerHub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: "dockerhub-credentials"]) {
                        sh "docker push devstartshop/spring-petclinic:${env.BUILD_NUMBER}"
                    }
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
            echo "Build failed!!"
            cleanWs()
        }
    }
}
