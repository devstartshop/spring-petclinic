#!/usr/bin/env groovy
def app
pipeline {

    agent any // use any available node. In our case there is only master.

    tools {
        jdk 'JFROG_JDK' // pick specific JDK based on project needs.
        maven 'JFROG_MAVEN' // pick specific Maven installation based on project needs.
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
                    withMaven(jdk: 'JFROG_JDK', maven: 'JFROG_MAVEN', mavenSettingsConfig: 'b8216566-c5c3-401b-a4b5-185c237193fa') {
                        // some block
                        sh "mvn clean compile"
                    }
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    withMaven(jdk: 'JFROG_JDK', maven: 'JFROG_MAVEN', mavenSettingsConfig: 'b8216566-c5c3-401b-a4b5-185c237193fa') {
                        sh "mvn clean test"
                    }

                }
            }
        }
        stage('Package & Build') {
            steps {
                script {
                    withMaven(jdk: 'JFROG_JDK', maven: 'JFROG_MAVEN', mavenSettingsConfig: 'b8216566-c5c3-401b-a4b5-185c237193fa') {
                        sh "mvn clean package -DskipTest=true"
                    }

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
