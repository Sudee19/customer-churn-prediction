# `Problem Statement: Customer Churn Prediction`

# Technologies & Languages

This project uses a diverse set of technologies and languages:

- Python (40%): Machine Learning, Data Processing, API Development
  - Scikit-learn, Flask, Pandas, NumPy
  - Jupyter Notebooks for analysis
  - ML model files (.pkl, .keras)

- JavaScript/TypeScript (20%): Frontend Development
  - React.js with TypeScript
  - Node.js and npm packages
  - Configuration files

- R (15%): Data Analysis and Visualization
  - PowerBI dashboards
  - Statistical analysis
  - Data visualization

- SQL (5%): Database Operations
  - MySQL queries
  - Data extraction and storage

- Docker/DevOps (10%): Infrastructure
  - Dockerfiles and compose files
  - Jenkins configuration
  - Shell scripts

- Documentation/Other (10%): Project Support
  - Markdown documentation
  - Data files (CSV, XLSX, JSON)
  - Configuration files

In today's competitive business landscape, customer retention is paramount for sustainable growth and success. Our challenge is to develop a predictive model that can identify customers who are at risk of churning – discontinuing their use of our service. Customer churn can lead to a significant loss of revenue and a decline in market share. By leveraging machine learning techniques, we aim to build a model that can accurately predict whether a customer is likely to churn based on their historical usage behavior, demographic information, and subscription details. This predictive model will allow us to proactively target high-risk customers with personalized retention strategies, ultimately helping us enhance customer satisfaction, reduce churn rates, and optimize our business strategies. The goal is to create an effective solution that contributes to the long-term success of our company by fostering customer loyalty and engagement.

# `Data Description`
Dataset consists customer information for a customer churn prediction problem. It includes the following columns:

* **CustomerID**: Unique identifier for each customer.


* **Name**: Name of the customer.


* **Age: Age of the customer.**


* **Gender**: Gender of the customer (Male or Female).


* **Location**: Location where the customer is based, with options including Houston, Los Angeles, Miami, Chicago, and New York.


* **Subscription_Length_Months**: The number of months the customer has been subscribed.


* **Monthly_Bill**: Monthly bill amount for the customer.


* **Total_Usage_GB**: Total usage in gigabytes.


* **Churn**: A binary indicator (1 or 0) representing whether the customer has churned (1) or not (0).

# `Dashboards & Visualizations`

## PowerBI Dashboards

### Customer Analysis Dashboard Series
![Customer Churn PowerBI Dashboard 0](Screenshots/powerbi/dashboard0.png)
*Dashboard 0: Overview of Customer Metrics*

![Customer Churn PowerBI Dashboard 1](Screenshots/powerbi/dashboard1.png)
*Dashboard 1: Detailed Customer Segmentation*

![Customer Churn PowerBI Dashboard 2](Screenshots/powerbi/dashboard2.png)
*Dashboard 2: Risk Analysis and Predictions*

![Customer Churn PowerBI Dashboard 3](Screenshots/powerbi/dashboard3.png)
*Dashboard 3: Geographic and Demographic Insights*

### Main Churn Analytics Dashboards
![Customer Churn Dashboard](Screenshots/powerbi/main_dashboard.png)
*Main Dashboard: Comprehensive Churn Analytics*

![Customer Churn Dashboard 1](Screenshots/powerbi/main_dashboard1.png)
*Extended Dashboard: Advanced Metrics and KPIs*

## ETL Pipeline & CI/CD Infrastructure

### Airflow ETL Pipeline
![Airflow UI Sign In](Screenshots/infrastructure/airflow_login.png)
*Airflow Authentication Interface*

![Airflow ETL Pipeline Graph](Screenshots/infrastructure/airflow_graph.png)
*Customer Churn ETL Pipeline DAG Visualization*

### Jenkins CI/CD Pipeline
![Jenkins Sign In](Screenshots/infrastructure/jenkins_login.png)
*Jenkins Authentication Interface*

![Jenkins Pipeline](Screenshots/infrastructure/jenkins_pipeline.png)
*Customer Churn Prediction CI/CD Pipeline*

These dashboards and visualizations provide:
- Comprehensive customer churn analysis
- Real-time monitoring of key metrics
- Automated ETL pipeline status
- Continuous integration and deployment tracking
- Data-driven insights for decision making

## Customer Churn Analytics Dashboard

![Customer Churn Dashboard Overview](Screenshots/dashboard/images/dashboard1.png)

