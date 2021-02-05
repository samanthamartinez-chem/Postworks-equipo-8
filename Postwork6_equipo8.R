###              ###
##   POSTWORK 6   ##
###              ### .

# Creación de una serie de tiempo

#Desarrollo: Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:

conjuntoDeDatos <- read.csv("match.data.csv")
View(conjuntoDeDatos)

# El csv contiene las siguientes columnas: date, home.team, home.score, away.team 
# & away.scrore

#1) Agregando una nueva columna sumagoles que contiene la suma de goles por partido.
str(conjuntoDeDatos)
conjuntoDeDatos <- cbind(conjuntoDeDatos, sumagoles = 
                           c(conjuntoDeDatos$home.score + conjuntoDeDatos$away.score))

#2) Obteniendo el promedio por mes de los goles.
library(dplyr)

promedioMes <- conjuntoDeDatos %>% 
  mutate(date = as.Date(date, "%Y-%m-%d")) %>% #Cambiamos el valor a date para que puedan hacerse las operaciones de agrupar por mes.
  mutate(mes = format(date, "%Y-%m")) %>% #aqu? solo seleccionamos el mes y el a?o para hacer un promedio.
  group_by(mes) %>% #Agrupamos por mes los partidos.
  summarise(promedioGoles = mean(sumagoles)) #Sumarize nos crea un nuevo dataframe que nos retorna el c?lculo de la media (promedio) con relaci?n a nuestra agrupaci?n por mes.

(promedioMes <- as.data.frame(promedioMes)) #Lo casteamos como dataframe. 


# 3) Creando la serie de tiempo del promedio por mes de la suma de goles hasta
#    diciembre de 2019.

#  Primero tenemos que filtar nuestro dataframe hasta llegar a diciembre de 2019
#  Buscamos la posici?n donde se encuentra diciembre del 2019
diciembre2019 <- grep("2019-12", promedioMes$mes, ignore.case = TRUE)


#  Creamos nuestro dataframe hasta diciembre2019
(promedioMes <- promedioMes[1:diciembre2019,])

#  Creamos nuestra serie de tiempo
serieTiempoPromedio <- ts(promedioMes$promedioGoles, start = 1, frequency = 10)


# 4) Graficando la serie de tiempo.
#    Cargamos la librería ggfortify.

library(ggfortify)

#  Realizamondo la gráfica de la serie de tiempo y le agregamos etiquetas. 
autoplot(serieTiempoPromedio, ts.colour = "blue") +
  ylab("Promedio goles") +
  xlab("Tiempo") 
