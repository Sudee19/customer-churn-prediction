-- Create and use the database
CREATE DATABASE IF NOT EXISTS customer_churn_db;
USE customer_churn_db;

-- 1. Create the customer_churn table
CREATE TABLE IF NOT EXISTS customer_churn (
    CustomerID INT PRIMARY KEY,
    Age INT,
    Gender VARCHAR(10),
    Location VARCHAR(50),
    SubscriptionLength INT,
    MonthlyBill DECIMAL(10,2),
    TotalUsage DECIMAL(10,2),
    Churn BOOLEAN
);

-- 2. Insert sample records
INSERT INTO customer_churn 
(CustomerID, Age, Gender, Location, SubscriptionLength, MonthlyBill, TotalUsage, Churn)
VALUES 
(1, 28, 'Male', 'New York', 12, 85.50, 150.25, false),
(2, 35, 'Female', 'Los Angeles', 4, 95.20, 200.75, true),
(3, 42, 'Male', 'Chicago', 8, 75.00, 120.50, false),
(4, 31, 'Female', 'Houston', 3, 90.75, 180.00, true),
(5, 45, 'Male', 'Miami', 15, 65.25, 90.50, false),
(6, 29, 'Female', 'New York', 5, 88.00, 160.25, true),
(7, 38, 'Male', 'Los Angeles', 18, 70.50, 110.75, false),
(8, 33, 'Female', 'Houston', 2, 98.25, 220.00, true),
(9, 40, 'Male', 'Miami', 9, 72.75, 130.50, false),
(10, 36, 'Female', 'Chicago', 4, 92.00, 175.25, true);

-- 3. Query to identify high churn risk customers
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
    MonthlyBill DESC;

-- Additional useful queries:

-- Get churn rate by location
SELECT 
    Location,
    COUNT(*) as total_customers,
    SUM(CASE WHEN Churn = true THEN 1 ELSE 0 END) as churned_customers,
    ROUND(AVG(CASE WHEN Churn = true THEN 1 ELSE 0 END) * 100, 2) as churn_rate
FROM 
    customer_churn
GROUP BY 
    Location
ORDER BY 
    churn_rate DESC;

-- Get average monthly bill by subscription length
SELECT 
    SubscriptionLength,
    COUNT(*) as customer_count,
    ROUND(AVG(MonthlyBill), 2) as avg_monthly_bill,
    ROUND(AVG(TotalUsage), 2) as avg_total_usage
FROM 
    customer_churn
GROUP BY 
    SubscriptionLength
ORDER BY 
    SubscriptionLength;
