from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
import pandas as pd
import os
import logging
from pathlib import Path

# Set up logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
}

def extract_data():
    """Extract data from input file"""
    try:
        # Define the input file path
        input_file = "/opt/airflow/data/customer_churn_large_dataset.xlsx"
        logger.info(f"Starting data extraction from {input_file}")
        
        # Determine file type and read accordingly
        file_extension = input_file.split('.')[-1].lower()
        
        if file_extension == 'csv':
            df = pd.read_csv(input_file)
            logger.info("Successfully read CSV file")
        elif file_extension in ['xlsx', 'xls']:
            df = pd.read_excel(input_file, engine='openpyxl')
            logger.info("Successfully read Excel file")
        else:
            raise ValueError(f"Unsupported file format: {file_extension}")
        
        logger.info(f"Successfully read {len(df)} records")
        
        # Basic data validation
        required_columns = ['Age', 'Monthly_Bill', 'Total_Usage_GB', 'Subscription_Length_Months']
        missing_columns = [col for col in required_columns if col not in df.columns]
        if missing_columns:
            raise ValueError(f"Missing required columns: {missing_columns}")
        
        # Save to temporary CSV
        temp_path = '/opt/airflow/data/tmp/raw_customer_data.csv'
        os.makedirs(os.path.dirname(temp_path), exist_ok=True)
        df.to_csv(temp_path, index=False)
        logger.info(f"Saved raw data to {temp_path}")
        
        return temp_path
        
    except Exception as e:
        logger.error(f"Error in extraction: {str(e)}")
        raise

def transform_data(ti):
    """Transform data by applying business rules and cleaning"""
    try:
        # Get the path from previous task
        input_path = ti.xcom_pull(task_ids='extract_task')
        logger.info(f"Starting data transformation from {input_path}")
        
        # Read the CSV
        df = pd.read_csv(input_path)
        
        # Data cleaning and transformation
        # 1. Remove duplicates
        df = df.drop_duplicates()
        
        # 2. Handle missing values
        df = df.fillna({
            'Age': df['Age'].median(),
            'Monthly_Bill': df['Monthly_Bill'].median(),
            'Total_Usage_GB': df['Total_Usage_GB'].median()
        })
        
        # 3. Filter high-risk customers
        filtered_df = df[
            (df['Monthly_Bill'] > df['Monthly_Bill'].median()) & 
            (df['Total_Usage_GB'] < df['Total_Usage_GB'].median()) &
            (df['Subscription_Length_Months'] < 12)
        ]
        
        # Save transformed data
        output_path = '/opt/airflow/data/tmp/transformed_customer_data.csv'
        filtered_df.to_csv(output_path, index=False)
        logger.info(f"Transformed data: {len(filtered_df)} records identified as high-risk")
        
        return output_path
        
    except Exception as e:
        logger.error(f"Error in transformation: {str(e)}")
        raise

def load_data(ti):
    """Load transformed data to final destination"""
    try:
        # Get the path from previous task
        input_path = ti.xcom_pull(task_ids='transform_task')
        logger.info(f"Starting data loading from {input_path}")
        
        # Read the transformed data
        df = pd.read_csv(input_path)
        
        # Save to final destination
        output_dir = '/opt/airflow/data/processed'
        os.makedirs(output_dir, exist_ok=True)
        
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        final_path = f"{output_dir}/high_risk_customers_{timestamp}.csv"
        df.to_csv(final_path, index=False)
        
        # Generate summary statistics
        summary = {
            'total_records': len(df),
            'average_monthly_bill': float(df['Monthly_Bill'].mean()),
            'average_usage_gb': float(df['Total_Usage_GB'].mean()),
            'average_subscription_length': float(df['Subscription_Length_Months'].mean())
        }
        
        # Save summary to JSON
        summary_path = f"{output_dir}/summary_{timestamp}.json"
        pd.Series(summary).to_json(summary_path)
        
        logger.info(f"Successfully loaded {len(df)} records to {final_path}")
        logger.info(f"Summary statistics saved to {summary_path}")
        
        # Cleanup temporary files
        os.remove(input_path)
        os.remove(ti.xcom_pull(task_ids='extract_task'))
        logger.info("Cleaned up temporary files")
        
    except Exception as e:
        logger.error(f"Error in loading: {str(e)}")
        raise

# Create the DAG
with DAG(
    'customer_churn_etl',
    default_args=default_args,
    description='ETL pipeline for customer churn prediction',
    schedule_interval=timedelta(days=1),
    start_date=datetime(2025, 2, 14),
    catchup=False,
    tags=['customer_churn'],
) as dag:
    
    # Create data directories
    data_dir = '/opt/airflow/data'
    tmp_dir = f'{data_dir}/tmp'
    processed_dir = f'{data_dir}/processed'
    
    for dir_path in [data_dir, tmp_dir, processed_dir]:
        os.makedirs(dir_path, exist_ok=True)
    
    # Define tasks
    extract_task = PythonOperator(
        task_id='extract_task',
        python_callable=extract_data,
    )
    
    transform_task = PythonOperator(
        task_id='transform_task',
        python_callable=transform_data,
    )
    
    load_task = PythonOperator(
        task_id='load_task',
        python_callable=load_data,
    )
    
    # Set task dependencies
    extract_task >> transform_task >> load_task