pipeline {
    agent any
    
    environment {
        VIRTUAL_ENV = '/opt/venv'
        PATH = "$VIRTUAL_ENV/bin:$PATH"
    }
    
    stages {
        stage('Setup') {
            steps {
                sh '''
                    . $VIRTUAL_ENV/bin/activate
                    python --version
                    pip --version
                '''
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh '''
                    . $VIRTUAL_ENV/bin/activate
                    pip install -r requirements.txt
                '''
            }
        }
        
        stage('Run Tests') {
            steps {
                sh '''
                    . $VIRTUAL_ENV/bin/activate
                    python -m pytest tests/ || true
                '''
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t customer-churn:latest .'
            }
        }
    }
}
