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

# we are going to add certain words we also don't want into STOP_WORDS, such
# as "wine", "blend", "finish".

other_unwanted_words =['wine', 'finish', 'blend', 'aroma', 'palate', 
                       'drink', 'red', 'white']

STOP_WORDS.update(other_unwanted_words)

def main():
    wine_reviews = pd.read_csv('data/processed/wine-reviews-clean.csv')
    wine_word_counts = get_word_counts_per_wine(wine_reviews)
    total_word_counts = get_total_word_count(wine_word_counts)

    # we want to filter down to words that have a word count of at least
    # 1000, as there are over 80,000 wines in the cleaned dataset and we
    # want to make sure we don't have too many words that are only present in
    # a few wines

    filtered_words = [word for word, count in total_word_counts.items()
                      if count >= 1000]

    word_vectors = convert_to_vectors(wine_word_counts, filtered_words)

    # We turn these word counts into columns and append them to the existing df

    word_columns = pd.DataFrame.from_dict(word_vectors, orient='index',
                                          columns=filtered_words)
    
    # Some of the new words (like year and variety) are also names of columms
    # in the dataset. I'm going to capitalize the names of the original columns
    # to avoid mix-ups

    wine_reviews.columns = wine_reviews.columns.str.capitalize()

    # now we can concetenate the new columns in
    wine_reviews_with_tokens = pd.concat([wine_reviews, word_columns], axis=1)

    # let's drop the description column now
    wine_reviews_with_tokens.drop(columns='Description',
                                  inplace=True)

    wine_reviews_with_tokens.to_csv('./data/processed/wine-reviews-tokenized.csv')


def convert_to_vectors(wine_word_counts, filtered_words):
    word_vectors = {}

    for index, word_counts in wine_word_counts.items():
        vector = [word_counts.get(word, 0) for word in filtered_words]
        word_vectors[index] = vector

    return word_vectors


def get_total_word_count(wine_word_counts):
    # We get the total word counts for each word across all wine descriptions.
    total_word_count = Counter()

    for word_counts in wine_word_counts.values():
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
