library(tidyverse)

wine_reviews <- read.csv('data/processed/wine-reviews-clean.csv')

hist <- wine_reviews %>%
  ggplot(aes(x=Continent, fill=Continent)) +
  geom_bar() +theme_bw() +
  theme(panel.grid = element_blank())

ggsave('figures/histogram-by-continent.png', hist)
