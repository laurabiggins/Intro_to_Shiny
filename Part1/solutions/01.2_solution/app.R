library(shiny)

ui <- fluidPage(
  
  titlePanel("Exercise 1.2"),
  textInput(
    inputId = "first_name", 
    label   = "Enter first name"
  ),
  textInput(
    inputId = "last_name", 
    label   = "Enter last name"
  ),
  numericInput(
    inputId = "height", 
    label   = "Enter approximate height (cm)",
    value   = 150
  ),
  textOutput(outputId = "supplied_name"),
  textOutput(outputId = "info")
)

server <- function(input, output, session) {
  
  output$supplied_name <- renderText({
    paste0("Hello ", 
           input$first_name, 
           " ", 
           input$last_name,
           "You are approximately ", 
           input$height, 
            "cm tall.")
  })
  # output$info <- renderText({
  #   paste0("You are approximately ", 
  #          input$height, 
  #          "cm tall.")
  # })
}  

shinyApp(ui, server)
