# Actividad

#1. Dataset escogido: https://www.kaggle.com/lava18/google-play-store-apps
dataset = read.csv("googleplaystore.csv")
summary(dataset)
# Como vem os el dataset nos presenta un total de 10841 observaciones pero nuestro
#trabajo se centra en una menor camtidad de observaciones (30 a 50)
#por lo que vamos a proceder a hacer un muestreo aleatorio sin reemplazo
install.packages("dplyr")
library("dplyr")
data<-sample_n(dataset,50,replace = FALSE)

