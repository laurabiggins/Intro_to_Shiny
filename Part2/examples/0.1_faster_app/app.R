library(shiny)
library(magrittr)
library(ggplot2)

iris_categories <- colnames(dplyr::select(iris, -Species))

ui <- fluidPage(
  
  br(),
  sidebarLayout(
    
    sidebarPanel(width = 4,
      
      textInput(inputId = "plot_name", 
                label = "Enter plot name"),
      radioButtons(inputId = "radio_colour", 
                   label   = "select point colour",
                   choices = c("blue", "red"),
                   inline = TRUE),
      selectInput(inputId = "x_attribute", 
                  label   = "x axis", 
                  choices = iris_categories),
      selectInput(inputId  = "y_attribute", 
                  label    = "y axis",
                  choices  = iris_categories, 
                  selected = iris_categories[2]),
      sliderInput(inputId = "slider", 
                  label   = "point size",
                  min = 1, max = 8, value = 3)
    ),
    mainPanel(
           plotOutput(outputId = "iris_plot", width = "500px", height = "500px")
    )
  )
)

server <- function(input, output, session) {
  
  point_size <- reactive({
    Sys.sleep(2)
    input$slider + 0.1
  })
  
  output$iris_plot <- renderPlot({
    
      ggplot(data = iris, aes(x = .data[[input$x_attribute]], 
                              y = .data[[input$y_attribute]])) +
      geom_point(size = point_size(), colour = input$radio_colour) +
      ggtitle(input$plot_name)
  })
  
}


















shinyApp(ui, server)

