library(shiny)
library(bslib)

ui <- page_fillable(

    titlePanel("Simple app"),
    
    radioButtons(inputId  = "letter_choice", 
                  label   = "Select a letter", 
                  choices = LETTERS[1:5]),
    
    numericInput(inputId = "number_choice",
                 label   = "Type in a number",
                 value   = 4),
 
    textOutput(outputId = "message")
)

server <- function(input, output, session) {
  
  output$message <- renderText({
    
    paste0("You selected the letter ", input$letter_choice, 
          " and the number ", input$number_choice)
  })
  
}

shinyApp(ui = ui, server = server)
