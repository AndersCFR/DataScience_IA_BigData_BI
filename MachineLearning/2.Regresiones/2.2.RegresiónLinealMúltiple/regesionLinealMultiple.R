#Regresión lineal múltiple 

# 1. Importar datos
dataset = read.csv('50_Startups.csv')
#dataset = dataset[,2:3]


# 2. Codificar la variable State
dataset$State = factor(dataset$State,levels= c("New York", 
                                                   "California", 
                                                   "Florida"),
                           labels = c(1,2,3))

# 3. Split de datos en entrenamiento y test
library(caTools)
set.seed(123)#si deseamos hacer de forma aleotoria usamos una semilla
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split==TRUE)
testing_set = subset(dataset, split==FALSE)

# 4. Creación de modelo usando Modelo Lineal simple
# Usando el . indicamos todas las variables excepto las anteriores
regression = lm(formula = Profit ~ .,
                data = training_set) 
summary(regression) # ver resumen de modelo

# Predicción de datos
y_pred = predict(regression, newdata = testing_set)

# Optimización de modelo, (eliminación hacia atrás)

backwardElimination <- function(x, sl) {
  numVars = length(x)
  for (i in c(1:numVars)){
    regressor = lm(formula = Profit ~ ., data = x)
    maxVar = max(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"])
    if (maxVar > sl){
      j = which(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"] == maxVar)
      x = x[, -j]
    }
    numVars = numVars - 1
  }
  return(summary(regressor))
}

SL = 0.05
dataset = dataset[, c(1,2,3,4,5)]
backwardElimination(training_set, SL)
