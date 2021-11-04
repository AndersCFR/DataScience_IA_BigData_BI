"""
Created on Sat May 22 17:33:40 2021
@author: ander
""" 
#Regresión lineal Simple
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
# Importar el Data set
dataset = pd.read_csv("Salary_Data.csv")
x = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 1].values

# Split en entrenamiento y test
X_train, X_test, y_train, y_test = train_test_split(x,y, test_size=1/3, random_state=0)

#No necesita que se escalen los valores
regresion = LinearRegression()
regresion.fit(X_train, y_train) #deben tener el mismo valor los dos
y_pred = regresion.predict(X_test) # Predecir el conjunto de test 

# Visualizar los resultados de entrenamiento
plt.scatter(X_train, y_train, color = "red")
plt.plot(X_train, regresion.predict(X_train), color = "blue") #grafica la recta calculada
plt.title("Sueldo vs Años de Experiencia (Entrenamiento)")
plt.xlabel("Años de Experiencia")
plt.ylabel("Sueldo ($)")
plt.show()

# Visualizar los resultados de test
plt.scatter(X_test, y_test, color = "red")
plt.plot(X_train, regresion.predict(X_train), color = "blue")
plt.title("Sueldo vs Años de Experiencia (Testing)")
plt.xlabel("Años de Experiencia")
plt.ylabel("Sueldo ($)")
plt.show()