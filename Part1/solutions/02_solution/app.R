library(shiny)

# Solution to Exercise 2:
# 
#  1. In the textInput, move the "Enter your name" text to be inside the box 
#  (use the placeholder argument) and remove the label (make it blank).
# 
#  2. Add a dropdown list (selectInput) with 7 options to allow the user to 
#  select their favourite colour.
#   
#  3. Update output$info to include the chosen colour along with the name.

ui <- fluidPage(
  
  titlePanel("Exercise 2"),
  
  textInput(inputId = "name", 
            label = "", 
            placeholder = "Enter your name"), # added placeholder text
  
  selectInput(inputId = "colour", 
              label   = "Select your favourite colour",
              choices = c("red", "orange", "yellow", "green", "blue", "indigo", "violet")), # added dropdown option
  
  radioButtons(
    inputId = "activity_choice", 
    label   = "select activity", 
    choiceNames =  list(
      icon("walking"),
      icon("swimmer"),
      icon("bicycle")
    ),
    choiceValues = list(
     "walk", 
     "swim", 
     "cycle"
    )
  ),
  
  textOutput(outputId = "info"),
  
  textOutput(outputId = "activity")
    
)

server <- function(input, output, session) {
  
  output$info <- renderText({
    paste0("Hello ", input$name, ", your favourite colour is ", input$colour) # updated to include colour
  })
  
  output$activity <- renderText(paste0("You've chosen to ", input$activity_choice))
  
}

shinyApp(ui, server)

