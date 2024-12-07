library(tidyverse)

original_data <- read.csv('data/processed/wine-reviews-clean.csv')
nn_results <- read.csv('data/results/wine_predictions.csv')

to_join <- original_data %>%
  mutate(ID = row_number()) %>%
  select(c(country, variety, year, Continent, ID))

joined_data <- nn_results %>%
  left_join(to_join, by='ID')

write_csv(joined_data, 'data/results/wine_predictions_joined.csv')