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

# PCA excluding europe

wine_reviews_no_europe <- wine_reviews %>%
  filter(Continent != 'Europe')

pca_no_europe <- wine_reviews_no_europe %>%
  select(-c(ID, Country, Continent)) %>%
  prcomp(scale. = TRUE)

pca_no_europe <- autoplot(pca_no_europe, data=wine_reviews_no_europe, color='Continent') + theme_bw()

ggsave('figures/pca-by-continent.png', plot=pca)
ggsave('figures/pca-by-continent-exclude-eur.png', plot=pca_no_europe)
