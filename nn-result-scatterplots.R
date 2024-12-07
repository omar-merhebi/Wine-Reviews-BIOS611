library(tidyverse)
library(Metrics)

# Here we create figures that look at the results of the neural networks
net_predictions <- read.csv('data/results/wine_predictions.csv')

price_mae <- round(mae(net_predictions$price, net_predictions$price_pred), 3)
points_mae <- round(mae(net_predictions$points, net_predictions$points_pred), 3)

# Scatter plots of predicted vs actual values
price_scatter <- net_predictions %>%
  ggplot(aes(x=price, y=price_pred)) +
  geom_point(color='lightblue') + theme_bw() +
  geom_abline(slope=1, color='red') +
  theme(panel.grid = element_blank()) +
  annotate("text", x=max(net_predictions$price)-1, 
           y=max(net_predictions$price_pred),
           label=paste("MAE: ", price_mae))

points_scatter <- net_predictions %>%
  ggplot(aes(x=points, y=points_pred)) + 
  geom_point(color='lightblue') + theme_bw() +
  geom_abline(slope=1, color='red') +
  theme(panel.grid = element_blank()) +
  annotate("text", x=max(net_predictions$points)-1, 
           y=max(net_predictions$points_pred),
           label=paste("MAE: ", points_mae))

ggsave('figures/price_prediction_scatterplot.png', plot=price_scatter)
ggsave('figures/points_prediction_scatterplot.png', plot=points_scatter)