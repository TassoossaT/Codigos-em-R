library(shiny)
library(shinydashboard)

user_sidebar <- list(
  ShynidashBoard = sidebarMenu(
      menuItem("Introdução", tabName = "ShynidashBoard" ),
      menuItem("Dinamismo", tabName = "Dinamismo")
  ),
  
  Header = sidebarMenu(
    menuItem("Header", tabName = "Header"),
    menuItem("Funções Header", tabName = "HeaderFunc")
    
  ),
  
  Sidebar = sidebarMenu(
      # Setting id makes input$tabs give the tabName of currently-selected tab
      #id = "tabs",
      menuItem("Sidebar", tabName = "Sidebar", icon = icon("dashboard")),
      menuItem("Funções SiderBar", icon = icon("th"), tabName = "Siderbarfunc", badgeLabel = "new",
               badgeColor = "green"),
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Gráficos", tabName = "graphs", icon = icon("bar-chart-o"),
               menuSubItem("Gráfico de Barras", tabName = "barplot"),
               menuSubItem("Histograma", tabName = "histogram")
      ),
      menuItem("Tabelas", tabName = "tables", icon = icon("table")),
      menuItem("Widgets", tabName = "widgets", icon = icon("gear"),
               menuSubItem("Caixa de Seleção", tabName = "checkbox"),
               menuSubItem("Botões de Rádio", tabName = "radiobuttons"),
               menuSubItem("Sliders", tabName = "sliders"),
               menuSubItem("Caixa de Texto", tabName = "textbox"),
               menuSubItem("Botão de Ação", tabName = "actionbutton"))
      
      ),
  
  Body = sidebarMenu(
    menuItem("Body", tabName = "Body"),
    menuItem("Funções do Body", tabName = "Bodyfunc")
  )
  
)

header <- dashboardHeader(
  title = "DashboardHeader()",
  #tags$li(class = "dropdown", 
  #       tags$a(style="cursor:pointer;", title="Search", 
  #               tags$i(class = "fa fa-search"), 
  #               tags$style(type = "text/css", ".main-header .navbar-custom-menu {margin-right: 100px;}"),
  #               tags$form(class = "navbar-form", 
  #                         tags$div(class = "form-group", tags$input(id = "searchInput", type = "text", class = "form-control", placeholder = "Search")),
  #                         tags$button(type = "submit", style = "display:none;")
  #               ))),
  # Dropdown menu for messages
  dropdownMenu(type = "messages", badgeStatus = "success",
               messageItem("Support Team","This is the content of a message.",time = "5 mins"),
               messageItem("Support Team","This is the content of another message.",time = "2 hours"),
               messageItem("New User","Can I get some help?",time = "Today")
  ),
  # Dropdown menu for notifications
  dropdownMenu(type = "notifications", badgeStatus = "warning",
               notificationItem(icon = icon("users"), status = "info","5 new members joined today"),
               notificationItem(icon = icon("warning"), status = "danger","Resource usage near limit."),
               notificationItem(icon = icon("shopping-cart", lib = "glyphicon"),status = "success", "25 sales made"),
               notificationItem(icon = icon("user", lib = "glyphicon"),status = "danger", "You changed your username")
  ),
  
  # Dropdown menu for tasks, with progress bar
  dropdownMenu(type = "tasks", badgeStatus = "danger",
               taskItem(value = 20, color = "aqua","Refactor code"),
               taskItem(value = 40, color = "green","Design new layout"),
               taskItem(value = 60, color = "yellow","Another task"),
               taskItem(value = 80, color = "red","Write documentation" )
  ))

sidebar <- dashboardSidebar(
  sidebarUserPanel("User Name",
                   subtitle = a(href = "#", icon("circle", class = "text-success"), "Online"),
                   # Image file should be in www/ subdir
                   image = "https://th.bing.com/th/id/OIP.HYfBj1Mu3umvZP-u4bPnHAHaIO?pid=ImgDet&rs=1"),
  sidebarSearchForm(label = "Enter a number", "searchText", "searchButton"),
  selectInput("user", "Selecione o usuário:", choices = list("ShynidashBoard","Header", "Sidebar", "Body")),
  uiOutput("user_sidebar")
 # actionButton('switchtab', 'Switch tab')
)

