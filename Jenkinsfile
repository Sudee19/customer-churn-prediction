pipeline {
    agent any
    
    environment {
        GITHUB_TOKEN = credentials('github-token')
        DOCKER_REGISTRY = 'docker.io'
        IMAGE_NAME = 'customer-churn-prediction'
        IMAGE_TAG = "${BUILD_NUMBER}"
        AIRFLOW_HOME = '/opt/airflow'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/sudee19/customer-churn-prediction.git',
                    credentialsId: 'github-token'
            }
        }
        
        stage('Build Environment') {
            steps {
                sh '''
                    docker-compose -f docker-compose.yml build
                    docker-compose -f docker-compose.yml up -d
                '''
            }
        }
        
        stage('Initialize Airflow') {
            steps {
                sh '''
                    docker-compose -f docker-compose.yml exec airflow airflow db init
                    docker-compose -f docker-compose.yml exec airflow airflow users create \
                        --username admin \
                        --firstname Admin \
                        --lastname User \
                        --role Admin \
                        --email admin@example.com \
                        --password admin
                '''
            }
        }
        
        stage('Run ETL Pipeline') {
            steps {
                sh '''
                    # Wait for Airflow webserver to be ready
                    sleep 30
                    
                    # Trigger the DAG
                    docker-compose -f docker-compose.yml exec airflow airflow dags unpause churn_etl_pipeline
                    docker-compose -f docker-compose.yml exec airflow airflow dags trigger churn_etl_pipeline
                '''
            }
        }
        
        stage('Verify Pipeline') {
            steps {
                sh '''
                    # Check DAG status
                    docker-compose -f docker-compose.yml exec airflow airflow dags show churn_etl_pipeline
                    
                    # Get latest run logs
                    docker-compose -f docker-compose.yml exec airflow airflow dags show churn_etl_pipeline --subdir /opt/airflow/logs/churn_etl_pipeline
                '''
            }
        }
    }
    
    post {
        always {
            sh '''
                # Cleanup
                docker-compose -f docker-compose.yml down
            '''
        }
    }
}
