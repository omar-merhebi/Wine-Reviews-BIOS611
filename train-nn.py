import tensorflow as tf
import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler


def main():
    # read in data
    data = pd.read_csv('data/processed/wine-reviews-nn.csv')
    train_and_evaluate_models(data)


def train_and_evaluate_models(data):
    X = data.drop(columns=['Price', 'Points'], inplace=False)
    y_price = data['Price']
    y_points = data['Points']

    # train test split
    X_train, X_test, y_price_train, y_price_test = train_test_split(
        X, y_price, test_size=0.2, random_state=416)

    X_train, X_test, y_points_train, y_points_test = train_test_split(
        X, y_points, test_size=0.2, random_state=416
    )

    # Scale the numerical data
    scaler = StandardScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.fit_transform(X_test)

    input_dim = X_train.shape[1]

    price_model = build_model(input_dim)
    points_model = build_model(input_dim)

    # Add callbacks for early stopping based on validation set loss
    early_stop = tf.keras.callbacks.EarlyStopping(monitor='val_loss',
                                                  patience=3,
                                                  mode='min')

    price_checkpoint_save = tf.keras.callbacks.ModelCheckpoint(
        'models/best_price_model.hdf5', save_best_only=True,
        monitor='val_loss', mode='min')

    points_checkpoint_save = tf.keras.callbacks.ModelCheckpoint(
        'models/best_points_model.hdf5', save_best_only=True,
        monitor='val_loss', mode='min')

    print('Training Models')
    price_model.fit(X_train, y_price_train, epochs=20, batch_size=100,
                    validation_split=0.2,
                    callbacks=[early_stop, price_checkpoint_save])
    points_model.fit(X_train, y_points_train, epochs=20, batch_size=100,
                     validation_split=0.2,
                     callbacks=[early_stop, points_checkpoint_save])

    price_predictions = price_model.predict(X_test)
    points_predictions = points_model.predict(X_test)

    results = pd.DataFrame({
        'price': y_price_test.values,
        'price_pred': price_predictions.flatten(),
        'points': y_points_test.values,
        'points_pred': points_predictions.flatten()
    })

    results.to_csv('data/results/wine_predictions.csv')


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
