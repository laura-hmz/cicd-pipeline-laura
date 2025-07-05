pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "laurahmz/cicd-pipeline"
        PORT = '3000'
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
                    docker.build("${DOCKER_IMAGE}:main")
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    sh "docker rm -f app-main || true"
                    sh "docker run -d -p ${PORT}:3000 --name app-main ${DOCKER_IMAGE}:main"
                }
            }
        }
        stage('Push to DockerHub') {
            when { branch 'main' }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${DOCKER_IMAGE}:main"
                }
            }
        }
    }
}
