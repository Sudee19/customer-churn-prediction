# Install and load required packages
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("lubridate")) install.packages("lubridate")
if (!require("scales")) install.packages("scales")

library(tidyverse)
library(lubridate)
library(scales)

# Create sample data
set.seed(123)

# Customer data
customers <- data.frame(
  customer_id = 1:1000,
  signup_date = sample(seq(as.Date('2023-01-01'), as.Date('2024-12-31'), by="day"), 1000, replace=TRUE),
  segment = sample(c("Enterprise", "Mid-Market", "SMB"), 1000, replace=TRUE, prob=c(0.2, 0.3, 0.5)),
  industry = sample(c("Technology", "Retail", "Healthcare", "Finance", "Manufacturing"), 1000, replace=TRUE),
  monthly_revenue = round(rlnorm(1000, meanlog=8, sdlog=1)),
  risk_score = round(runif(1000, 1, 100)),
  satisfaction_score = round(runif(1000, 1, 10)),
  usage_frequency = round(rlnorm(1000, meanlog=2, sdlog=0.5)),
  support_tickets = rpois(1000, 3),
  days_since_last_activity = round(runif(1000, 0, 90))
)

# Add churn status
customers$churned <- ifelse(
  customers$risk_score > 70 & 
    customers$satisfaction_score < 5 & 
    customers$days_since_last_activity > 60,
  TRUE, FALSE
)

# Time series data for monthly metrics
monthly_metrics <- data.frame(
  date = seq(as.Date('2023-01-01'), as.Date('2024-12-31'), by="month"),
  new_customers = round(rnorm(24, mean=50, sd=10)),
  churned_customers = round(rnorm(24, mean=30, sd=8)),
  revenue = round(rnorm(24, mean=500000, sd=50000))
)

# Colors for PowerBI
colors <- c(
  darkblue = "#1A237E",
  darkred = "#B71C1C",
  purple = "#4A148C",
  red = "#D32F2F",
  darkgreen = "#1B5E20"
)

# 1. Customer Risk Distribution (Histogram)
risk_dist <- ggplot(customers, aes(x=risk_score)) +
  geom_histogram(fill=colors["darkblue"], bins=30) +
  theme_minimal() +
  labs(title="Customer Risk Score Distribution",
       x="Risk Score", y="Count") +
  theme(plot.background = element_rect(fill = "#121212"),
        panel.background = element_rect(fill = "#1E1E1E"),
        text = element_text(color = "white"))

# 2. Monthly Revenue Trend (Line Chart)
revenue_trend <- ggplot(monthly_metrics, aes(x=date, y=revenue)) +
  geom_line(color=colors["purple"], size=1) +
  geom_point(color=colors["purple"]) +
  theme_minimal() +
  labs(title="Monthly Revenue Trend",
       x="Date", y="Revenue") +
  scale_y_continuous(labels=scales::dollar_format()) +
  theme(plot.background = element_rect(fill = "#121212"))

# 3. Churn by Segment (Bar Chart)
segment_churn <- customers %>%
  group_by(segment) %>%
  summarise(churn_rate = mean(churned) * 100) %>%
  ggplot(aes(x=segment, y=churn_rate, fill=segment)) +
  geom_bar(stat="identity") +
  scale_fill_manual(values=c(colors["darkred"], colors["purple"], colors["darkblue"])) +
  theme_minimal() +
  labs(title="Churn Rate by Segment",
       x="Segment", y="Churn Rate (%)")

# 4. Customer Satisfaction vs Risk (Scatter Plot)
satisfaction_risk <- ggplot(customers, aes(x=satisfaction_score, y=risk_score)) +
  geom_point(aes(color=churned), alpha=0.6) +
  scale_color_manual(values=c(colors["darkgreen"], colors["darkred"])) +
  theme_minimal() +
  labs(title="Satisfaction vs Risk Score",
       x="Satisfaction Score", y="Risk Score")

# 5. Industry Distribution (Donut Chart)
industry_dist <- customers %>%
  count(industry) %>%
  ggplot(aes(x="", y=n, fill=industry)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  theme_void() +
  scale_fill_manual(values=c(colors["darkblue"], colors["purple"], 
                            colors["darkred"], colors["red"], colors["darkgreen"]))

# 6. Monthly Customer Movement (Area Chart)
customer_movement <- ggplot(monthly_metrics, aes(x=date)) +
  geom_area(aes(y=new_customers), fill=colors["darkgreen"], alpha=0.7) +
  geom_area(aes(y=churned_customers), fill=colors["darkred"], alpha=0.7) +
  theme_minimal() +
  labs(title="Customer Movement Over Time",
       x="Date", y="Number of Customers")

# 7. Support Tickets by Usage (Box Plot)
usage_tickets <- ggplot(customers, aes(x=cut_number(usage_frequency, 5), y=support_tickets)) +
  geom_boxplot(fill=colors["purple"]) +
  theme_minimal() +
  labs(title="Support Tickets by Usage Level",
       x="Usage Frequency Quintile", y="Number of Support Tickets")

# 8. Risk Score Timeline (Time Series)
risk_timeline <- customers %>%
  group_by(signup_date) %>%
  summarise(avg_risk = mean(risk_score)) %>%
  ggplot(aes(x=signup_date, y=avg_risk)) +
  geom_line(color=colors["darkred"]) +
  geom_smooth(method="loess", color=colors["darkblue"]) +
  theme_minimal() +
  labs(title="Average Risk Score Over Time",
       x="Date", y="Average Risk Score")

# 9. Revenue by Segment and Industry (Treemap)
# Note: For PowerBI, use the built-in treemap visualization
revenue_segment_industry <- customers %>%
  group_by(segment, industry) %>%
  summarise(total_revenue = sum(monthly_revenue))

# 10. Customer Activity Heatmap
activity_heatmap <- customers %>%
  count(risk_score = cut_number(risk_score, 10),
        activity = cut_number(days_since_last_activity, 10)) %>%
  ggplot(aes(x=risk_score, y=activity, fill=n)) +
  geom_tile() +
  scale_fill_gradient(low=colors["darkgreen"], high=colors["darkred"]) +
  theme_minimal() +
  labs(title="Customer Activity vs Risk Heatmap",
       x="Risk Score Decile", y="Days Since Last Activity Decile")

# Export the data for PowerBI
write.csv(customers, "customer_data.csv", row.names=FALSE)
write.csv(monthly_metrics, "monthly_metrics.csv", row.names=FALSE)
write.csv(revenue_segment_industry, "revenue_segments.csv", row.names=FALSE)

# Note: In PowerBI Desktop
# 1. Import this R script
# 2. Use the exported CSV files as data sources
# 3. Create visualizations using PowerBI's built-in tools
# 4. Apply the custom color scheme defined above
# 5. Set the background to dark theme
# 6. Use the PowerBI theme editor to apply consistent formatting
