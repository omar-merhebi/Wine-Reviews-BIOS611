library(tidyverse)

wine_reviews <- read_csv('data/processed/wine-reviews-tokenized.csv')

wine_reviews <- wine_reviews %>%
  rename(ID = `...1`)

wine_reviews_for_pca <- wine_reviews %>%
  select(-c(Country, Points, Price, Province, Taster, Variety, Year))

gathered_wine_reviews <- wine_reviews_for_pca %>%
  gather(key="word", value="count", -ID)

gathered_wine_total_counts <- gathered_wine_reviews %>%
  select(-ID) %>%
  group_by(word) %>%
  summarise(total_count=sum(count))

top_25_words_plot <- gathered_wine_total_counts %>%
  top_n(25, wt=total_count) %>%
  ggplot(aes(x=reorder(word, -total_count), y=total_count)) +
  geom_col(fill='lightblue') +
  theme_bw() +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1),
        panel.grid = element_blank()) +
  labs(x="Word", y="Total Count")

ggsave('figures/top_25_words.png', plot=top_25_words_plot)
