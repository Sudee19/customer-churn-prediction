# Load required libraries
library(readxl)
library(ggplot2)
library(dplyr)

# Read the dataset
dataset <- read_excel("C:/Users/SUDEEP MADAGONDA/OneDrive/Desktop/Customer Churn Prediction/customer_churn_large_dataset.xlsx")

# Remove duplicates
dataset <- unique(dataset)

# Create summary data grouped by Location and Churn
stacked_data <- dataset %>%
  group_by(Location, Churn) %>%
  summarise(
    Count = n(),
    .groups = 'drop'
  ) %>%
  arrange(Location, Churn)

# Calculate percentages
stacked_data <- stacked_data %>%
  group_by(Location) %>%
  mutate(Percentage = Count/sum(Count)*100)

# Create stacked column chart with labels
ggplot(stacked_data, aes(x = Location, y = Count, fill = Churn)) +
  geom_col(position = "stack") +
  geom_text(aes(label = sprintf("%.1f%%", Percentage)),
            position = position_stack(vjust = 0.5),
            color = "white") +
  scale_fill_manual(values = c("#8B0000", "#4B0082", "#006400")) +  # dark red, purple, dark green
  theme_dark() +
  theme(
    plot.background = element_rect(fill = "#1a1a1a"),
    panel.background = element_rect(fill = "#1a1a1a"),
    legend.background = element_rect(fill = "#1a1a1a"),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white"),
    plot.title = element_text(color = "white", hjust = 0.5),
    axis.text.x = element_text(color = "white", angle = 45, hjust = 1),
    axis.text.y = element_text(color = "white"),
    axis.title = element_text(color = "white"),
    panel.grid.major = element_line(color = "#333333"),
    panel.grid.minor = element_blank()
  ) +
  labs(
    title = "Customer Distribution by Location and Churn Status",
    x = "Location",
    y = "Number of Customers",
    fill = "Churn Status"
  )

