library(tidyverse)

wine_reviews <- read.csv('data/raw/wine-reviews.csv')

wine_reviews <- wine_reviews %>%
  mutate(year = str_extract(title, "20[0-2][1-9]")) %>%
  select(-c('X', 'designation', 'region_1', 'region_2', 'taster_name', 'winery', 'title')) %>%
  filter(!is.na(country) & country != '') %>%
  filter(taster_twitter_handle != "") %>%
  rename(taster = taster_twitter_handle) %>%
  mutate(taster = str_extract(taster, "\\w+")) %>%
  drop_na()

write_csv(wine_reviews, 'data/processed/wine-reviews-clean.csv')
