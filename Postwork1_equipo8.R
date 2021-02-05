###              ###
##   POSTWORK 1   ##
###   EQUIPO 8   ###


# Se trabajará con datos referentes a equipos de la liga española de fútbol


# 1) Importando los datos de soccer de la temporada 2019/2020 de la primera 
#    division de la liga española 
url <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
datos_futbol <- read.csv(url)


# 2) Extrayendo las columnas con número de goles anotados por equipos locales 
#    (FTHG), y los goles anotados por los equipos visitantes (FTAG).

(tabla_goles_locales <- as.data.frame(table(Goles = datos_futbol$FTHG))) #local 

(tabla_goles_visitantes <- as.data.frame(table(Goles = datos_futbol$FTAG))) #visita


LE1920$FTHG # Goles anotados por los equipos que jugaron en casa
LE1920$FTAG # Goles anotados por los equipos que jugaron como visitante

# 3) Consultando la función table 
?table
# Esta función sirve para contruir tablas de frecuencia.



####                   Parte 2                        ####
# Elaborando tablas de frecuencia relativas para estimar probabilidades. 


# Aquí puede visualizar la tabla de frecuencias relativas: 

# Añadiendo la variable "6 goles" y freucuencia 0 para visitantes, para que los
# tamaños de los vectores sean iguales (Tuve que volver a 6 factor)
x <- data.frame(Goles = factor(6), Freq = c(0))

# Creando una nuevo df para Visitantes que incluye 6 goles
(tabla_goles_visitantes <- rbind.data.frame(tabla_goles_visitantes, x))

# Uniendo frecuencias de Locales y Visitantes en un df 
merge(tabla_goles_locales, tabla_goles_visitantes, by = "Goles")
tabla_frecuencias <- merge(tabla_goles_locales, tabla_goles_visitantes, by = "Goles")
colnames(tabla_frecuencias) <- c("Goles", "Locales", "Visitantes")

# TABLA DE FRECUENCIAS DE AMBOS EQUIPOS
tabla_frecuencias


####                   AHORA SÍ, LAS PROBABILIDADES                  ####

# 1) La probabilidad (marginal) de que el equipo que juega en casa anote 
#    "x" goles (x = 0, 1, 2, ...)

# Obteniendo los goles anotados por equipo local, y dividiendo entre el total 
# de partidos que se puede obtener con el número de filas. 
(probmar_locales <- (table(datos_futbol$FTHG)/dim(datos_futbol)[1])*100) 



# 2) La probabilidad (marginal) de que el equipo que juega como visitante 
#    anote "y" goles (y = 0, 1, 2, ...)

# Obteniendo los goles anotados por visitantes y dividiendo entre el total de 
# partidos. 
(probmar_visitantes <- (table(datos_futbol$FTAG)/dim(datos_futbol)[1])*100) 



# 3) La probabilidad (conjunta) de que el equipo que juega en casa anote "x" 
#    goles y el equipo que juega como visitante anote "y" goles 
#    (x = 0, 1, 2, ..., y = 0, 1, 2, ...).

(prob_conjunta <- (table(datos_futbol$FTHG, datos_futbol$FTAG)/dim(datos_futbol)[1])*100) 