This comprehensive dashboard provides:
- Revenue risk analysis and trends
- Customer segmentation insights
- Churn prediction metrics
- Usage pattern analysis
- Demographic distribution

## Key Metrics and KPIs

![Key Performance Metrics](Screenshots/dashboard/images/dashboard2.png)

The dashboard tracks critical KPIs including:
- Monthly revenue trends
- Customer acquisition vs churn rates
- Risk distribution by customer segments
- Geographic distribution of customers
- Usage patterns and billing analysis

## Customer Journey Analysis

![Customer Journey Insights](Screenshots/dashboard/images/dashboard3.png)

Detailed analysis of:
- Customer lifecycle stages
- Risk factors at each stage
- Engagement metrics
- Retention indicators
- Behavioral patterns

These visualizations help stakeholders:
- Track and predict churn patterns
- Identify at-risk customers
- Optimize retention strategies
- Make data-driven decisions
- Monitor business performance

# `Teck Tech Used`
* **Python Programming Language**

Python serves as the primary programming language for data analysis, modeling, and implementation of machine learning algorithms due to its rich ecosystem of libraries and packages.

* **Pandas**

Pandas is used for data manipulation and analysis. It provides data structures and functions for effectively working with structured data, such as CSV files or databases.

* **NumPy**

NumPy is a fundamental package for numerical computing in Python. It provides support for large, multi-dimensional arrays and matrices, along with a wide range of mathematical functions to operate on these arrays.

* **Matplotlib and Seaborn**

Matplotlib is used for creating static, interactive, and animated visualizations in Python. Seaborn is built on top of Matplotlib and provides a high-level interface for creating informative and attractive statistical graphics.

* **Jupyter Notebook**

Jupyter Notebook is an interactive web-based tool that allows for creating and sharing documents containing live code, equations, visualizations, and narrative text. It is commonly used for data analysis and exploration.

* **Scikit-Learn (sklearn)**

Scikit-Learn is a machine learning library in Python that provides a wide range of tools for various machine learning tasks such as classification, regression, clustering, model selection, and more.

* **Random Forest Classifier**

Random Forest is an ensemble learning algorithm that combines multiple decision trees to create a more robust and accurate model. It's used for both classification and regression tasks.


* **Variance Inflation Factor (VIF)**

The VIF is used to detect multicollinearity among predictor variables in a regression analysis. It helps identify redundant variables that might negatively impact model performance.


* **Model Evaluation Metrics**

Various metrics like accuracy, precision, recall, F1-score, confusion matrix, ROC curve, and AUC (Area Under Curve) are used to assess the performance of the machine learning models.


* **Logistic Regression, Decision Tree, K-Nearest Neighbors (KNN), Support Vector Machine (SVM), Naive Bayes, AdaBoost, Gradient Boosting, XGBoost**

These are different classification algorithms used to build predictive models based on the given data. Each algorithm has its own strengths and weaknesses.


* **TensorFlow and Keras**

TensorFlow is an open-source machine learning framework developed by Google. Keras is a high-level neural networks API that runs on top of TensorFlow. They are used for building and training deep learning models.


* **Neural Networks**

Neural networks are used to model complex relationships in the data. They consist of layers of interconnected nodes that simulate the behavior of neurons in the human brain. Deep learning algorithms are based on neural networks.


* **StandardScaler**

StandardScaler is used for standardizing features by removing the mean and scaling to unit variance. It's an important preprocessing step in machine learning to ensure features are on similar scales.


* **Principal Component Analysis (PCA)**

PCA is a dimensionality reduction technique that transforms the data into a new coordinate system while preserving as much variance as possible. It's useful for reducing the complexity of high-dimensional data.


* **GridSearchCV**

GridSearchCV is used for hyperparameter tuning, where a set of hyperparameters are tested exhaustively to find the combination that produces the best performance for the model.


* **Cross-Validation**

Cross-validation is a technique used to evaluate the generalization performance of a model by splitting the dataset into multiple subsets (folds) for training and testing.


* **Early Stopping**

Early stopping is a regularization technique used in training neural networks. It stops training when the model's performance on a validation set starts deteriorating, preventing overfitting.

* **ModelCheckpoint**

ModelCheckpoint is a callback in Keras that saves the model's weights during training. It helps to save the best model based on a specific metric, allowing you to restore the model later.


* **ROC Curve and AUC (Receiver Operating Characteristic - Area Under Curve)**

ROC curve is a graphical representation of the trade-off between the true positive rate (sensitivity) and the false positive rate (1-specificity). AUC measures the area under the ROC curve and is used as a metric to evaluate binary classification models.


