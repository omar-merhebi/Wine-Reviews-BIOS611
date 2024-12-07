library(tidyverse)

prediction_data <- read.csv('data/results/wine_predictions_joined.csv') %>%
  drop_na()

price_comparison <- prediction_data %>%
  select(c(price, price_pred, Continent)) %>%
  pivot_longer(c(price, price_pred), names_to='type', values_to='value')

price_boxplots <- price_comparison %>%
  ggplot(aes(x=Continent, y=value, fill=type)) +
  geom_boxplot() +
  theme_bw() +
  theme(panel.grid = element_blank())

points_comparison <- prediction_data %>%
  select(c(points, points_pred, Continent)) %>%
  pivot_longer(c(points, points_pred), names_to='type', values_to='value')

points_boxplots <- points_comparison %>%
  ggplot(aes(x=Continent, y=value, fill=type)) +
  geom_boxplot() +
  theme_bw() +
  theme(panel.grid = element_blank())

points_boxplots
