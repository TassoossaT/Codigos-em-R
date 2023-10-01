#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(openxlsx)


#dados <- rnorm(100)
dados <- read.xlsx("ANEEL_CP62_2020.xlsx") 
options(scipen = 999)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  titlePanel("Meu Histograma"),
  
  sidebarLayout( 
    sidebarPanel("Escolha as opcoes:",
                selectInput("variavel", h5("Escolha as Variaveis"),
                              choices =  list("Rede"     = "rede", 
                                              "Trafo"    = "trafo",
                                              "Mercado"  = "mercado",
                                              "UC"       = "uc",
                                              "PMSO"     = "pmso"), 
                            selected = "rede"),
                radioButtons("radioButton", 
                          label = h3("Como quer tratar os dados?"), 
                          choices = list( "Log na base 10" = "1", 
                                          "Log na base e"  = "2",
                                          "sem tratamento" = "3"),
                          selected = "3"),
                checkboxInput("freq",
                          label="Mostrar por frequencia",value=FALSE),

                selectInput("select", h5("tipo de analise"),#tipo de analise
                            choices = list( "Gaussiano"   = "gaussian", 
                                            "Retangular"  = "rectangular",
                                            "Triangular"  = "triangular"), 
                            selected = "gaussian"),
                #escolha da parte dos dados
                sliderInput("slider", h5("Bandwidth"),# range
                            min = 0.01, max = 1, value = 0.01, 
                            step=0.01)),
                                

    mainPanel(
      "Grafico de saida",
      textOutput("OutText"),
      plotOutput("OutPlot")
      ) 
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {

  output$OutText <- renderText({ input$slider })
  output$OutPlot <- renderPlot({ 
  dadostrat <-dados[input$variavel]
      if (input$radioButton == "1")
        {
          dadostrat <- log10(dadostrat[dadostrat > 0])
        } else if (input$radioButton == "2")
          {
            dadostrat <- log(dadostrat[dadostrat > 0])
          } else dadostrat <- dados[-1,input$variavel]
          
  out <- density(dadostrat, 
                bw = max(dadostrat)*input$slider, 
                kernel = input$select)
    grid()
    if (input$freq)
      {
        hist(dadostrat, main = "", xlab = "meus dados",
        freq = input$freq,
        col = "light blue",
        ) 
      }else
        {
        hist(dadostrat, main = "", xlab = "meus dados",
            freq = input$freq,
            col = "light blue",
            ylim = c(0, max(out$y)),
          )
        lines(out, lty=1, lwd = 3, col = "red")
        }
    
    
    })
  
  }

# Run the application 
shinyApp(ui = ui, server = server)
#shiny::runApp()
# no Vscode