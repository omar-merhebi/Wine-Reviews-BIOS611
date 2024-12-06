library(tidyverse)

wine_reviews <- read.csv('data/processed/wine-reviews-clean.csv')

hist <- wine_reviews %>%
  ggplot(aes(x=continent)) +
  geom_histogram(stat = 'count')

hist
