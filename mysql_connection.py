import mysql.connector
import pandas as pd

def connect_to_mysql():
    try:
        # Connect to MySQL with default XAMPP settings
        connection = mysql.connector.connect(
            host="127.0.0.1",
            user="root",
            password="",  # Default XAMPP MySQL has no password
            port=3306,
            auth_plugin='mysql_native_password'
        )
        print("Successfully connected to MySQL!")
        return connection
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

def create_database_and_table(connection):
    try:
        cursor = connection.cursor()
        
        # Create database if it doesn't exist
        cursor.execute("CREATE DATABASE IF NOT EXISTS customer_churn_db")
        cursor.execute("USE customer_churn_db")
        print("Database 'customer_churn_db' created and selected!")

        # Read SQL file
        with open('customer_churn_queries.sql', 'r') as file:
            sql_commands = file.read().split(';')

        # Execute each SQL command
        for command in sql_commands:
            if command.strip():
                cursor.execute(command)
                connection.commit()
        
        print("Table created and sample data inserted successfully!")
        
        # Execute the high churn risk query
        print("\nCustomers with high churn risk:")
        cursor.execute("""
            SELECT 
                CustomerID,
                Age,
                Gender,
                Location,
                SubscriptionLength,
                MonthlyBill,
                TotalUsage,
                Churn
            FROM 
                customer_churn
            WHERE 
                MonthlyBill > 80 
                AND SubscriptionLength < 6
            ORDER BY 
                MonthlyBill DESC
        """)
        
        # Fetch and display results
        results = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]
        df = pd.DataFrame(results, columns=columns)
        print(df)

    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        if cursor:
            cursor.close()

def main():
    # Connect to MySQL
    connection = connect_to_mysql()
    
    if connection:
        # Create database and table
        create_database_and_table(connection)
        
        # Close connection
        connection.close()
        print("\nMySQL connection closed.")

if __name__ == "__main__":
    main()
