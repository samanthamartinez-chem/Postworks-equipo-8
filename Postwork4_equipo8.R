
###              ###
##   POSTWORK 4   ##
###  Equipo 8    ### 

library(rsample)

# En este postwork buscremos la dependencia o independencia del número de goles 
# anotados por los equipos local y visitante mediante el procedimiento de bootstrap 


# Creando el dataframe del postwork 3

library(dplyr)
url1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

LigaEsp1718 <- read.csv(file = url1718) 
LigaEsp1819 <- read.csv(file = url1819)
LigaEsp1920 <- read.csv(file = url1920)

#               [1]     [2]     [3]
listaLigaEsp[[1]] <- mutate(listaLigaEsp[[1]], Date = as.Date(Date, "%Y/%m/%d"))
listaLigaEsp[[2]] <- mutate(listaLigaEsp[[2]], Date = as.Date(Date, "%Y/%m/%d"))
listaLigaEsp[[3]] <- mutate(listaLigaEsp[[3]], Date = as.Date(Date, "%Y/%m/%d"))
(dfLigaEsp <- do.call(rbind, listaLigaEsp))


# Hay que redondear la probabilidad marginal de que el equipo local anote x goles
(probMarg_locales <- round(table(dataFrameLigaEsp$FTHG)/dim(dataFrameLigaEsp)[1],3))

# Ahora para el equipo visitante
(probMarg_visita <- round(table(dataFrameLigaEsp$FTAG)/dim(dataFrameLigaEsp)[1], 3)) 

# Probabilidad conjunta
(probConjunta <- round(table(dataFrameLigaEsp$FTHG, dataFrameLigaEsp$FTAG)/dim(dataFrameLigaEsp)[1], 3)) 

# 1) Obteniendo una tabla de cocientes, resultado de dividr las probabilidades 
#    conjuntas por el producto de las probabilidades marginales correspondientes 

#  Iniciaremos multiplicando la probabilidad por columnas. Podremos observar que 
#  la probabilidad marginal de los locales corresponde a las filas, utilizaremos 2 
(cocientes <- apply(probConjunta, 2, function(column) column/probMarg_locales))


#  Para visitantes 
(cocientes <- apply(cocientes, 1, function(row) row/probMarg_visita))


# Trasponemos la matriz para poder visualizar correctamente los valores.
(tablaCocientes <- t(cocientes))



#2) Para tener una idea de las distribuciones de la tabla del punto anterior, 
#   haremos el procedimiento boostrap. 

#  Primero extraemos de manera aleatoria algunas filas de nuestro data frame, 
#  esto lo hacemos con ayuda de la función sample.

set.seed(21)
datos_boot <- bootstraps(dataFrameLigaEsp, times = 1000)
first_datos_boot <- datos_boot$splits[[1]]
newDataFrame <- as.data.frame(first_datos_boot)

#  Ahora, obtenemos las nuevas probabilidades marginales y conjuntas.

(newProbMarg_locales <- round(table(newDataFrame$FTHG)/dim(newDataFrame)[1], 3)) 

(newProbMarg_visita <- round(table(newDataFrame$FTAG)/dim(newDataFrame)[1], 3)) 

(newProbConjunta <- round(table(newDataFrame$FTHG, newDataFrame$FTAG)/dim(newDataFrame)[1], 3))



#  Obtenemos nuevamente los cocientes de probabilidades conjuntas y probabilidades
#  marginales

(newcocientes <- apply(newProbConjunta, 2, function(column) column/newProbMarg_locales))

(newcocientes <- apply(newcocientes, 1, function(row) row/newProbMarg_visita))

(newTablaCocientes <- t(newcocientes))







