from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split as tts
from sklearn.linear_model import SGDClassifier
import numpy as np

clf = SGDClassifier(loss='log')
tf = TfidfVectorizer()

DATA_PATH = "D:\ML_Predict_Name-master\data\data-2.csv"

X, y = [], []

with open(DATA_PATH, 'r') as f:
    for line in f:
        X.append(line.split(',')[0].lower())
        y.append(line.split(',')[1].strip('\n'))

y = np.array(y)
y = np.where(y == 'm', 1, 0)

X_train, X_test, y_train, y_test = tts(X, y, test_size=0.5)
x_train = tf.fit_transform(X_train)

clf.fit(x_train, y_train)

def predict(nama):
    name = tf.transform([nama])
    pred = clf.predict(name)[0]
    prob_gender = "Male" if pred == 1 else "Female"
    return prob_gender

while True:
    nama = input("Masukkan Nama: ")
    gender = predict(nama)
    print(f"Name {nama} is predicted {gender} gender\n")