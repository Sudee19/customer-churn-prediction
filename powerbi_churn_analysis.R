# Install and load required packages
required_packages <- c("tidyverse", "lubridate", "scales", "corrplot", "randomForest", "cluster")
for(pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) install.packages(pkg)
}

# Load libraries
library(tidyverse)
library(lubridate)
library(scales)
library(corrplot)
library(randomForest)
library(cluster)

# Read the customer churn dataset
churn_data <- read.xlsx(r"C:\Users\SUDEEP MADAGONDA\OneDrive\Desktop\Customer Churn Prediction\customer_churn_large_dataset.xlsx")

# Data preprocessing
churn_data <- churn_data %>%
  mutate(
    Churn = factor(Churn, levels = c("No", "Yes")),
    MonthlyCharges = as.numeric(MonthlyCharges),
    TotalCharges = as.numeric(gsub(" ", "", TotalCharges)),
    tenure_group = cut(tenure, 
                      breaks = c(-Inf, 12, 24, 36, 48, Inf),
                      labels = c("0-12 months", "13-24 months", "25-36 months", "37-48 months", "48+ months"))
  )

# Custom color palette
colors <- c(
  darkblue = "#1A237E",
  darkred = "#B71C1C",
  purple = "#4A148C",
  red = "#D32F2F",
  darkgreen = "#1B5E20"
)

# 1. CUSTOMER DEMOGRAPHICS DASHBOARD
# Age distribution
age_dist <- churn_data %>%
  mutate(age_group = cut(tenure, breaks = 5)) %>%
  ggplot(aes(x = age_group, fill = Churn)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c(colors["darkblue"], colors["darkred"])) +
  theme_minimal() +
  labs(title = "Customer Age Distribution by Churn Status",
       x = "Age Group", y = "Count")

# Gender distribution
gender_dist <- churn_data %>%
  ggplot(aes(x = gender, fill = Churn)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c(colors["purple"], colors["red"])) +
  theme_minimal() +
  labs(title = "Churn Rate by Gender",
       x = "Gender", y = "Proportion")

# 2. FINANCIAL METRICS DASHBOARD
# Monthly charges distribution
charges_dist <- ggplot(churn_data, aes(x = MonthlyCharges, fill = Churn)) +
  geom_density(alpha = 0.7) +
  scale_fill_manual(values = c(colors["darkgreen"], colors["darkred"])) +
  theme_minimal() +
  labs(title = "Monthly Charges Distribution",
       x = "Monthly Charges", y = "Density")

# Revenue analysis
revenue_analysis <- churn_data %>%
  group_by(tenure_group) %>%
  summarise(
    total_revenue = sum(MonthlyCharges),
    avg_revenue = mean(MonthlyCharges),
    churn_rate = mean(Churn == "Yes")
  )

# 3. SERVICE USAGE DASHBOARD
# Service adoption
service_adoption <- churn_data %>%
  select(InternetService, OnlineSecurity, OnlineBackup, DeviceProtection, TechSupport, StreamingTV, StreamingMovies) %>%
  gather(key = "Service", value = "Status") %>%
  ggplot(aes(x = Service, fill = Status)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c(colors["darkblue"], colors["purple"], colors["darkred"])) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Service Adoption Rates",
       x = "Service", y = "Proportion")

# 4. CHURN PREDICTION DASHBOARD
# Prepare data for prediction
model_data <- churn_data %>%
  select(Churn, MonthlyCharges, tenure, InternetService, Contract, PaymentMethod) %>%
  mutate_if(is.character, as.factor)

# Train Random Forest model
rf_model <- randomForest(Churn ~ ., data = model_data, ntree = 100)
importance_scores <- importance(rf_model)

# Feature importance plot
feature_importance <- as.data.frame(importance_scores) %>%
  rownames_to_column("Feature") %>%
  ggplot(aes(x = reorder(Feature, MeanDecreaseGini), y = MeanDecreaseGini)) +
  geom_bar(stat = "identity", fill = colors["purple"]) +
  coord_flip() +
  theme_minimal() +
  labs(title = "Feature Importance in Churn Prediction",
       x = "Feature", y = "Importance Score")

# 5. CUSTOMER SEGMENTATION DASHBOARD
# Prepare data for clustering
cluster_data <- churn_data %>%
  select(tenure, MonthlyCharges, TotalCharges) %>%
  scale()

# Perform k-means clustering
k <- 4
kmeans_result <- kmeans(cluster_data, centers = k)
churn_data$Cluster <- as.factor(kmeans_result$cluster)

# Cluster visualization
cluster_viz <- ggplot(churn_data, aes(x = MonthlyCharges, y = tenure, color = Cluster)) +
  geom_point(alpha = 0.6) +
  scale_color_manual(values = c(colors["darkblue"], colors["darkred"], 
                               colors["purple"], colors["darkgreen"])) +
  theme_minimal() +
  labs(title = "Customer Segments",
       x = "Monthly Charges", y = "Tenure")

