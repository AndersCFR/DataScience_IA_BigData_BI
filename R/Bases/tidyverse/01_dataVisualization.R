# Data Visualization 11/04/2022
library(tidyverse)

# Comprobar si los coches con motor más grande consumen más que los de menor tamaño

# La relación consumo / tamaño es lineal? No lineal? Exponencial?

mpg # Carga de dataset de carros ggplot2
View(mpg) # Ver toda la data en formato tabla
help(mpg) #ver documentación del dataset, puedo usar ?mpg


# Primer gráfico, indicamos el dataset y hacemos un scatter
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
