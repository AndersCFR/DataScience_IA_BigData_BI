# R

## Comandos y operaciones básicas en consola 

> Acceder a documentación de una función

>> ?nombre función

> Redondear

>> round(n,d) ; d = numero decimales

> Redondear a entero

>> floor(f)

> Imprimir en consola

>> print(variable)

> Multiples definiciones

>> x=20; y=50;

> Producto

>> prod(x,y,n...)

> Potencia

>> 10**2 ó 10^{2}

> Suma de un vector

>> sum(c(1,2,3,4,5))

> Asignación variables

>> x = c(1,2,3,4,5) ó x <- c(4,5,6) ó (85,96,74) -> x

## Gestión de paquetes

> Instalación de un paquete

>> install.packages("tidyverse")

> Ver detalles paquete instalado

>> library(tidyverse)

> Ver actualizaciones de una paquete

>> nombrePaquete_update()

> Múltiples instalaciones

>> install.packages(c("gapminder", "nycflights13"))

> Cuando dos paquetes tienen nombres de funciones repetidas

>> libray(nycflights13)
>> nycflights13::flights

> Exportar en formato R desde consola

>> z <- data.frame(a=1,b='a')
>> dput(z)

# EDA

Jhon Tukey: Estadístico y matemático, trabajó en FFT, además de destacar la
importancia de visualización en lo que hoy conocemos como EDA.


Para la representación gráfica, los datos numéricos describen los valores y los
clasificadores o niveles describen la estética que tendrá el gráfico.