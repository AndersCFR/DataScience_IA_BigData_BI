# Regresión Lineal Simple
dataset = read.csv('Salary_Data.csv')

# Dividir los datos en conjunto de entrenamiento y conjunto de test
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
testing_set = subset(dataset, split == FALSE)

# Creación lineal simple con el conjunto de entrenamiento
regressor = lm(formula = Salary ~ YearsExperience,
               data = training_set)

# Predecir resultados con el conjunto de test
y_pred = predict(regressor, newdata = testing_set)

# Grafica Entrenamiento
library(ggplot2)
ggplot() + 
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = "red") +
  geom_line(aes(x = training_set$YearsExperience, 
                y = predict(regressor, newdata = training_set)),
            colour = "blue") +
  ggtitle("Sueldo vs Años de Experiencia (Entrenamiento)") +
  xlab("Años de Experiencia") +
  ylab("Sueldo ($)")

# Gráfica Testing
ggplot() + 
  geom_point(aes(x = testing_set$YearsExperience, y = testing_set$Salary),
             colour = "red") +
  geom_line(aes(x = training_set$YearsExperience, 
                y = predict(regressor, newdata = training_set)),
            colour = "blue") +
  ggtitle("Sueldo vs Años de Experiencia (Testing)") +
  xlab("Años de Experiencia") +
  ylab("Sueldo ($)")
