library(shiny)
library(magrittr)
library(ggplot2)

# This is bad Shiny programming.
# It looks like it works until the radio button is switched from ggplot to baseR.
# without changing any of the other options.
# Why doesn't it work properly?
# Because the baseR_plot reactive expression is not actually returning a data object.
# The plot created is a side effect of the function being run, so it only works
# when the code is actually run. Base R plots directly on to the plotting area 
# and doesn't save the object, unlike ggplot which saves the plotting object, allowing 
# it to be called later on.
# The reactive expression ggplot_object() works nicely, but baseR_plot() does not.

iris_categories <- colnames(dplyr::select(iris, -Species))

ui <- fluidPage(
  h1(icon("exclamation-circle"), "bad code", icon("exclamation-circle")),
  br(),
  radioButtons(inputId = "plot_type",
               label = NULL,
               choices = list("base R" = "baseR", "ggplot" = "ggplot")),
  plotOutput(outputId = "iris_plot", width = "400px"),
  sliderInput(inputId = "slider", 
              label   = "point size",
              min     = 1, 
              max     = 8, 
              value   = 3, 
              step    = 0.5), 
  flowLayout(selectInput(inputId = "x_attribute", 
                         label   = "select attribute for x axis", 
                         choices = iris_categories),
            selectInput(inputId  = "y_attribute", 
                        label    = "select attribute for y axis",
                        choices  = iris_categories, 
                        selected = iris_categories[2]),
            textInput(inputId = "plot_name", 
                      label = "Enter plot name")
  ),
  radioButtons(inputId = "radio_colour", 
               label   = "select point colour",
               choices = c("blue", "red", "black")
               ),
  actionButton("browser", "browser")
)

server <- function(input, output, session) {
  
  output$iris_plot <- renderPlot(plotting_object())


  plotting_object <- reactive({
    
    switch(input$plot_type,
           ggplot = ggplot_object(),
           baseR  = baseR_plot()
    )
  })
  
  ggplot_object <- reactive({
    
    iris %>%
      ggplot(aes(x = .data[[input$x_attribute]], y = .data[[input$y_attribute]])) +
        geom_point(size = input$slider, colour = input$radio_colour) +
        ggtitle(input$plot_name)
    
  })
  
  baseR_plot <- reactive({
    
    plot(x = iris[,input$x_attribute], 
         y = iris[,input$y_attribute], 
         cex  = input$slider,
         main = input$plot_name,
         col  = input$radio_colour,
         xlab = input$x_attribute, 
         ylab = input$y_attribute)
  })
  
  observeEvent(input$browser, {
    
    browser()
    
  })
  
}

shinyApp(ui, server)

