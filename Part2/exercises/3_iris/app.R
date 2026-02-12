library(shiny)
library(tidyverse)

# Create a Shiny application using the sidebarLayout and the iris dataset
# 
# 1 a. In the sidebarPanel, create radio buttons to select between sepal length,
#     sepal width, petal length and petal width
# 
#   b. In the main panel, create a boxplot showing the attribute selected from the radio buttons
#     for the 3 different species. 
# 
#   c. Add a textInput to allow the user to name the plot
# 
#      
# 2 a. Add a checkboxInput that when clicked, shows the individual points on the plots.

ui <- fluidPage(
  
  titlePanel("Exercise 3"),
  
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "plot_name", label = "Enter plot name"),
      br(),
      actionButton(inputId = "boxplot", label = "boxplot"),
      actionButton(inputId = "violinplot", label = "violinplot"),
      actionButton(inputId = "barplot", label = "barplot"),
      br(),
      checkboxInput(inputId = "add_points", label = "show data points")
    ),
    mainPanel(
      plotOutput(outputId = "iris_plot"),
    )
  ),
  #actionButton("browser", "browser")
)

server <- function(input, output, session) {
  
  plotting_object <- reactiveVal()
  
  plot_base <- reactive({
    iris %>%
      ggplot(aes(x = Species, y = Sepal.Length, fill = Species)) +
      ggtitle(input$plot_name)
      
  })
  
  observeEvent(input$boxplot, {
    
    p <- plot_base() +
      geom_boxplot()
    
    plotting_object(p)
  })
  
  observeEvent(input$barplot, {
    
    p <- plot_base() +
      geom_col()
    
    plotting_object(p)
  })
  
  observeEvent(input$violinplot, {
    
    p <- plot_base() +
      geom_violin()
    
    plotting_object(p)
  })
  
  output$iris_plot <- renderPlot({
    
    p <- plotting_object()

    if(input$add_points) {
      p + geom_jitter(width = 0.2, height = 0)
    } else {
      p
    }
  })
  
  observeEvent(input$browser, {
    browser()
  })
  
}

shinyApp(ui, server)

