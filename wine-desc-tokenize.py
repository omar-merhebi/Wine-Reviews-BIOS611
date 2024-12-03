import nltk
import pandas as pd
import re
import string

from collections import Counter

nltk.download('punkt')
nltk.download('punkt_tab')
nltk.download('stopwords')
nltk.download('wordnet')

STOP_WORDS = set(nltk.corpus.stopwords.words('english'))


def main():
    wine_reviews = pd.read_csv('data/processed/wine-reviews-clean.csv')
    wine_word_counts = get_word_counts_per_wine(wine_reviews)
    total_word_counts = get_total_word_count(wine_word_counts)

    # print(total_word_counts)


def get_total_word_count(wine_word_counts):
    # We get the total word counts for each word across all wine descriptions.
    total_word_count = Counter()

    for word_counts in wine_word_counts:
        print(word_counts)
        total_word_count.update(word_counts)

    return total_word_count


def get_word_counts_per_wine(wine_reviews):
    wine_word_count = {}

    for index, row in wine_reviews.iterrows():
        description = row['description']

        word_counts = tokenize_and_count(description)

        wine_word_count[index] = word_counts

    return wine_word_count


def tokenize_and_count(description):
    # make lowercase and get rid of punctuation
    text = description.translate(
        str.maketrans("", "", string.punctuation)).lower()

    # remove numbers (this usually indicates a year for the wine which)
    # we already extracted from the title.
    text = re.sub(r'\d+', '', text)

    # tokenize
    tokens = nltk.word_tokenize(text)

    # lemmatize words so that associated words get grouped together
    # For example, group "cherry" and "cherries" or "beauty" and "beautiful"
    lemmatizer = nltk.stem.WordNetLemmatizer()
    tokens = [lemmatizer.lemmatize(token) for token in tokens]

    # remove stop words
    tokens = [word for word in tokens if word not in STOP_WORDS]

    word_counts = Counter(tokens)

    return word_counts


if __name__ == '__main__':
    main()
