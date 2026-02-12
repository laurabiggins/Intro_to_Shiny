library(shiny)
library(magrittr)
library(ggplot2)

ui <- fluidPage(
  
  br(),
  
  plotOutput(outputId = "iris_plot", 
             width    = 300, 
             height   = 300),
  
  sliderInput(inputId = "slider", 
              label   = "point size",
              min     = 1, 
              max     = 8, 
              value   = 3)
)


server <- function(input, output, session) {
  
  output$iris_plot <- renderPlot({
    
    iris %>%
      ggplot(aes(x = Sepal.Length, y = Sepal.Width)) +
        geom_point(size = input$slider)
  })
}

shinyApp(ui, server)

