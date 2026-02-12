library(shiny)
library(bslib)

# Task:
# 
# 1. Set the default text for the Enter name field to "Anon"
# 
# 2. Add a label for the numericInput item asking the user to choose a number
# 
# 3. Change the step size on the slider to 5
# 
# 4. Add some extra information in output$info, telling the user what the value of n is. 

ui <- page_sidebar(
  
  title = "Exercise 1.1",
   
  sidebar = sidebar(
      
      textInput(inputId = "user_name", 
                label   = "Enter name"),
      
      numericInput(inputId = "number_chosen", 
                   label   = NULL, 
                   value   = 15),
      
      sliderInput(inputId = "slider", 
                  label   = "Choose another number",
                  min     = 10, 
                  max     = 100,
                  value   = 50),
    ),
      
    textOutput(outputId = "supplied_name"),
    textOutput(outputId = "info"),
    plotOutput(outputId = "density_plot", height = "300px", width = "400px")

)

server <- function(input, output, session) {
  
  output$supplied_name <- renderText({
    paste0("Hello ", input$user_name)
  })

  output$info <- renderText({
    "Below is a histogram showing output of the rnorm(n) function, where n is the sum of 
    your two selected numbers"
  })

  output$density_plot <- renderPlot({
    hist(rnorm(n = input$number_chosen * input$slider), main = "") 
  })
}

shinyApp(ui, server)

