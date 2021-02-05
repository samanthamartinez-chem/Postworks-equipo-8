###              ###
##   POSTWORK 3   ##
###   Equipo 8   ### 


# En este postwork graficaremos probabilidades (esimadas) marginales y conjuntas
# para el número de goles anotados por equipos locales o visitantes. 

# Usaremos el dataframe "dfLigaEsp" generado en el postwork 2 

url1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
LigaEsp1718 <- read.csv(file = url1718) 
LigaEsp1819 <- read.csv(file = url1819)
LigaEsp1920 <- read.csv(file = url1920)
listaLigaEsp[[1]] <- mutate(listaLigaEsp[[1]], Date = as.Date(Date, "%Y/%m/%d"))
listaLigaEsp[[2]] <- mutate(listaLigaEsp[[2]], Date = as.Date(Date, "%Y/%m/%d"))
listaLigaEsp[[3]] <- mutate(listaLigaEsp[[3]], Date = as.Date(Date, "%Y/%m/%d"))
(dataFrameLigaEsp <- do.call(rbind, listaLigaEsp))


# 1) Elaborando tablas de frecuencias relativas para estimar: 

#    A) La probabilidad (marginal) de que el equipo que juega en casa anote
#       x goles (x=0,1,2,)
(probMarg_locales <- (table(dataFrameLigaEsp$FTHG)/dim(dataFrameLigaEsp)[1])*100)



#    B) La probabilidad (marginal) de que el equipo que juega como visitante
#       anote y goles (y=0,1,2,)
(probMarg_visita <- (table(dataFrameLigaEsp$FTAG)/dim(dataFrameLigaEsp)[1])*100) 



#    C) La probabilidad (conjunta) de que el equipo que juega en casa anote x 
#       goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
(probConjunta <- (table(dataFrameLigaEsp$FTHG, dataFrameLigaEsp$FTAG)/dim(dataFrameLigaEsp)[1])*100) 




# 2) Realizando gráficos de barras:  
library(ggplot2)
library(reshape2)

#   Para empezar, debemos convertir las tablas a dataframes 
(probMarg_locales <- as.data.frame(probMarg_locales))
probMarg_visita <- as.data.frame(probMarg_visita)
probConjunta <- as.data.frame(probConjunta)


#   Realizando gráfico de barras para probabilidades marginales de equipo local 

probMarg_locales <- rename(probMarg_locales, Goles = Goles, Probabilidad = Probabilidad) 
(graf_problocales <- ggplot(data = probMarg_locales) + 
  geom_bar (
    mapping = aes(x = Goles, y = Probabilidad, fill = Goles), 
    stat="identity"))

   
#  Para el equipo visitante 

probMarg_visita <- rename(probMarg_visita, Goles = Goles, Probabilidad = Probabilidad) 
(graf_probvisita <- ggplot(data = probMarg_visita) + 
    geom_bar (
      mapping = aes(x = Goles, y = Probabilidad, fill = Goles), 
      stat="identity"))


#  Ahora elaboramos un heatmap para las probabilidades conjuntas
probConjunta <- melt(probConjunta)

probConjunta
heatMapPCE <- ggplot(probConjunta, aes(x = Var1, y = Var2)) + 
  geom_tile(aes(fill = value)) +
  ggtitle('Probabilidades conjuntas estimadas') +
  scale_fill_gradient(low = 'white', high = 'green') + 
  xlab("Goles casa") + 
  ylab("Goles visita") +
  theme(axis.text.x = element_text(angle = 90, hjust = 0))

heatMapPCE + labs(fill = "ProbEst")


