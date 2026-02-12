library(shiny)

ui <- fluidPage(
  h1("Inputs"),
  br(),
  fluidRow(
    column(6, offset = 0.5,
      wellPanel(
        verticalLayout(
          fluidRow(
            column(5,strong('actionButton()')),
            column(7, actionButton(inputId = "", label = "action button"))
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('actionLink()')), 
            column(7, actionLink(inputId = "", label = "action link"))
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('checkboxGroupInput()')), 
            column(7, checkboxGroupInput(inputId = "", label = NULL, choices = c("apple", "pear", "banana")))
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('checkboxInput()')), 
            column(7, checkboxInput(inputId = "", label = "single checkbox"))
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('dateInput()')), 
            column(7, dateInput(inputId = "", label = NULL))
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('dateRangeInput()')), 
            column(7, dateRangeInput(inputId = "", label = NULL))
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('numericInput()')), 
            column(7, numericInput( inputId = "", label = NULL, value = 8))
          )
        )
      )
    ),
    column(5, offset = 0.5,
      wellPanel(
        verticalLayout(
          fluidRow(
            column(5, strong('passwordInput()')), 
            column(7, passwordInput(inputId = "", label = NULL))
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('radioButtons()')), 
            column(7, radioButtons( inputId = "", label = NULL, choices = c("choose me", "or me", "or this option")),)
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('selectInput()')), 
            column(7, selectInput(inputId = "", label = NULL, choices = c("choose me", "or me", "or this option")),)
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('sliderInput()')), 
            column(7, sliderInput(inputId = "", label = NULL, min = 5, max = 500, value = 20, step = 50))
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('textInput()')), 
            column(7, textInput(inputId = "", label = NULL),)
          ),
          hr(style = "border: 0.5px double #141f80;"),
          fluidRow(
            column(5, strong('fileInput()')), 
            column(7, fileInput(inputId = "", label = NULL))
          )
        )
      )  
    )  
  )
)
  
server <- function(input, output, session) {
}

shinyApp(ui, server)
