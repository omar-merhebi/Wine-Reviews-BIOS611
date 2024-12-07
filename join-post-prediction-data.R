library(tidyverse)

original_data <- read.csv('data/processed/wine-reviews-clean.csv')
nn_results <- read.csv('data/results/wine_predictions.csv')

joined_data <- nn_results %>%
  left_join(original_data, by=)