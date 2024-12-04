import tensorflow as tf
import pandas as pd

from sklearn.model_selection import train_test_split


def main():
    # read in data
    data = pd.read_csv('data/processed/wine-reviews-nn.csv')
    train_nn(data)


def train_nn(data):
    X = data.drop(columns=['Price', 'Points'], inplace=False)
    y_price = data['Price']
    y_points = data['Points']

    # train test split
    X_train, X_test, y_price_train, y_price_test = train_test_split(
        X, y_price, test_size=0.2, random_state=416)

    X_train, X_test, y_points_train, y_points_test = train_test_split(
        X, y_points, test_size=0.2, random_state=416
    )

    input_dim = X_train.shape[1]

    price_model = build_model(input_dim)
    points_model = build_model(input_dim)

    print('Training Price Prediction Model')
    price_model.fit(X_train, y_price_train, epochs=20, batch_size=100,
                    validation_split=0.2)

    print('Evaluating Price Prediction Model on Test Data')
    price_loss, price_mae = price_model.evaluate(X_test, y_price_test)
    print(f'Price Prediction Loss: {price_loss}')
    print(f'Price Prediction MAE: {price_mae}')


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
