
###              ###
##   POSTWORK 5   ##
###  Equipo 8    ### 

#Desarrollo: 
#1.1) A partir del conjunto de datos de soccer de la liga española de las temporadas 
#2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, que contenga las 
#columnas date, home.team, home.score, away.team y away.score; esto lo puede hacer 
#con ayuda de la función select del paquete dplyr. 
library(dplyr)
url1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

LE1718 <- read.csv(file = url1718) 
LE1819 <- read.csv(file = url1819)
LE1920 <- read.csv(file = url1920)

#               [1]     [2]     [3]
lista <- list(LE1718, LE1819, LE1920)
listaLE <- lapply(lista, select, Date, HomeTeam, FTHG, AwayTeam, FTAG) 

listaLE[[1]] <- mutate(listaLE[[1]], Date = as.Date(Date, "%d/%m/%y"))
listaLE[[2]] <- mutate(listaLE[[2]], Date = as.Date(Date, "%d/%m/%y"))
listaLE[[3]] <- mutate(listaLE[[3]], Date = as.Date(Date, "%d/%m/%y"))

SmallData <- do.call(rbind, listaLE)

#1.2) Luego establece un directorio de trabajo y con ayuda de la función write.csv 
#guarda el data frame como un archivo csv con nombre soccer.csv. Puedes colocar 
#como argumento row.names = FALSE en write.csv. 
SmallData <- select(SmallData, date = Date, home.team = HomeTeam, 
                    home.score = FTHG, away.team = AwayTeam, 
                    away.score = FTAG)
write.csv(x = SmallData, file = "soccer.csv", row.names = FALSE)


#2) Con la función create.fbRanks.dataframes del paquete fbRanks importe el 
#archivo soccer.csv a R y al mismo tiempo asignelo a una variable llamada 
#listasoccer. 

library(fbRanks)
listasoccer <- create.fbRanks.dataframes(scores.file = "soccer.csv")

anotaciones <- listasoccer$scores
equipos <- listasoccer$teams


#3.1) Con ayuda de la función unique crea un vector de fechas (fecha) que no se 
#repitan y que correspondan a las fechas en las que se jugaron partidos. 
fecha <- unique(anotaciones$date)
#3.2) Crea una variable llamada n que contenga el número de fechas diferentes. 
n <- length(fecha)
#3.3) Posteriormente, con la función rank.teams y usando como argumentos los data 
#frames anotaciones y equipos, crea un ranking de equipos usando unicamente 
#datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron 
#partidos, estas fechas las deberá especificar en max.date y min.date. Guarda 
#los resultados con el nombre ranking.

ranking <- rank.teams(scores = anotaciones, teams = equipos,
                      max.date = fecha[n-1],#La penúltima fecha se obtiene gracias al valor de longitud n menos 1 
                      min.date = fecha[1])

#4) Finalmente estima las probabilidades de los eventos, 
predict(ranking, date = fecha[n])

