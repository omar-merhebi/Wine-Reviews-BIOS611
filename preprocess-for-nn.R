library(tidyverse)
library(caret)

wine_reviews <- read.csv('data/processed/wine-reviews-tokenized.csv')

wine_reviews <- wine_reviews %>%
  select(-X)

# Need to process for neural network, so start by standardizing price and points
min_max_normalization <- function(column) {
  return ((column - min(column)) / (max(column) - min(column)))
}

wine_reviews$Price <- min_max_normalization(wine_reviews$Price)
wine_reviews$Points <- min_max_normalization(wine_reviews$Points)

# Now also convert "Year" to a factor because we don't want this treated as a numeric value but a categorical label
wine_reviews$Year <- as.factor(wine_reviews$Year)

# Now one-hot encode numerical values
onehot <- dummyVars(" ~ .", wine_reviews)
wine_reviews_nn <- data.frame(predict(onehot, newdata=wine_reviews))

write_csv(wine_reviews_nn, 'data/processed/wine-reviews-nn.csv')
