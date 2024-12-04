import tensorflow as tf
import pandas as pd


def main():
    # read in data
    data = pd.read_csv('data/processed/wine-reviews-nn.csv')


def train_nn(data):
    X = data.drop(columns=['Price', 'Points'], inplace=False)
    y_price = data['Price']
    y_points = data['Points']


if __name__ == '__main__':
    main()