* **Standard Machine Learning Libraries**

The project utilizes standard machine learning libraries like SciPy and scikit-learn for various tasks including preprocessing, model selection, hyperparameter tuning, and model evaluation.


# `Deployment & CI/CD`

## DAG Workflow
The Customer Churn Prediction pipeline is implemented as an Apache Airflow DAG with the following steps:

1. **Data Extraction** (`extract_data`)
   - Pulls data from various sources (MySQL, CSV files)
   - Validates data integrity
   
2. **Data Preprocessing** (`preprocess_data`)
   - Handles missing values
   - Feature engineering
   - Data standardization
   
3. **Model Training** (`train_model`)
   - Trains the churn prediction model
   - Saves model artifacts
   
4. **Model Evaluation** (`evaluate_model`)
   - Calculates performance metrics
   - Generates evaluation reports
   
5. **Model Deployment** (`deploy_model`)
   - Updates the production model
   - Backs up previous model version

## Dependencies
- Python 3.9+
- Apache Airflow 2.7+
- Docker & Docker Compose
- Jenkins
- Required Python packages in `requirements.txt`

## Service Management

### Starting Services
1. Start Docker containers:
```bash
docker-compose up -d
```

2. Access services:
- Airflow UI: http://localhost:8080
- Jenkins: http://localhost:8081
- Model API

### Restarting Services
1. Restart all services:
```bash
docker-compose restart
```

2. Restart specific service:
```bash
docker-compose restart [service_name]
```

3. Full reset:
```bash
docker-compose down
docker-compose up -d
```

### Backup System
- Automated backups run daily at midnight
- Backup location: `./backups/YYYY-MM-DD/`
- Includes:
  - DAG configurations
  - Database snapshots
  - Model artifacts
  - Configuration files

### Monitoring
- Airflow logs: `./logs/airflow/`
- Application logs: `./logs/app/`
- Jenkins logs: `./logs/jenkins/`

## CI/CD Pipeline
The project uses Jenkins for continuous integration and deployment:

1. **Continuous Integration**
   - Automated testing on each commit
   - Code quality checks
   - Docker image building

2. **Continuous Deployment**
   - Automated deployment to staging
   - Manual approval for production
   - Automatic rollback on failure

3. **Monitoring**
   - Performance metrics tracking
   - Error rate monitoring
   - Resource usage alerts

# `Outcome`
The outcome of this customer churn prediction project involves developing a machine learning model to predict whether customers are likely to churn or not. This prediction is based on various customer attributes such as age, gender, location, subscription length, monthly bill, and total usage. The model's primary purpose is to assist in identifying customers who are at a higher risk of churning, enabling the business to take proactive measures to retain them. By using the trained model to predict churn, the company can allocate resources more effectively, personalize engagement strategies, and implement targeted retention efforts. Ultimately, the project's success is measured by the model's ability to make predictions, helping the company reduce churn rates, improve customer satisfaction, and optimize its customer retention strategies.

# Docker Hub and Firebase Information

## Docker Hub Repository
The Docker Hub repository for this project is located at [sudee19/customer-churn-prediction](https://hub.docker.com/r/sudee19/customer-churn-prediction).

## Firebase Hosting URL
The Firebase Hosting URL for this project is [Firebase Hosting URL].

## API Configuration

The project uses Firebase for secure API hosting and data storage. To configure:

1. Set up Firebase:
   - Create a new Firebase project
   - Enable Cloud Storage
   - Download your Firebase credentials

2. Configure environment variables:
   ```
   FIREBASE_PROJECT_ID=your-project-id
   FIREBASE_STORAGE_BUCKET=your-bucket-name
   ```

## API Endpoints

### Prediction API

- `GET /health` - Health check endpoint
- `POST /predict` - Single prediction endpoint
- `POST /batch_predict` - Batch prediction endpoint

Example prediction request:
```json
{
    "customer_id": "123",
    "tenure": 24,
    "monthly_charges": 65.5,
    "total_charges": 1500.0,
    "contract_type": "Month-to-month",
    "payment_method": "Electronic check",
    "internet_service": "Fiber optic"
}
```

## Environment Setup

1. Create a `.env` file with the following variables:
```
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_STORAGE_BUCKET=your-bucket-name
AIRFLOW_UID=50000
```

2. Set up GitHub Secrets for CI/CD:
- `DOCKER_USERNAME`
- `DOCKER_PASSWORD`
- `FIREBASE_CREDENTIALS`
