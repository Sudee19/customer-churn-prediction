# Firebase Integration Setup Instructions

## Prerequisites
1. Python 3.x installed
2. MySQL (XAMPP) running
3. Firebase account

## Setup Steps

### 1. Firebase Project Setup
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select an existing one
3. Navigate to Project Settings (gear icon) > Service Accounts
4. Click "Generate New Private Key"
5. Save the downloaded JSON file as `firebase_credentials.json` in the project directory

### 2. Firebase Database Setup
1. In Firebase Console, go to Realtime Database
2. Click "Create Database"
3. Choose a location and start in test mode
4. Copy your database URL (it looks like: `https://your-project.firebaseio.com`)
5. Replace 'YOUR_FIREBASE_DATABASE_URL' in `firebase_integration.py` with your actual database URL

### 3. Install Required Python Packages
```bash
pip install firebase-admin mysql-connector-python
```

### 4. Configure MySQL Connection
The script is configured to connect to MySQL with these default settings:
- Host: 127.0.0.1
- User: root
- Password: (empty)
- Database: customer_churn_db

If your settings are different, update them in `firebase_integration.py`.

### 5. Run the Integration
```bash
python firebase_integration.py
```

## Data Structure
The script will create the following structure in Firebase:
```json
{
    "churned_customers": {
        "last_updated": "2025-02-08T23:06:37",
        "customers": [
            {
                "CustomerID": 1,
                "Age": 35,
                "Gender": "Female",
                "Location": "New York",
                "MonthlyBill": 95.20
            },
            ...
        ]
    }
}
```

## Troubleshooting
1. If you get authentication errors:
   - Verify that `firebase_credentials.json` is in the correct location
   - Check if the database URL is correct
   - Ensure Firebase project permissions are set correctly

2. If MySQL connection fails:
   - Verify XAMPP is running
   - Check if the MySQL credentials are correct
   - Ensure the database exists and contains data
