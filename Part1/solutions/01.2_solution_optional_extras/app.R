library(shiny)

ui <- fluidPage(
  
  titlePanel("Exercise 1.2"),
  textInput(inputId = "first_name", 
            label   = "Enter first name"),
  textInput(inputId = "last_name", 
            label   = "Enter last name"),
  radioButtons(inputId = "age", 
               label   = "select age bracket", 
               choices = c("1-10","11-20","21-30",
                           "31-40","41-50","51-60",
                           "61-70","71-80"),
               inline = TRUE),
  sliderInput(inputId = "height", 
              label   = "Select approximate height (cm)",
              min     = 70, 
              max     = 220,
              value   = 170),
  textOutput(outputId = "supplied_name"),
  br(),
  textOutput(outputId = "info")
)

server <- function(input, output, session) {
  
  output$supplied_name <- renderText({
    paste0("Hello ", 
           input$first_name, 
           " ",
           input$last_name)
  })
  output$info <- renderText({
    paste0("You are approximately ", 
           input$height, 
           "cm tall and ", 
           input$age,
           " years old.")
  })
}

shinyApp(ui, server)
