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

#OPTIMIZACIÓN DEL MODELO
#usando el algoritmo de eliminación hacia atrás
#Aunque ya tenemos nuestro RLM (Regresion Linear Model podemos optimizarlo)
import statsmodels.api as sm

#StatsModels necesita una columna (de todo unos) para que represente la variable independiente
#Numpy: axis 1 agrega en columna
X = np.append(arr=np.ones((50,1)).astype(int),values = X, axis=1) 
X_opt = X[:, [0,1,2,3,4,5]].tolist() #tomamos todas las varaibles al inicio
SL = 0.05 # SDefinimos significant level

# Importante, mientras más bajo sea el p-valor, más estadísticamente significativas son

# En esta caso vamos a usar OLS, (Ordinary Least Squares)
regression_OLS = sm.OLS(endog = y, exog = X_opt).fit()
regression_OLS.summary() # obtendremos el resumen estadístico

# Función que ayude con la eliminación hacia atras y además utilice el valor de
# R cuadrado en caso de duda de eliminación de variables solamente usando p valor

def backwardElimination(x, SL):    
    numVars = len(x[0])    
    temp = np.zeros((50,6)).astype(int)    
    for i in range(0, numVars):        
        regressor_OLS = sm.OLS(y, x.tolist()).fit()        
        maxVar = max(regressor_OLS.pvalues).astype(float)        
        adjR_before = regressor_OLS.rsquared_adj.astype(float)        
        if maxVar > SL:            
            for j in range(0, numVars - i):                
                if (regressor_OLS.pvalues[j].astype(float) == maxVar):                    
                    temp[:,j] = x[:, j]                    
                    x = np.delete(x, j, 1)                    
                    tmp_regressor = sm.OLS(y, x.tolist()).fit()                    
                    adjR_after = tmp_regressor.rsquared_adj.astype(float)                    
                    if (adjR_before >= adjR_after):                        
                        x_rollback = np.hstack((x, temp[:,[0,j]]))                        
                        x_rollback = np.delete(x_rollback, j, 1)     
                        print (regressor_OLS.summary())                        
                        return x_rollback                    
                    else:                        
                        continue    
    regressor_OLS.summary()    
    return x 
 
SL = 0.05
X_opt = X[:, [0, 1, 2, 3, 4, 5]]
X_Modeled = backwardElimination(X_opt, SL)




