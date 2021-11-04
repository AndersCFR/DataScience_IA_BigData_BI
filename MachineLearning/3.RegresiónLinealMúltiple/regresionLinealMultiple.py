# -*- coding: utf-8 -*-
"""
Created on Mon Oct 25 22:22:59 2021

@author: ander
"""
#Regresión lineal múltiple
# Antes de empezar con un modelo de regresión lineal múltiple verificar que
# efectivamente se cumpla con la Teoría de regresión y sus condiciones

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
#Sklearn pre procesing
from sklearn.preprocessing import LabelEncoder, OneHotEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.model_selection import train_test_split
#Sklearn modelo
from sklearn.linear_model import LinearRegression

# Importar el Data set
dataset = pd.read_csv("50_Startups.csv")
X = dataset.iloc[:, :-1].values #todas las filas, todas las columnas expecto la ultima
y = dataset.iloc[:, 4].values #todas las filas, tercera columna

#Codificación de la variable categórica Estado
labelencoder_X = LabelEncoder()
X[:, 3] = labelencoder_X.fit_transform(X[:, 3])
onehotencoder = ColumnTransformer(
    [('one_hot_encoder', OneHotEncoder(), [3])],    # The column numbers to be transformed (here is [0] but can be [0, 1, 3])
    remainder='passthrough'                         # Leave the rest of the columns untouched
)
X = np.array(onehotencoder.fit_transform(X))
y = np.array(y)

#Recordemos que para una regresión lineal múltiple debemos borrar la última columna de la variable dummy 
#para evitar redundancia, no olvidar
X = X[:,1:]

#Split de datos
X_train, X_test, Y_train, Y_test = train_test_split(X,y, test_size=0.2, random_state=0)

#Train 
regression = LinearRegression()
regression.fit(X_train,Y_train)

#Predict
y_predict = regression.predict(X_test)

#Aunque ya tenemos nuestro RLM (Regresion Linear Model podemos optimizarlo)
import statsmodels.formula.api as sm

#StatsModels necesita una columna (de todo unos) para que reoresente la variable independiente
#Numpy: axis 1 agrega en columna
X = np.append(arr=np.ones((50,1)).astype(int),values = X, axis=1) 


