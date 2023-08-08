# 1. Data Visualization 11/04/2022
library(tidyverse)

# Comprobar si los coches con motor más grande consumen más que los de menor tamaño

# La relación consumo / tamaño es lineal? No lineal? Exponencial?

mpg # Carga de dataset de carros ggplot2
View(mpg) # Ver toda la data en formato tabla
help(mpg) #ver documentación del dataset, puedo usar ?mpg

# Exploración de variables
# displ -> tamaño del motor en litros
# hwy -> millas por galón

# Primer gráfico, indicamos el dataset y hacemos un scatter
# data -> indica el dataframe a ser utilizado
# mapping -> indica como las variables son traducidas a la parte visual
# aes -> aesthetic (estética del gráfico)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) 

# 1. Ajustes de estéticas basados en variable clase

# Agregando color
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) 

# Utilizando el size (de preferencia variable numérica)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class)) 

# Manejando la transaprencia y opacidad de los puntos
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class)) 

# Manejando clases con formas (solo permite manejar máximo 6 formas a la vez)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class)) 

# 2. Elección manual de estéticas (son definidas fuera del mapeo automático)
# color = string
# size = tamaño del punto en mm
# shape = forma de los puntos, consultar catálogo (o al 25)

ggplot(data = mpg) + 
  geom_point(
    mapping = aes(x = displ, y = hwy),
    color = "blue",
    shape = 23,
    size = 4,
    fill = "green"
    ) 

# Mapear un color con condición booleana
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 4)) 

# 3. FACETS
# Los facets(facetas permite hacer matriz de gráficos en una sola visualización)
# permie hacer un gráfico segmentado por variable categórica
# facet_wrap(~<Formula>) la variable debe ser categórica
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 2)

# facet_grid(<FormulaVariable1>~<FormulaVariable2>) 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv~cyl)

#Extras
# Nota cuando usamos una variable para agrupar, si usamos .~ antes de la variables 
# será agrupación vertical, en cambio si uso después, será vertical. 

# Facet usando otra variables (se crea matriz a partir de otra variable)
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl)

# Facet usando drv,punto después de virulilla, cambia el sentido de agrupación
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.)

