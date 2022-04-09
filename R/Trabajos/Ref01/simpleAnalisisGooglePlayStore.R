# Actividad

# ------------------------------------------------------------------------
#1. Dataset escogido: https://www.kaggle.com/lava18/google-play-store-apps
# ------------------------------------------------------------------------

dataset = read.csv("googleplaystore.csv")
summary(dataset)
# Como vem os el dataset nos presenta un total de 10841 observaciones pero nuestro
#trabajo se centra en una menor camtidad de observaciones (30 a 50)
#por lo que vamos a proceder a hacer un muestreo aleatorio sin reemplazo
install.packages("dplyr")
library("dplyr")
data<-sample_n(dataset,50,replace = FALSE)
# de esta muestar aleatoria vemos que tiene valores NA los cuales no nos sirven
# para hacer analisis de variables numéricas
data$Rating = ifelse(is.na(data$Rating),
                     ave(data$Rating, FUN = function(x) mean(x, na.rm = TRUE)),
                     data$Rating)

# -------------------------------------------
# 2. Análisis descriptivo variables numéricas
# -------------------------------------------

# . Primera variable Rating (0 a 5) 
rating <- data$Rating
mean(rating)
median(rating)
#moda numérica
# de ser necesario instalar modeest
#install.packages("modeest")
library(modeest)
mfv(rating) #la moda es 0.01
summary(rating)
hist(rating)
scatter.smooth(rating)


# . Primera variable número de Reviews
reviews <- as.numeric(data$Reviews)

mean(reviews)
median(reviews)
#moda numérica
# de ser necesario instalar modeest
#install.packages("modeest")
mfv(reviews) #la moda es 0.01
summary(reviews)
hist(reviews)
scatter.smooth(reviews)

# ------------------------------------              
# 3. Análisis de variables categórica
# ------------------------------------

# . Análisis de la variable Category de la app
category <- data$Category
table(category)
##Tabla de frecuencia relativa 
table(category)/margin.table(table(category))
summary(category)
hist(table(category))

# . Análisis de la variable Genres
genres <- data$Genres
table(genres)
##Tabla de frecuencia relativa 
table(genres)/margin.table(table(genres))
summary(genres)
hist(table(genres))

# ----------------------------------------------------------
# 4. Intervalo de confianza para las dos variables numericas
# ----------------------------------------------------------

## a) para la variable 
t.test(x=rating, conf.level = 0.95)$conf.int # 4.264008 4.420992

## b) para la variable NA_Sales
t.test(x=reviews, conf.level = 0.95)$conf.int #1589.032 706272.048

# ----------------------------------------------------
# 5. Pruebas de hipótesis de dos variables categóricas
# ----------------------------------------------------

# . Cateory: Se afirma que menos del 20% de las categorías de 
# las apps son de tipo familiar
#H0: proporcion < 0.2
#Ha: proporcion >= 0.2

prop.test( length(subset(data, data$Category == 'FAMILY')),
           length(data$Category), 
           0.2,
           alternative = "less") #p-value =0.25 > 0.05
#Por el valor de p valor es mayor no se rechaza H0

# . Genre: Se afirma que menos del 10% de las apps son de Género Education
#H0: proporcion <= 0.1
#Ha: proporcion > 0.1

prop.test( length(subset(data, data$Genres == 'Enducation')),
           length(data$Genres), 
           0.1,
           alternative = "less") # p-value > 0.05
#Por el valor de p (menor a 0.05), se rechaza la H0 

# --------------------------------------------------------
# 6. Regresión lineal entre Reating y revisiones de la app#
# ----------------------------------------------------------
pairs(data)
cor(rating, reviews) #0.1 de correlación

#Modelo de regresion lineal simple 
linearModel = lm(formula = Rating ~  Reviews, 
                 data = data)
summary(linearModel)

