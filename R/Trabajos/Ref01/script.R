## 1.Encontramos el datset vgsales de Kaggle
#El dataset contempla ventas de videojuegos de varias plataformas
#Se ha filtrado para tomar en cuenta solo las de la plataforma XOne del 2016

dataset = read.csv("vgsales.csv")
summary(dataset)
class(dataset$Platform)

#dataset$Platform <- as.character(dataset$Platform)

dataset <- dataset[(dataset[, "Platform"]=="XOne") & (dataset[, "Year"]==2016) , ]
summary(dataset)
nrow(dataset) #54 registros 

## 2. Realizar el análisis descriptivo (medidas y gráficos) para dos variables numéricas

# a) Análisis descriptivo para la variable EU_Sales 

mean(dataset$EU_Sales, na.rm = TRUE)
median(dataset$EU_Sales, na.rm = TRUE)
install.packages("modeest")
library(modeest)
mfv(dataset$EU_Sales) #la moda es 0.01

summary(dataset$EU_Sales) 
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.00000 0.01000 0.02000 0.08574 0.07750 1.26000 

##Gráficos
hist(dataset$EU_Sales)
plot(dataset$EU_Sales)

# b) Análisis descriptivo de la variable NA_sales
dataset$NA_Sales <- as.numeric(dataset$NA_Sales)
dataset

mean(dataset$NA_Sales, na.rm = TRUE)
median(dataset$NA_Sales, na.rm = TRUE)
mfv(dataset$NA_Sales) #la moda es 0.01

summary(dataset$NA_Sales) 
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.0000  0.0100  0.0300  0.1239  0.1450  1.2000 

##Gráficos
hist(dataset$NA_Sales)
plot(dataset$NA_Sales)

# 3. Realizar el análisis descriptivo (medidas y gráficos) para dos variables categóricas
# a) Análisis descriptivo de la variable categórica Genre
##Tabla de frecuencia absoluta 
table(dataset$Genre)

##Tabla de frecuencia relativa 
table(dataset$Genre)/margin.table(table(dataset$Genre))

summary(dataset$Genre)

plot(dataset$Genre)

# b) Análisis descriptivo de la variable categórica Publisher
##Tabla de frecuencia absoluta 
table(dataset$Publisher)

##Tabla de frecuencia relativa 
table(dataset$Publisher)/margin.table(table(dataset$Publisher))

summary(dataset$Publisher)

plot(dataset$Publisher)


# 4. Realice el intervalo de confianza para las dos variables numéricas 

## a) para la variable EU_Sales
t.test(x=dataset$EU_Sales, conf.level = 0.95)$conf.int #0.03289506 0.13858642

## b) para la variable NA_Sales
t.test(x=dataset$NA_Sales, conf.level = 0.95)$conf.int #0.06463596 0.18314182


# 5. Realice un contraste de hipótesis para comparar proporciones de dos variables 
# categóricas (defina previamente los éxitos y fracasos en cada caso)

# a) Genre: Se afirma que menos del 80% de los géneros es sport
  #H0: proporción < 0.8
  #Ha: proporción >= 0.8
   
prop.test( length(subset(dataset, dataset$Genre == 'Sports')),
           length(dataset$Genre), 
           0.8,
           alternative = "less") #p-value < 2.2e-16 < 0.05
#Por el valor de p(menor a 0.05), se rechaza la H0 

# b) Publisher: Se afirma que  Electronic Arts es el 70% de los publishers
#H0: proporción = 0.7
#Ha: proporción < 0.7

prop.test( length(subset(dataset, dataset$Publisher == "Electronic Arts")),
           length(dataset$Publisher), 
           0.7,
           alternative = "less") # p-value = 2.86e-15 < 0.05
#Por el valor de p (menor a 0.05), se rechaza la H0 



# 6. Realice una regresión lineal simple entre dos variables numéricas 

pairs(dataset)
cor(dataset$EU_Sales, dataset$NA_Sales) #0.4646233

#Modelo de regresiǿn lineal simple 
linearModel = lm(formula = EU_Sales ~  NA_Sales, 
                 data = dataset)
summary(linearModel)
