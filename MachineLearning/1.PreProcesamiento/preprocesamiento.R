#Plantilla de Preprocesamiento

#1. Importar datos
dataset = read.csv('Data.csv')
#dataset = dataset[,2:3]

#2. Tratamiento de los valores NA
dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN=function(x) mean(x,na.rm=TRUE))
                     ,dataset$Age)
#ave crea un vector temporal y después definimos nuestra función
dataset$Salary = ifelse(is.na(dataset$Salary),
                     ave(dataset$Salary, FUN=function(x) mean(x,na.rm=TRUE))
                     ,dataset$Salary)

#3. Codificar las variables categóricas
dataset$Country = factor(dataset$Country,levels= c("France","Spain","Germany"),
                         labels = c(1,2,3))
#con la función factor es suficiente para hacer dummy
dataset$Purchased = factor(dataset$Purchased,levels= c("No","Yes"),
                         labels = c(0,1))

#4. Split de datos en entrenamiento y test
set.seed(123)#si deseamos hacer de forma aleotoria usamos una semilla
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set = subset(dataset, split==TRUE)
testing_set = subset(dataset, split==FALSE)

#5. Escalado de valores
training_set[,2:3] = scale(training_set[,2:3])
testing_set[,2:3] = scale(testing_set[,2:3])
# En R cuando definimos intervalos incluye tanto la primera como la segunda