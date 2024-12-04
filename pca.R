library(tidyverse)
library(ggfortify)

wine_reviews <- read_csv('data/processed/wine-reviews-tokenized.csv')

wine_reviews <- wine_reviews %>%
  rename(ID = `...1`)

wine_reviews<- wine_reviews %>%
  select(-c(Points, Price, Taster, Variety, Year))

# Group by continent cause there are too many countries to color code
north_america <- c('Canada', 'Mexico', 'US')
south_america <- c('Argentina', 'Brazil', 'Chile', 'Peru', 'Uruguay')
asia <- c('Armenia', 'China', 'Georgia', 'India', 'Israel', 'Lebanon', 'Turkey')
africa <- c('Morocco', 'South Africa')
europe <- c('Austria', 'Bosnia and Herzegovina', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'England', 'France',
            'Germany', 'Greece', 'Hungary', 'Italy', 'Luxembourg', 'Macedonia', 'Moldova', 'Portugal', 'Romania',
            'Serbia', 'Slovenia', 'Spain', 'Switzerland', 'Ukraine')
oceania <- c('Australia', 'New Zealand')

# add continent column
wine_reviews <- wine_reviews %>%
  mutate(Continent = case_when(
    Country %in% north_america ~ "North America",
    Country %in% south_america ~ "South America",
    Country %in% asia ~ "Asia",
    Country %in% africa ~ "Africa",
    Country %in% europe ~ "Europe",
    Country %in% oceania ~ "Oceania"
  ))

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