# 6. CONTRACT ANALYSIS DASHBOARD
# Contract type distribution
contract_dist <- ggplot(churn_data, aes(x = Contract, fill = Churn)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c(colors["darkblue"], colors["darkred"])) +
  theme_minimal() +
  labs(title = "Churn by Contract Type",
       x = "Contract Type", y = "Count")

# 7. PAYMENT BEHAVIOR DASHBOARD
# Payment method analysis
payment_analysis <- churn_data %>%
  group_by(PaymentMethod) %>%
  summarise(
    churn_rate = mean(Churn == "Yes"),
    avg_monthly_charges = mean(MonthlyCharges),
    customer_count = n()
  )

# 8. CUSTOMER LIFETIME VALUE DASHBOARD
# Calculate CLV
churn_data <- churn_data %>%
  mutate(
    CLV = TotalCharges * (1 - as.numeric(Churn == "Yes") * 0.5)
  )

clv_dist <- ggplot(churn_data, aes(x = CLV, fill = Churn)) +
  geom_histogram(bins = 30, alpha = 0.7) +
  scale_fill_manual(values = c(colors["darkblue"], colors["darkred"])) +
  theme_minimal() +
  labs(title = "Customer Lifetime Value Distribution",
       x = "CLV", y = "Count")

# 9. SERVICE QUALITY DASHBOARD
# Tech support impact
tech_support_impact <- churn_data %>%
  group_by(TechSupport, InternetService) %>%
  summarise(
    churn_rate = mean(Churn == "Yes"),
    customer_count = n()
  )

# 10. RETENTION ANALYSIS DASHBOARD
# Tenure impact on churn
tenure_impact <- ggplot(churn_data, aes(x = tenure_group, fill = Churn)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c(colors["darkblue"], colors["darkred"])) +
  theme_minimal() +
  labs(title = "Churn Rate by Tenure Group",
       x = "Tenure Group", y = "Proportion")

# Export processed data for PowerBI
write.csv(churn_data, "processed_churn_data.csv", row.names = FALSE)
write.csv(revenue_analysis, "revenue_analysis.csv", row.names = FALSE)
write.csv(payment_analysis, "payment_analysis.csv", row.names = FALSE)
write.csv(tech_support_impact, "tech_support_impact.csv", row.names = FALSE)

# Create a list of all visualizations
viz_list <- list(
  demographics = list(age_dist, gender_dist),
  financial = list(charges_dist, revenue_analysis),
  services = list(service_adoption),
  prediction = list(feature_importance),
  segmentation = list(cluster_viz),
  contracts = list(contract_dist),
  payments = payment_analysis,
  clv = list(clv_dist),
  service_quality = tech_support_impact,
  retention = list(tenure_impact)
)

# PowerBI Dashboard Instructions
# 1. Import the processed CSV files into PowerBI
# 2. Create separate dashboard pages for each analysis perspective
# 3. Apply the custom color scheme
# 4. Use PowerBI's built-in features for interactivity
# 5. Add drill-through capabilities between dashboards
# 6. Enable cross-filtering between visualizations
# 7. Add DAX measures for advanced analytics

# Dashboard Layout Suggestions:
# 1. Customer Demographics Dashboard
#    - Age Distribution
#    - Gender Distribution
#    - Geographic Distribution (if available)
#    - Key Demographics KPIs

# 2. Financial Metrics Dashboard
#    - Monthly Charges Distribution
#    - Revenue Analysis by Tenure
#    - Payment Method Distribution
#    - Financial KPIs

# 3. Service Usage Dashboard
#    - Service Adoption Rates
#    - Service Combinations
#    - Usage Patterns
#    - Service-related KPIs

# 4. Churn Prediction Dashboard
#    - Feature Importance
#    - Prediction Results
#    - Risk Scores
#    - Prediction Accuracy Metrics

# 5. Customer Segmentation Dashboard
#    - Cluster Visualization
#    - Segment Profiles
#    - Segment-specific Metrics
#    - Migration Patterns

# 6. Contract Analysis Dashboard
#    - Contract Type Distribution
#    - Contract Length Analysis
#    - Upgrade/Downgrade Patterns
#    - Contract-related KPIs

# 7. Payment Behavior Dashboard
#    - Payment Method Analysis
#    - Payment Timing
#    - Payment Amount Patterns
#    - Payment-related KPIs

# 8. Customer Lifetime Value Dashboard
#    - CLV Distribution
#    - CLV by Segment
#    - CLV Trends
#    - Value-based KPIs

# 9. Service Quality Dashboard
#    - Tech Support Impact
#    - Service Issues
#    - Resolution Rates
#    - Quality-related KPIs

# 10. Retention Analysis Dashboard
#    - Tenure Impact
#    - Retention Rates
#    - Churn Triggers
#    - Retention KPIs

