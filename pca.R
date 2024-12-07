library(tidyverse)
library(ggfortify)

wine_reviews <- read_csv('data/processed/wine-reviews-tokenized.csv')

wine_reviews <- wine_reviews %>%
  rename(ID = `...1`)

wine_reviews<- wine_reviews %>%
  select(-c(Points, Price, Taster, Variety, Year))

pca <- wine_reviews %>%
  select(-c(ID, Country, Continent)) %>%
  prcomp(scale. = TRUE)

pca <- autoplot(pca, data=wine_reviews, color='Continent') + theme_bw()

ggsave('figures/pca-by-continent.png', plot=pca)
