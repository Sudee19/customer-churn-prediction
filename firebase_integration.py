import firebase_admin
from firebase_admin import credentials, db
import mysql.connector
import json
from datetime import datetime

def connect_to_mysql():
    try:
        # Try connecting with default XAMPP settings
        connection = mysql.connector.connect(
            host="127.0.0.1",
            user="root",
            password="",  # Default XAMPP password is empty
            database="customer_churn_db",
            port=3306,
            allow_local_infile=True
        )
        print("Successfully connected to MySQL!")
        return connection
    except mysql.connector.Error as err:
        print(f"Error connecting to MySQL: {err}")
        return None

def get_churned_customers(connection):
    try:
        cursor = connection.cursor(dictionary=True)
        query = """
            SELECT 
                CustomerID,
                Age,
                Gender,
                Location,
                MonthlyBill
            FROM 
                customer_churn
            WHERE 
                Churn = true
        """
        cursor.execute(query)
        customers = cursor.fetchall()
        cursor.close()
        return customers
    except mysql.connector.Error as err:
        print(f"Error fetching data: {err}")
        return []

def initialize_firebase():
    try:
        # Initialize Firebase with your credentials
        cred = credentials.Certificate('firebase_credentials.json')
        firebase_admin.initialize_app(cred, {
            'databaseURL': 'https://customer-churn-prediction-default-rtdb.firebaseio.com/'
        })
        print("Successfully connected to Firebase!")
        return True
    except Exception as e:
        print(f"Error initializing Firebase: {e}")
        return False

def upload_to_firebase(customers):
    try:
        # Reference to your Firebase database
        ref = db.reference('churned_customers')
        
        # Add timestamp to the data
        upload_data = {
            'last_updated': datetime.now().isoformat(),
            'customers': customers
        }
        
        # Upload data to Firebase
        ref.set(upload_data)
        print(f"Successfully uploaded {len(customers)} customer records to Firebase!")
        return True
    except Exception as e:
        print(f"Error uploading to Firebase: {e}")
        return False

def main():
    # Connect to MySQL
    mysql_conn = connect_to_mysql()
    if not mysql_conn:
        return

    # Get churned customers from MySQL
    churned_customers = get_churned_customers(mysql_conn)
    mysql_conn.close()

    if not churned_customers:
        print("No churned customers found in the database.")
        return

    # Initialize Firebase
    if not initialize_firebase():
        return

    # Upload data to Firebase
    upload_to_firebase(churned_customers)

if __name__ == "__main__":
    main()
