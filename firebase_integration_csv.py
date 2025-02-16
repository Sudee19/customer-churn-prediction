import firebase_admin
from firebase_admin import credentials, db
import pandas as pd
from datetime import datetime

def initialize_firebase():
    try:
        # Initialize Firebase with your credentials
        cred = credentials.Certificate('firebase_credentials.json')
        firebase_admin.initialize_app(cred, {
            'databaseURL': 'https://customer-churn-predictio-b81c7-default-rtdb.firebaseio.com'
        })
        print("Successfully connected to Firebase!")
        return True
    except Exception as e:
        print(f"Error initializing Firebase: {e}")
        return False

def get_churned_customers():
    try:
        # Read the CSV file
        df = pd.read_csv('sample_customer_data.csv')
        
        # Filter only churned customers
        churned_df = df[df['Churn'] == 1]
        
        # Select required columns and convert to dictionary
        churned_customers = churned_df[['CustomerID', 'Age', 'Gender', 'Location', 'MonthlyBill']].to_dict('records')
        
        print(f"Found {len(churned_customers)} churned customers")
        return churned_customers
    except Exception as e:
        print(f"Error reading CSV file: {e}")
        return []

def upload_to_firebase(customers):
    try:
        # Reference to your Firebase database
        ref = db.reference('/')
        
        # Add timestamp to the data
        upload_data = {
            'churned_customers': {
                'last_updated': datetime.now().isoformat(),
                'customers': customers
            }
        }
        
        # Upload data to Firebase
        ref.set(upload_data)
        print(f"Successfully uploaded {len(customers)} customer records to Firebase!")
        
        # Print the uploaded data for verification
        print("\nUploaded Data Preview:")
        for customer in customers[:3]:  # Show first 3 customers
            print(customer)
            
        return True
    except Exception as e:
        print(f"Error uploading to Firebase: {e}")
        print("Error details:", str(e))
        return False

def main():
    # Initialize Firebase
    if not initialize_firebase():
        return

    # Get churned customers from CSV
    churned_customers = get_churned_customers()
    if not churned_customers:
        return

    # Upload data to Firebase
    upload_to_firebase(churned_customers)

if __name__ == "__main__":
    main()
