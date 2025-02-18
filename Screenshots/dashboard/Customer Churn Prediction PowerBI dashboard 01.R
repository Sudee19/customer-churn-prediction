# Install and load required packages
if (!require(readxl)) install.packages("readxl")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

library(readxl)
library(ggplot2)
library(dplyr)

# Read data
dataset <- read_excel("C:/Users/SUDEEP MADAGONDA/OneDrive/Desktop/Customer Churn Prediction/customer_churn_large_dataset.xlsx")

# Create churn summary
churn_summary <- dataset %>%
  group_by(Churn) %>%
  summarise(count = n()) %>%
  mutate(
    percentage = count/sum(count) * 100,
    label = paste0(round(percentage, 1), "%"),
    ypos = cumsum(percentage) - percentage/2
  )

# Create donut chart with custom theme
p <- ggplot(churn_summary, aes(x = 2, y = percentage, fill = as.factor(Churn))) +
  # Add background
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf, 
           fill = "grey20", alpha = 0.5) +
  # Main donut chart
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  scale_fill_manual(
    values = c("darkgreen", "darkred"),
    labels = c("Not Churned", "Churned"),
    name = "Customer Status"
  ) +
  # Add percentage labels
  geom_text(aes(
    y = ypos,
    label = label
  ),
  color = "white",
  size = 5,
  fontface = "bold"
  ) +
  # Add count labels
  geom_text(aes(
    y = ypos,
    label = paste("\n\n", count, " customers"),
  ),
  color = "white",
  size = 4
  ) +
  # Customize theme
  theme_minimal() +
  labs(
    title = "Customer Churn Distribution",
    subtitle = paste("Total Customers:", sum(churn_summary$count))
  ) +
  theme(
    plot.background = element_rect(fill = "grey15", color = NA),
    panel.background = element_rect(fill = "grey15", color = NA),
    plot.title = element_text(hjust = 0.5, size = 16, color = "white", face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, size = 12, color = "white"),
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "bottom",
    legend.background = element_rect(fill = "grey15"),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white")
  ) +
  xlim(0.5, 2.5)

# Display plot
print(p)

# Save plot with transparent background
ggsave("churn_donut.png", p, width = 10, height = 10, dpi = 300, bg = "transparent")