body <- dashboardBody(
  tags$head(
    tags$style(HTML("
        .skin-blue .main-header .logo {
          font-size: 24px;
        }
        .skin-blue .main-header .navbar {
          font-size: 18px;
        }
        .main-sidebar, .left-side {
          font-size: 16px;
        }
        .content-wrapper, .right-side {
          font-size: 20px;
        }
      "))
  ),
  tabItems(
    tabItem("ShynidashBoard",
            h2("Trabalho em R: ShinydashBoard - Tasso "),
            p("O Shiny dashboard é um pacote que auxilia você a 
              criar Dashyboards com shiny de maneira mais facil,
              ele precisa ter o shiny instalado junto por conta disso"),
            p("O pacote tem como principal função a dashboardPage,
              é reponsavel por criar a pagina inicial, ela precisa receber 
              3 outras funções do pacote para ser gerado, a dashboardHeader(), dashboardSidebar() e a dashboardBody(),
              estas funções por sua vez criam o:"),
            p("Header - Barra Superior: onde se pode colocar titulos, botões, links, notificações, etc"),
            p("SideBar - Barra Lateral: é a barra lateral, onde se pode ter o menu de navegação, logos, textos até inputs e outputs"),
            p("Body - Corpo Princial: onde é construido o conteudo em si, é possivel fazer quase tudo aqui")
            ),
    tabItem("Dinamismo",
            p("o pacote oferece diversas funções para deixar os itens dinamicos,
              eles vem escrito output no nome e ficam no lado de dentro da ui, e os que tem render no nome
              geram os itens e ficam no lado do cliente/server, basicamente a output pega a saida da render"),
            p("existem algumas funções especificas e outras genericas para gerar os itens necessarios")
            ),
    tabItem("Header",
            p("A barra superior serve principalmente para colocar caixas de mensagens,
              notificações ou tarefas a serem feitas, mais como um aviso, mas tambem é possivel colocar botões, inputs, outputs e até uma caixa de pesquisa"),
            tags$img(src = "https://rstudio.github.io/shinydashboard/images/menu-tasks.png"),
            p("o Header é gerado pela função DashboardHeader(), é possivel criar caixas dentro da barra superior usando, como também é possivel criar um menu dinamico
              que pode mudar de acordo com as alterações do usuario ou outros fatores"),
            tags$a(href = "https://rstudio.github.io/shinydashboard/structure.html#header", "Link para a pagina do header")
            ),
    
    tabItem("HeaderFunc",
            fluidRow(
              title = "funções dentro de Header",
            box(title = "dropdownMenu()", status = "primary", solidHeader = TRUE,
                p("esta função cria um menu no Header, como se fosse uma caixa para outros itens"),
                tags$a(href = "https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/dropdownMenu", "Link para a função")),
            box(title = "dropdownMenuOutput()", status = "primary", solidHeader = TRUE,
                p("similar ao dropdownMenu() porém esta cria um menu dinamico, ela pode receber como parametro dropdownMenu(), para gerar o item voce deev usar o render menu no lado do server"),
                tags$a(href = "https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/dropdownMenuOutput", "Link para a função"),
                tags$br(),
                tags$a(href ="https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/renderMenu", "Link para a função renderMenu")),    
            box(title = "messageItem()", status = "primary", solidHeader = TRUE,
                p("cria uma mensagem em texto"),
                tags$a(href = "https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/messageItem", "Link para a função",target = "_blank")),
            box(title = "notificationItem()", status = "primary", solidHeader = TRUE,
                p("cria uma notificação, alarme, aviso, cotem status que permite classificar as notificações"),
                tags$a(href = "https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/notificationItem", "Link para a função")),
            box(title = "taskItem()", status = "primary", solidHeader = TRUE,
                p("cria uma tarefa, pode conter o quão completa está, se foi concluida ou não e outras funções como lista de afaseres"),
                tags$a(href = "https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/taskItem", "Link para a função")),
        )),
    tabItem("Sidebar",
            p("a barra lateral serve principalmente como menu de navegação, mas ela pode servir tambem para colar logos, inputs e outputs, botões, area de pesquisa e diversas outras,"),
            tags$img(src = "https://rstudio.github.io/shinydashboard/images/sidebar.png"),
            p("mas como principal função a navegação pode ser muito versatil para criar infinitas formas de exibições,
              é possivel criar uma sidebar dinamica, usando as funçoes uiOutput, renderUI, também é possivel criar logins para usuarios"),
            p("a sidebar é gerada pela função dashboardSidebar(), ela pode receber sidebarMenu que é o conjunto de elementos da barra que pode 
              conter diversos menuItem que representa cada elemento, para a identificação ela recebe a tabName que é o que linka o o item da barra com o body"),
            tags$a(href = "https://rstudio.github.io/shinydashboard/structure.html#sidebar", "Link para a pagina da sidebar")      
    ),
    tabItem("Siderbarfunc",
            fluidRow(
              title = "sidebar",
              box(title = "sidebarMenu()",
                p("os itens do menu são colocados dentro dessa função, basicamente é uma caixa de menuItem"),
                tags$a(href = "https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/sidebarMenu", "Link para a pagina do codigo")
              ),
              box(title = "menuItem()",
                  p("é o elemento da barra lateral, ele detem a tabName que define a tag que vai se usada de referencia para gerar o body correspondente ")                  ),
              box(title ="sidebarSearchForm()",
                  p("é uma barra de pesquisa"),
                  tags$a(href = "https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/sidebarSearchForm", "Link para a pagina do codigo")    
              ),
              box(title = "SideBar Dinamica", status = "primary", solidHeader = TRUE,
                  p("é possivel criar uma barra lateral dinamicamente gerada, pode ser por uma ação especifica do usuario ou alum outro evento,
                    usando a função sidebarMenuOutput() na ui para gerar de acordo com a saida do renderMenu({}) que fica no cliente"),
              tags$a(href = "https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/sidebarMenuOutput", "Link para a pagina do codigo"),
              tags$br(),
              tags$a(href ="https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/renderMenu", "Link para a função renderMenu"))
              )),
    tabItem("Body",
            p("o Body é onde fica todo o conteudo do seu dashboard praticamente, nele é possivel criar todo tipo de coisa,
              a função dashboardBody() é a que cria ele, ele pode receber uma Função chamada tabItems()  que  é basicamente uma caixa de tabItem,
              a tabItem é a definição de um body que fica dentro de um elemento na sidebar, ele recebe o argumento tabName da função menuItem() para linkar uma a outra"),
          tags$a(href = "https://rstudio.github.io/shinydashboard/structure.html#body", "Link para a pagina do Body")
    ), 
    tabItem("Bodyfunc",
            fluidRow(
            box(title = "box( )", status = "primary", solidHeader = TRUE,
                p("essa função cria uma caixa separada no corpo, aceita inputs e outputs, normalmente é colocado dentro de uma fluidrow()"),
            tags$a(href ="https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/box", "Link para a função")),
            tabBox(
              tabPanel("tabBox( )","cria uma caixa que possibilita a seleção, se comporta igual uma box",
                       tags$a(href ="https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/tabBox", "Link para a função")),
              tabPanel("tabPanel( )","Define as abas ")),
            box(title = "infoBox( )", status = "primary", solidHeader = TRUE,
            p("caixa de informação, como normalmente vai ser usado dinamicamente existe a função infoBoxOutput( ),
              ela pega os valores da renderInfoBox( ) "),
            infoBox("infoBox","caixa de informação", fill = TRUE),
            tags$a(href ="https://www.rdocumentation.org/packages/shinydashboard/versions/0.7.2/topics/infoBox", "Link para a função")
            ))),
            tabItem("dashboard",
            fluidRow(
            box(plotOutput("plot1", height = 250)),
            box(title = "Controles",
                          sliderInput("slider", "Número de observações:", 1, 100, 50)
                        )
                      )
              ),
              tabItem("tables",
                      fluidRow(
                        box(tableOutput("table"))
                      )
              ),
              tabItem("widgets",
                      fluidRow(
                        box(textOutput("text"))
                      )
              ),
              tabItem("barplot",
                      fluidRow(
                        box(plotOutput("barplot", height = 250))
                      )
              ),
              tabItem("histogram",
                      fluidRow(
                        box(plotOutput("histogram", height = 250))
                      )
              ),
              tabItem("checkbox",
                      fluidRow(
                        box(checkboxGroupInput("checkGroup", "Escolha as opções:", choices = list("Opção 1" = 1, "Opção 2" = 2, "Opção 3" = 3)))
                      )
              ),
              tabItem("radiobuttons",
                      fluidRow(
                        box(radioButtons("radio", "Escolha uma opção:", choices = list("Opção 1" = 1, "Opção 2" = 2, "Opção 3" = 3)))
                      )
              ),
              tabItem("sliders",fluidRow(box(sliderInput("slider3", "Escolha um valor:", min = 0, max = 100, value = 50)))),
              tabItem("textbox",fluidRow(box(textInput("text2", "Insira o texto:")))),
              tabItem("actionbutton",fluidRow(box(actionButton("action", "Clique em mim"))))))

server <- function(input, output, session) {
  output$user_sidebar <- renderUI({
    user_sidebar[[input$user]]
  })
  output$plot1 <- renderPlot({
    data <- rnorm(input$slider)
    # Gere o gráfico
    plot(data)
    # Adicione o código para gerar o gráfico aqui
  })
  output$barplot <- renderPlot({
    # Adicione o código para gerar o gráfico aqui
    barplot(rnorm(50))
  })
  output$histogram <- renderPlot({
    # Adicione o código para gerar o gráfico aqui
    hist(rnorm(50))
  })
}

shinyApp(
  ui = dashboardPage(header, sidebar, body),
  server = server
)