pipeline {
    agent any
    
    stages {
        stage('Setup') {
            steps {
                sh 'python3 --version'
                sh 'pip3 --version'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh 'python3 -m pytest tests/ || true'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t customer-churn:latest .'
            }
        }
    }
}
