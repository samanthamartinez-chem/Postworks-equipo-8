###              ###
##   POSTWORK 2   ##
###   Equipo 8   ### 

# En este postwork se generará un cúmulo de datos para complementar el análisis
# del postwork 1.


# 1) Importando los datos de soccer de las temporadas 2017/2018, 2018/2019 y 
#    2019/2020 de la primera división de la liga española 

url1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

LigaEsp1718 <- read.csv(file = url1718) 
LigaEsp1819 <- read.csv(file = url1819)
LigaEsp1920 <- read.csv(file = url1920)



# 2) Obteniendo las características, visualización y summary de los dataframes 

#  De la temporada 17-18
str(LigaEsp1718)
head(LigaEsp1718)
View(LigaEsp1718)
summary(LigaEspE1718)

#  De la temporada 18-19
str(LigaEsp1819)
head(LigaEsp1819)
View(LigaEsp1819)
summary(LigaEsp1819)

#  De la temporada 19-20
str(LigaEsp1920)
head(LigaEsp1920)
View(LigaEsp1920)
summary(LigaEsp1920)



# 3) Seleccionando columnas: Date, HomeTeam, AwayTeam, FTHG, FTAG Y FTR

# Hemos decidido convertir en lista los dataframes 
library(dplyr)
lista <- list(LigaEsp1718, LigaEsp1819, LigaEsp1920)
(listaLigaEsp <- lapply(lista, select, Date, HomeTeam:FTR)) 

# Las fechas son de tipo chr, las cambiaremos a tipo Date usando  la función
# mutate y as.Date
listaLigaEsp[[1]] <- mutate(listaLigaEsp[[1]], Date = as.Date(Date, "%Y/%m/%d"))
listaLigaEsp[[2]] <- mutate(listaLigaEsp[[2]], Date = as.Date(Date, "%Y/%m/%d"))
listaLigaEsp[[3]] <- mutate(listaLigaEsp[[3]], Date = as.Date(Date, "%Y/%m/%d"))

# Combinamos los data frames con do.call y r.bind
(dfLigaEsp <- do.call(rbind, listaLigaEsp))

# Ahora podemos ver que las fechas son del tipo Date 
str(dfLigaEsp)

