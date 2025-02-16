from pyspark.sql import SparkSession
import pandas as pd
from pyspark.sql.functions import col, mean, mode, when, lit, udf
from pyspark.sql.types import StringType
from pyspark.ml.feature import StringIndexer, OneHotEncoder, VectorAssembler
from pyspark.ml.feature import MinMaxScaler
from pyspark.ml import Pipeline

# Initialize Spark session
spark = SparkSession.builder \
    .appName("Customer Churn Preprocessing") \
    .getOrCreate()

# Read the dataset using pandas and convert to Spark DataFrame
pdf = pd.read_excel("customer_churn_large_dataset.xlsx")
df = spark.createDataFrame(pdf)

# Drop the 'Name' column
df = df.drop('Name')

# Handle missing values
# Calculate mean for Age
age_mean = df.select(mean('Age')).collect()[0][0]
df = df.na.fill(age_mean, subset=['Age'])

# Calculate mode for Gender
gender_mode = df.groupBy('Gender').count().orderBy('count', ascending=False).first()['Gender']
df = df.na.fill(gender_mode, subset=['Gender'])

# Convert Subscription_Length_Months into categories
df = df.withColumn('Subscription_Category',
    when(col('Subscription_Length_Months') <= 6, '0-6 months')
    .when(col('Subscription_Length_Months') <= 12, '7-12 months')
    .otherwise('>12 months'))

# One-hot encoding pipeline for categorical variables
categorical_columns = ['Location', 'Gender', 'Subscription_Category']
stages = []

# String Indexing
for column in categorical_columns:
    indexer = StringIndexer(inputCol=column, 
                          outputCol=f"{column}_indexed",
                          handleInvalid="keep")
    stages.append(indexer)
    
    # One-hot encoding
    encoder = OneHotEncoder(inputCols=[f"{column}_indexed"],
                          outputCols=[f"{column}_encoded"],
                          dropLast=True)
    stages.append(encoder)

# Normalize numerical features
numerical_columns = ['Monthly_Bill', 'Total_Usage_GB']
for column in numerical_columns:
    assembler = VectorAssembler(inputCols=[column], 
                              outputCol=f"{column}_vector")
    scaler = MinMaxScaler(inputCol=f"{column}_vector", 
                         outputCol=f"{column}_scaled")
    stages.extend([assembler, scaler])

# Create and apply the pipeline
pipeline = Pipeline(stages=stages)
preprocessed_df = pipeline.fit(df).transform(df)

# Select relevant columns for the final dataset
final_columns = ['Age'] + \
                [f"{col}_encoded" for col in categorical_columns] + \
                [f"{col}_scaled" for col in numerical_columns] + \
                ['Churn']

preprocessed_df = preprocessed_df.select(final_columns)

# Show the first few rows of the preprocessed dataset
preprocessed_df.show(5)

# Optional: Save the preprocessed dataset
preprocessed_df.write.mode("overwrite").parquet("preprocessed_churn_data")
