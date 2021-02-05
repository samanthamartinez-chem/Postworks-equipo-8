###              ###
##   POSTWORK 7   ##
###   Equipo 8   ###


# Objetivo: Realizar el alojamiento del fichero de un fichero .csv a una base de datos
# (BDD), en un local host de Mongodb a traves de R.

# Desarrollo: Utilizando el manejador de BDD Mongodb Compass (previamente instalado),
# deberás de realizar las siguientes acciones:

# 1) Alojar el fichero data.csv en una base de datos llamada match_games, nombrando 
# al collection como match.
# Primero ocuparemos la librería para mongodb 

library("mongolite")
library("dplyr")

# Paquete para solucionar problemas con el data.table
# install.packages("data.table", dependencies=TRUE)
match = data.table::fread("data.csv")

# Visualizandos los resultados.
View(match)

# Creando la conexión, la BBDD y la colección. 
newMatch = mongo(collection = "match", db = "match_games")

# Insertando los valores del csv a nuestra base de datos.
newMatch$insert(match)


# 2) Haciendo un count para conocer el número de registros que se
# tiene en la base.
newMatch$count() # Devuelve 1140 registros.

# 3) Realizar una consulta utilizando la sintaxis de Mongodb, en la base de datos para
# conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y 
# contra que equipo jugó, ¿perdió ó fue goleada?

# Visualizando valores que tenemos en nuestra colección.
newMatch$iterate()$one()

# Visualizando los partidos jugados el 20 de Diciembre del 2015
newMatch$find('{"Date" :"2015-12-20"}')

# El resultado que nos arroja es un data frame vacío, podemos concluir que no se
# realizó nincún partido en esa fecha y por ende no tiene sentido hacer nuestra 
# busqueda. De una forma u otra, la consulta sería:

# newMatch$find('{"Date":"2015-12-20", "HomeTeam":"Real Madrid"}') Si jugase como local
# newMatch$find('{"Date":"2015-12-20", "AwayTeam":"Real Madrid"}') Si jugase como visitante

# 4) Agregando el dataset de mtcars a la misma BDD. 
newMatch = mongo(collection = "mtcars", db = "match_games")

# Insertando los valores del csv a nuestra base de datos.
newMatch$insert(mtcars)

# Contando los resultados.
newMatch$count() # Nos da como resultado 32 registros.

# Visualizando el primer valor del collection.
newMatch$iterate()$one()

# 5) Cerrando la conexión a la BBDD
rm(newMatch)
