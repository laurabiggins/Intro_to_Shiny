library(shiny)

# Exercise 5 solution
# 
# Task:
# 1. get the app working
#     Fix the bugs in this code - there should be 3
# 
# 2. a. Use sidebarLayout to put all the options in a sidebar and the plot 
#   in the main panel
#   b. Add radioButtons to allow the user to change the colour of the plot.

ui <- fluidPage(
  
  titlePanel("Exercise 5"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      sliderInput(
        inputId = "chosen_number", 
        label   = "Choose a number",
        min     = 10, 
        max     = 1000, 
        value   = 500, # missing value
        step    = 10
      ),
      textOutput(outputId = "info"), # unmatched outputId
      br(),
      radioButtons(
        inputId = "distribution",
        label = "Select distribution type",
        choices = c("normal", "uniform"),
        inline = TRUE
      ),
      
      radioButtons(
        inputId = "chosen_colour",
        label = "Select colour",
        choices = list(
          "red" = "red3",
          "blue" = "blue3",
          "green" = "green3"
        ),
        inline = TRUE
      )
    ),
    mainPanel(
      
      plotOutput(outputId = "normal_distribution")
    )
  )  
)

server <- function(input, output, session) {
  
  # missing render function
  output$info <- renderText({ 
    paste0("Your chosen number is ", input$chosen_number)
  })  

  output$normal_distribution <- renderPlot({
    
    plotting_data <- if(input$distribution == "normal") {
      rnorm(input$chosen_number)
    } else {
      runif(input$chosen_number)
    }
    
    hist(plotting_data, 
         main = paste0(input$distribution, " distribution, n = ", input$chosen_number),
         col = input$chosen_colour
    )
  })

}

shinyApp(ui, server)