# Load required libraries
library(readxl)
library(ggplot2)
library(dplyr)

# Read the dataset
dataset <- read_excel("C:/Users/SUDEEP MADAGONDA/OneDrive/Desktop/Customer Churn Prediction/customer_churn_large_dataset.xlsx")

# Remove duplicates
dataset <- unique(dataset)

# Create summary data for the pie chart (example using Location)
location_summary <- dataset %>%
  count(Location) %>%
  mutate(percentage = n / sum(n) * 100)

# Create pie chart with dark green theme
pie_chart <- ggplot(location_summary, aes(x = "", y = percentage, fill = Location)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_dark() +
  scale_fill_manual(values = colorRampPalette(c("#004d00", "#00b300"))(length(unique(dataset$Location)))) +
  theme(
    plot.background = element_rect(fill = "#1a1a1a"),
    panel.background = element_rect(fill = "#1a1a1a"),
    legend.background = element_rect(fill = "#1a1a1a"),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white"),
    plot.title = element_text(color = "white", hjust = 0.5),
    panel.grid = element_blank()
  ) +
  labs(
    title = "Customer Distribution by Location",
    fill = "Location"
  ) +
  geom_text(aes(label = sprintf("%.1f%%", percentage)), 
            position = position_stack(vjust = 0.5),
            color = "white")

# Display the plot
print(pie_chart)

