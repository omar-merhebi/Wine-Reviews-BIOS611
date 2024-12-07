library(tidyverse)

prediction_data <- read.csv('data/results/wine_predictions_joined.csv')

price_comparison <- prediction_data %>%
  select(c(price, price_pred, Continent)) %>%
  pivot_longer(c(price, price_pred), names_to='type', values_to='value')

price_comparison %>%
  ggplot(aes(x=Continent, y=value, fill=type)) +
  geom_boxplot()
