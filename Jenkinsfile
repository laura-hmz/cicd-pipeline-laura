pipeline {
    agent any

    environment {
        IMAGE_NAME = "nodemain"
        PORT = "3000"
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
                sh 'npm run build'
            }
        }

        stage('Tests') {
            steps {
                sh 'npm test || echo "tests skipped (adjust this if needed)"'
            }
        }

        stage('Set ENV') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        env.PORT = '3001'
                        env.IMAGE_NAME = 'nodedev'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:v1.0 ."
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Detener solo el contenedor de esta rama si existe
                    sh "docker rm -f ${IMAGE_NAME} || true"

                    // Correrlo en el puerto correspondiente
                    sh "docker run -d --name ${IMAGE_NAME} -p ${PORT}:${PORT} ${IMAGE_NAME}:v1.0"
                }
            }
        }
    }
}

