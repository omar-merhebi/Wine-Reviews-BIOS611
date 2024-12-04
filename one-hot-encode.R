library(tidyverse)
library(caret)

wine_reviews <- read.csv('data/processed/wine-reviews-tokenized.csv')

wine_reviews <- wine_reviews %>%
  rename('ID' = 'X')

# Need to process for neural network, so one-hot encode categorical values
onehot <- dummyVars(" ~ .", wine_reviews)
wine_reviews_onehot <- data.frame(predict(onehot, newdata=wine_reviews))

write_csv(wine_reviews_onehot, 'data/processed/wine-reviews-onehot.csv')
