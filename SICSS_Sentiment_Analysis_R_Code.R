#install.packages("vader")
#install.packages("readr")
#install.packages("dplyr")
#install.packages("ggplot2")

# Load libraries
library(vader)
library(readr)
library(dplyr)
library(ggplot2)

# Load your CSV file (replace with the actual file path)
data <- read_csv("comment_text.csv", show_col_types = FALSE)  

# Apply VADER sentiment analysis
sentiment_scores <- vader_df(data$text)

# Combine scores with original data
data <- data %>%
  mutate(compound = sentiment_scores$compound,
         sentiment = case_when(
           compound >= 0.05 ~ "Positive",
           compound <= -0.05 ~ "Negative",
           TRUE ~ "Neutral"
         ))

# Plot sentiment distribution
plot <- ggplot(data, aes(x = sentiment, fill = sentiment)) +
  geom_bar() +
  labs(title = "Distribution of Sentiment Categories",
       x = "Sentiment",
       y = "Count") +
  theme_minimal()

# Display the plot
print(plot)

# Save the plot to working directory
ggsave("sentiment_distribution_plot.png", plot = plot, width = 8, height = 6)