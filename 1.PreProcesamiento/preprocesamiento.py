# -*- coding: utf-8 -*-
"""
Created on Wed May  5 20:32:02 2021
@author: ander
"""
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import LabelEncoder, OneHotEncoder, StandardScaler
from sklearn.compose import ColumnTransformer
from sklearn.model_selection import train_test_split
# PLANTILLA DE PREPROCESAMIENTO DE DATOS

# Importar el Data set
dataset = pd.read_csv("Data.csv")
X = dataset.iloc[:, :-1].values #todas las filas, todas las columnas expecto la ultima
y = dataset.iloc[:, 3].values #todas las filas, tercera columna

#Datos faltantes
imputer = SimpleImputer(missing_values = np.nan, strategy = "mean", verbose=0) #verbose=0 es para columna, verbose = 1 es para fila
imputer = imputer.fit(X[:,1:3]) #desde la col 1, hasta la 2 (3 excluido)
X[:, 1:3] = imputer.transform(X[:,1:3]) #reemplazamiento de valores

#Datos Categóricos
labelencoder_X = LabelEncoder()
X[:, 0] = labelencoder_X.fit_transform(X[:, 0])
# ya tenemos numeradas pero es necesario traducir a variable Dummy (tablas con categorias y marcadas con 0 y 1)
ct = ColumnTransformer([('one_hot_encoder', OneHotEncoder(categories='auto'), [0])],   
    remainder='passthrough') #constructor
X = np.array(ct.fit_transform(X), dtype=np.float)
labelencoder_y = LabelEncoder()
y = labelencoder_y.fit_transform(y) #no es necesario hacer dummy solo hay si o no

# Split en entrenamiento y test
X_train, X_test, Y_train, Y_test = train_test_split(X,y, test_size=0.2, random_state=0) #random state hace aleatorio la seleccion de train ytest

# Escalamiento o Normalización de los datos
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)