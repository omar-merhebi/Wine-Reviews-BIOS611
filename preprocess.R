library(tidyverse)

wine_reviews <- read.csv('data/raw/wine-reviews.csv')

wine_reviews <- wine_reviews %>%
  select(-c('X', 'designation', 'region_1', 'region_2', 'taster_name', 'winery')) %>%
  mutate(year = str_extract(title, "20[0-2][1-9]")) %>%
  filter(taster_twitter_handle != "") %>%
  rename(taster = taster_twitter_handle) %>%
  mutate(taster = str_extract(taster, "\\w+")) %>%
  drop_na()

write_csv(wine_reviews, 'data/processed/wine-reviews-clean.csv')