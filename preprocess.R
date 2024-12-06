library(tidyverse)

wine_reviews <- read.csv('data/raw/wine-reviews.csv')

wine_reviews <- wine_reviews %>%
  mutate(year = str_extract(title, "20[0-2][1-9]")) %>%
  select(-c('X', 'designation', 'region_1', 'region_2', 'taster_name', 'winery', 'title', 'province')) %>%
  filter(!is.na(country) & country != '') %>%
  filter(taster_twitter_handle != "") %>%
  rename(taster = taster_twitter_handle) %>%
  mutate(taster = str_extract(taster, "\\w+")) %>%
  drop_na()

# Let's drop some outliers in terms of price.
# Any wine over $500 will be considered an outlier 
wine_reviews <- wine_reviews %>%
  filter(price <= 500)

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
    country %in% north_america ~ "North America",
    country %in% south_america ~ "South America",
    country %in% asia ~ "Asia",
    country %in% africa ~ "Africa",
    country %in% europe ~ "Europe",
    country %in% oceania ~ "Oceania"
  ))

write_csv(wine_reviews, 'data/processed/wine-reviews-clean.csv')
