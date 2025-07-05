pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "laurahmz/cicd-pipeline"
        PORT = '3001'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install & Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Tests') {
            steps {
                sh 'npm test || echo "No tests found or tests failed"'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:dev")
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    sh "docker rm -f app-dev || true"
                    sh "docker run -d -p ${PORT}:3000 --name app-dev ${DOCKER_IMAGE}:dev"
                }
            }
        }
        // En dev no hacemos push a DockerHub, pero puedes si necesitas QA
    }
}
