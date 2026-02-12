library(shiny)

# Exercise 2:
# 
#  1. In the textInput, move the "Enter your name" text to be inside the box 
#  (use the placeholder argument) and remove the label (make it blank).
# 
#  2. Add a dropdown list (selectInput) with 7 options to allow the user to 
#  select their favourite colour.
#   
#  3. Update output$info to include the chosen colour along with the name.
#  

ui <- fluidPage(
  
  titlePanel("Exercise 2"),
  
  textInput(inputId = "name", label = "Enter your name"),
  
  radioButtons(inputId = "activity_choice", 
               label = "select activity", 
               choices = c("walk", "swim", "cycle")),
  
  textOutput(outputId = "info"),
  
  textOutput(outputId = "activity")
  
)

server <- function(input, output, session) {
  
  output$info <- renderText({
    paste0("Hello ", input$name)
  })
  
  output$activity <- renderText(paste0("You've chosen to ", input$activity_choice))
  
}

shinyApp(ui, server)

