pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('docker-hub-credentials')
        DOCKER_IMAGE = 'sudee19/customer-churn-prediction'
        DOCKER_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                script {
                    sh 'pip install -r requirements.txt'
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                script {
                    sh 'python -m pytest tests/ || true'
                }
            }
        }
        
        stage('Docker Build') {
            steps {
                echo 'Deploying the application...'
                script {
                    sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                    sh 'docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest'
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
