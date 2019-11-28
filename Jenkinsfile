#!/usr/bin/env groovy

pipeline {
    agent any
    stages {
        stage('Initialise') {
            steps {
		      sh 'rm -rf Jenkins-WithTools-Docker.git'
              	      sh 'git clone https://github.com/dswilkinson73/Jenkins-WithTools-Docker.git'
		      echo "Initialising job - cloning repo"
                      dir("Jenkins-WithTools-Docker.git") {
                      sh 'pwd'
                  }
            }
        }
        stage('Validate') {
            steps {
                      dir("Jenkins-WithTools-Docker") {
                      echo "Building Container"
                      sh 'docker build --tag ubuntu_jenkins .'
                  }
		      
            }
        }
        stage('Deploy') {
            steps {
                     dir("Jenkins-WithTools-Docker") {
                     echo "Next Step"
                     sh ''
                }
            }
        }
    }
}

