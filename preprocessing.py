import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler

# Read the dataset
df = pd.read_excel("customer_churn_large_dataset.xlsx")

# Drop the 'Name' column
df = df.drop('Name', axis=1)

# Handle missing values
df['Age'] = df['Age'].fillna(df['Age'].mean())
df['Gender'] = df['Gender'].fillna(df['Gender'].mode()[0])

# Convert Subscription_Length_Months into categories
def categorize_subscription(months):
    if months <= 6:
        return '0-6 months'
    elif months <= 12:
        return '7-12 months'
    else:
        return '>12 months'

df['Subscription_Category'] = df['Subscription_Length_Months'].apply(categorize_subscription)

# One-hot encode categorical variables
categorical_columns = ['Location', 'Gender', 'Subscription_Category']
df_encoded = pd.get_dummies(df, columns=categorical_columns, drop_first=True)

# Normalize numerical features
scaler = MinMaxScaler()
numerical_columns = ['Monthly_Bill', 'Total_Usage_GB']
df_encoded[numerical_columns] = scaler.fit_transform(df_encoded[numerical_columns])

# Save the preprocessed dataset
df_encoded.to_csv('preprocessed_churn_data.csv', index=False)
print("\nPreprocessing completed successfully!")
print("\nFirst few rows of the preprocessed dataset:")
print(df_encoded.head())
print("\nColumns in the preprocessed dataset:")
print(df_encoded.columns.tolist())
