pipeline {
    agent any
    
    environment {
        GITHUB_TOKEN = credentials('github-token')
        DOCKER_CREDENTIALS = credentials('docker-hub-credentials')
        FIREBASE_CREDENTIALS = credentials('firebase-credentials')
        DOCKER_IMAGE = 'sudee19/customer-churn-prediction'
        DOCKER_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/sudee19/customer-churn-prediction.git',
                    credentialsId: 'github-token'
            }
        }
        
        stage('Setup Python') {
            steps {
                sh '''
                    python -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                '''
            }
        }
        
        stage('Run Tests') {
            steps {
                sh '''
                    . venv/bin/activate
                    python -m pytest tests/ --junitxml=test-results/junit.xml || true
                '''
            }
            post {
                always {
                    junit '**/test-results/*.xml'
                }
            }
        }
        
        stage('Build Docker Images') {
            steps {
                sh """
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} -f Dockerfile .
                    docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest
                    docker build -t ${DOCKER_IMAGE}-jenkins:${DOCKER_TAG} -f Dockerfile.jenkins .
                    docker tag ${DOCKER_IMAGE}-jenkins:${DOCKER_TAG} ${DOCKER_IMAGE}-jenkins:latest
                """
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                sh """
                    echo \$DOCKER_CREDENTIALS_PSW | docker login -u \$DOCKER_CREDENTIALS_USR --password-stdin
                    docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                    docker push ${DOCKER_IMAGE}:latest
                    docker push ${DOCKER_IMAGE}-jenkins:${DOCKER_TAG}
                    docker push ${DOCKER_IMAGE}-jenkins:latest
                """
            }
        }
        
        stage('Deploy Services') {
            steps {
                withCredentials([file(credentialsId: 'firebase-credentials', variable: 'FIREBASE_CREDS')]) {
                    sh '''
                        cp $FIREBASE_CREDS firebase_credentials.json
                        docker-compose -f docker-compose.yml up -d
                    '''
                }
            }
        }
        
        stage('Run Airflow Pipeline') {
            steps {
                sh '''
                    sleep 30
                    docker-compose exec -T webserver airflow dags unpause churn_etl_pipeline
                    docker-compose exec -T webserver airflow dags trigger churn_etl_pipeline
                '''
            }
        }
    }
    
    post {
        always {
            sh '''
                docker-compose down || true
                docker logout || true
            '''
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed! Check the logs for details.'
        }
    }
}
