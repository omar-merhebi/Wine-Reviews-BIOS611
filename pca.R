library(tidyverse)

wine_reviews <- read_csv('data/processed/wine-reviews-tokenized.csv')

wine_reviews <- wine_reviews %>%
  rename(ID = `...1`)

wine_reviews_for_pca <- wine_reviews %>%
  select(-c(Country, Points, Price, Province, Taster, Variety, Year))

gathered_wine_reviews <- wine_reviews_for_pca %>%
  gather(key="word", value="count", -ID)

pca <- gathered_wine_reviews %>%
  select(-ID) %>%
  prcomp(scale. = TRUE)

autplot(pca) + theme_bw()