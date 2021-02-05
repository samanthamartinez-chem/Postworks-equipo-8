###              ###
##   POSTWORK 8   ##
###   Equipo 8   ###


# Para este postwork generaremos un dashboard con los datos de la liga española de fútbol

# Ejecuta el código momios.R
# Almacena los gráficos resultantes en formato png

# Crea un dashboard donde se muestren los resultados con 4 pestañas:

# 1. Una con las gráficas de barras, donde en el eje de las x se muestren los goles
#    de local y visitante con un menu de selección, con una geometria de tipo barras
#    además de hacer un facet_wrap con el equipo visitante
# 2. Realiza una pestaña donde agregues las imágenes de las gráficas del postwork 3
# 3. En otra pestaña coloca el data table del fichero match.data.csv
# 4. En otra pestaña agrega las imágenes de las gráficas 
#    de los factores de ganancia mínimo y máximo


library(ggplot2)
library(shiny)
library(shinydashboard)
library(shinythemes)

ui <-   
  fluidPage(    
    dashboardPage(      
      # Creando el Título del dashboard
      dashboardHeader(title = "Postwork Sesión 8 - Dashboard sobre liga española"),      
      # Generando la Barra lateral
      dashboardSidebar(        
        # Haciendo la Lista/Menú con los títulos de las 4 secciones del dashboard y su ícono
        sidebarMenu(
          menuItem("Gráficas de barras", tabName = "Dashboard", icon = icon("dashboard")),
          menuItem("Gráficas del Postwork 3", tabName = "postwork3", icon = icon("area-chart")),
          menuItem("Data Table de BBDD", tabName = "dataTable", icon = icon("table")),
          menuItem("Factores de ganancia", tabName = "momios", icon = icon("file-picture-o"))          
        )        
      ),
      
      # Creando el Cuerpo de la página
      # Aquí se genera la vista de las 4 secciones que contiene el dashboard
      dashboardBody(        
        tabItems(         
          
          # Sección 1
          # Barchart de los goles de los equipos en local y visitante
          tabItem(
            tabName = "Dashboard",
            fluidRow(                    
              titlePanel(h1("Goles a favor y en contra por equipo")), 
              selectInput("x", "Seleccione el valor de X",
              choices = c("home.score", "away.score")),
              plotOutput("plot1", height = 450, width = 750)
            )
          ),
          
          # Sección 2
          # Imágenes del Postwork 3 donde mostramos las gráficas de probabilidad
          # de goles para el equipo local y visitante 
          tabItem(
            tabName = "postwork3", 
            fluidRow(
              titlePanel(h1("Gráficas de Probabilidad de goles del equipo local y visitante"))
            ),
            fluidRow(img(src = "./images/barchartLocal.png")),
            fluidRow(img(src = "./images/barchartVisitante.png")),
            fluidRow(img(src = "./images/heatmapConjuntas.png"))
          ),
          
          # Sección 3
          # Tabla de los datos en el dataset match.data.csv
          tabItem(
            tabName = "dataTable",
            fluidRow(        
              titlePanel(h1("Data Table de BBDD match.data.csv")),
              dataTableOutput ("dataTable")
            )
          ), 
          
          # Sección 4
          # Imágenes de los momios
          tabItem(tabName = "momios",
            fluidRow(
              titlePanel(h1("Factores de ganancia mínimo y máximo"))
            ),
            fluidRow(
              h3("Factor de ganancia Máximo"),
              img( src = "./images/momiosMaximo.png", height = 350, width = 550)
            ),
            fluidRow(
              h3("Factor de ganancia Promedio"),
              img( src = "./images/momiosPromedio.png", height = 350, width = 550)
            )
          )
        )
      )
    )
  )

# Cargar los datos para la ui usando el server
server <- function(input, output) {
  
  # Sección 1. Barcharts goles local y visitante
  # Generando las gráficas de los goles de los equipos
  # y haciendo el face_wrap
  output$plot1 <- renderPlot({    
    data <-  read.csv("./bd/match.data.csv", header = T)
    
    data <- mutate(
      data, 
      FTR = 
      ifelse(home.score > away.score, 
      "H", 
      ifelse(home.score < away.score, "A", "D")))
    
    x <- data[,input$x]
    
    data %>% ggplot(aes(x, fill = FTR)) + 
      geom_bar() + 
      facet_wrap("away.team") +
      labs(x =input$x, y = "Goles") + 
      ylim(0,50)
  }
)

  # Sección 3. Data Table match.data.csv
  # Obteniendo los datos el dataset y mandándolos a la ui
  output$dataTable <- renderDataTable( 
    {data}, 
    options = list(aLengthMenu = c(10,25,50),
                  iDisplayLength = 10)
  )  
}

# Ejecutar el dashboard
shinyApp(ui, server)