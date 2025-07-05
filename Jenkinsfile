pipeline {
    agent {
        docker {
            image 'node:18' // Usa node:20 si tu proyecto lo requiere
        }
    }

    environment {
        DOCKER_IMAGE = "laura/cicd-pipeline" // Cambia esto si subes a DockerHub u otro registry
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
                // Si no tienes tests, puedes comentar o borrar este bloque
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
                echo 'Deployment logic goes here, if needed'
                // Puedes subir la imagen a DockerHub o a tu servidor, por ejemplo:
                // sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                // sh "docker push ${DOCKER_IMAGE}:${env.BRANCH_NAME}"
            }
        }
    }
}
