import nltk
import pandas as pd
import string

from collections import Counter

nltk.download('punkt')
nltk.download('punkt_tab')
nltk.download('stopwords')

STOP_WORDS = set(nltk.corpus.stopwords.words('english'))


def main():
    wine_reviews = pd.read_csv('data/processed/wine-reviews-clean.csv')

    example_description = "This is ripe and fruity, a wine that is smooth while still structured. Firm tannins are filled out with juicy red berry fruits and freshened with acidity. It's  already drinkable, although it will certainly be better from 2016."

    tokenize_description(example_description)
    

def tokenize_description(description):
    # make lowercase and get rid of punctuation
    text = description.translate(
        str.maketrans("", "", string.punctuation)).lower()

    # tokenize
    tokens = nltk.word_tokenize(text)

    print(tokens)
    # remove stop words
    tokens = [word for word in tokens if word not in STOP_WORDS]
    
    print(tokens)


if __name__ == '__main__':
    main()
