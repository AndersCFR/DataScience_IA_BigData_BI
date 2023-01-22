import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
# Ajustamos los parámetros
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression

# Importar el Data set
dataset = pd.read_csv("Position_Salaries.csv")
X = dataset.iloc[:, 1:2].values 
#especificamos desde 1:2 para que cree una matriz y no una característica
y = dataset.iloc[:, 2].values

# Creamos el modelo
pol_reg = LinearRegression()
pol_reg.fit(X,y)

# Para el modelo requerimos los features para entrenar
poly_reg = PolynomialFeatures(degree = 2)
X_poly = poly_reg.fit_transform(X)

# Ahora con los features podemos ya entrenar
pol_reg2 = LinearRegression()
pol_reg2.fit(X_poly, y)

