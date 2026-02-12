library(shiny)
library(magrittr)
library(ggplot2)

options(shiny.reactlog = TRUE)
iris_categories <- colnames(dplyr::select(iris, -Species))

ui <- fluidPage(

  titlePanel("Multiple inputs"),
  
  fluidRow(
    column(7,
           plotOutput(outputId = "iris_plot", width = "400px"),
    ),
    column(3,
           br(), br(),
           radioButtons(inputId = "radio_colour", 
                 label   = "select point colour",
                 choices = c("blue", "red", "black"))
    )
  ),
  sliderInput(inputId = "slider", 
              label   = "point size",
              min = 1, max = 10, value = 3, step = 0.5), 
  flowLayout(selectInput(inputId = "x_attribute", 
                         label   = "x axis", 
                         choices = iris_categories),
             selectInput(inputId  = "y_attribute", 
                         label    = "y axis",
                         choices  = iris_categories, 
                         selected = iris_categories[2]),
             textInput(inputId = "plot_name", 
                       label = "Enter plot name")
  ),
  actionButton("browser", "browser")
)

server <- function(input, output, session) {
  
  point_size <- function(){
    Sys.sleep(2)
    input$slider + 0.1
  }
  
  output$iris_plot <- renderPlot({
    
    iris %>%
      ggplot(aes(x = .data[[input$x_attribute]], 
                 y = .data[[input$y_attribute]])) +
        geom_point(size = point_size(), 
                   colour = input$radio_colour) +
        ggtitle(input$plot_name)
  })
  
  observeEvent(input$browser, {
    
    browser()
    
  })

  
  
  
  
  
    
}

shinyApp(ui, server)

