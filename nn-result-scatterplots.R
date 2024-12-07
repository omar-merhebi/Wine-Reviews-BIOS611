library(tidyverse)

# Here we create figures that look at the results of the neural networks
net_predictions <- read.csv('data/results/wine_predictions.csv') %>%
  select(-X)

# Scatter plots of predicted vs actual values
net_predictions %>%
  ggplot(aes(x=price, y=price_pred)) +
  geom_point(color='lightblue') + theme_bw() +
  geom_abline(slope=1, color='red') +
  theme(panel.grid = element_blank())

net_predictions %>%
  ggplot(aes(x=points, y=points_pred)) + 
  geom_point(color='lightblue') + theme_bw() +
  geom_abline(slope=1, color='red')

# Boxplot comparison by continent
