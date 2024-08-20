pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'rupalsoni123/react_app'  // Replace with your Docker Hub image name
        DOCKER_TAG = 'latest'  // Tag for the Docker image
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'  // Path to your Docker Compose file
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Hub (use Jenkins credentials for security)
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                    
                    // Push the Docker image to Docker Hub
                    sh 'docker push ${DOCKER_IMAGE}:${DOCKER_TAG}'
                }
            }
        }

        stage('Update Docker Compose') {
            steps {
                script {
                    // Pull the latest Docker image (optional)
                    sh 'docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}'
                    
                    // Update the Docker Compose setup
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} up -d'
                }
            }
        }
    }

    post {
        always {
            // Clean up any unused Docker images or containers
            sh 'docker system prune -af'
        }
    }
}

