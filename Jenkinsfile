#!/usr/bin/env groovy

pipeline {
    agent any
    stages {
        stage('Initialise') {
            steps {
		      sh 'rm -rf Jenkins-WithTools-Docker'
              	      sh 'git clone https://github.com/dswilkinson73/Jenkins-WithTools-Docker.git'
		      echo "Initialising job - cloning repo"
                      dir("Jenkins-WithTools-Docker") {
                      sh 'pwd'
                  }
            }
        }
        stage('Build') {
            steps {
                      dir("Jenkins-WithTools-Docker") {
                      echo "Building Container"
                      sh 'docker build --tag jenkins-with-tools .'
                  }
		      
            }
        }
        stage('Deploy') {
            steps {
                     dir("Jenkins-WithTools-Docker") {
                     echo "Upload to Docker Hub"
                     sh 'docker tag local-image:jenkins-with-tools:latest dswilkinson/jenkins-with-tools'
                     sh 'docker push dswilkinson/jenkins-with-tools:latest'
                }
            }
        }
    }
}

