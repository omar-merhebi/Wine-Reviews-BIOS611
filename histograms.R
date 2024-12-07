library(tidyverse)

wine_reviews <- read.csv('data/processed/wine-reviews-clean.csv')

continents <- wine_reviews %>%
  ggplot(aes(x=Continent, fill=Continent)) +
  geom_bar() +theme_bw() +
  theme(panel.grid = element_blank())

prices_w_outliers <- wine_reviews %>%
  ggplot(aes(x=price)) +
  geom_histogram() + theme_bw() +
  theme(panel.grid = element_blank())

# Calculate upper outlier threshhold 
Q1 <- quantile(wine_reviews$price, 0.25)
Q3 <- quantile(wine_reviews$price, 0.75)
IQR <- Q3 - Q1

threshhold <- Q3 + 1.5 * IQR

prices_w_outliers <- prices_w_outliers + 
  geom_vline(xintercept = threshhold, color='red', linetype='dashed') +
  annotate("text", x=threshhold+10, color='red', y=40000, 
           label=paste(threshhold))

# Now do the histogram after outlier removal
prices <- wine_reviews %>%
  filter(price <= 77) %>%
  ggplot(aes(x=price)) +
  geom_histogram() + theme_bw() +
  theme(panel.grid = element_blank())

ggsave('figures/histogram-by-continent.png', continents)
ggsave('figures/histogram-by-price-full.png', prices_w_outliers)
ggsave('figures/histogram-by-price-no-outliers.png', prices)
