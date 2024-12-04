import tensorflow as tf
import pandas as pd


def main():
    # read in data
    data = pd.read_csv('data/processed/wine-reviews-nn.csv')


def train_nn(data):
    X = data.drop(columns=['Price', 'Points'], inplace=False)
    y_price = data['Price']
    y_points = data['Points']


def build_model(input_dim):
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(1280, activation='relu',
                              input_shape=(input_dim,)),
        tf.keras.layers.Dense(640, activation='relu'),
        tf.keras.layers.Dense(128, activation='relu'),
        tf.keras.layers.Dense(1)
    ])

    model.compile(optimizer='adam', loss='mse', metrics=['mae'])

    return model


if __name__ == '__main__':
    main()
