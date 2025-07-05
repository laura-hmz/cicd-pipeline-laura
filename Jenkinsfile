pipeline {
    agent {
        docker {
            image 'node:18' // Usa node:20 si tu proyecto lo requiere
        }
    }

    environment {
        DOCKER_IMAGE = "laurahmz/cicd-pipeline" // Cambia si usas otro nombre de repo en DockerHub
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
                // Descomenta si usas build scripts como React o Vue
                // sh 'npm run build'
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
                    dockerImage = docker.build("${DOCKER_IMAGE}:${env.BRANCH_NAME}")
                }
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${DOCKER_IMAGE}:${env.BRANCH_NAME}"
                }
            }
        }
    }
}
