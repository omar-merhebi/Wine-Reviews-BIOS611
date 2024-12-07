library(tidyverse)
library(caret)

wine_reviews <- read.csv('data/processed/wine-reviews-tokenized.csv')

# Drop outliers (price <= 77)
wine_reviews <- wine_reviews %>%
  select(-X) %>%
  filter(Price <= 77)

# Convert "Year" to a factor because we don't want this treated as a numeric value but a categorical label
wine_reviews$Year <- as.factor(wine_reviews$Year)

# Now one-hot encode numerical values
onehot <- dummyVars(" ~ .", wine_reviews)
wine_reviews_nn <- data.frame(predict(onehot, newdata=wine_reviews))

write_csv(wine_reviews_nn, 'data/processed/wine-reviews-nn.csv')
