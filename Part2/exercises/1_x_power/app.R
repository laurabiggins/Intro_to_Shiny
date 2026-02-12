library(shiny)

# Extract duplicated code from the renderPlot functions and put it into a reactive expression

ui <- fluidPage(

  titlePanel("Exercise 1"),
  br(),

  sidebarLayout(
    
    sidebarPanel(
      sliderInput(
        inputId = "slider_x_range",
        label   = "Select range for x",
        min     = -100,
        max     = 100,
        value   = c(-10,10)
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          title = "x squared", 
          plotOutput(
            "x_squared", 
            width  = 400, 
            height = 400
          )
        ),
        tabPanel(
          title = "x cubed", 
          plotOutput(
            "x_cubed", 
            width  = 400, 
            height = 400
          )
        )
      )
    )
  )    
)


server <- function(input, output) {

  output$x_squared <- renderPlot({

    x_values <- input$slider_x_range[1]:input$slider_x_range[2]

    plot(x_values^2, type = "l")
  })

  output$x_cubed <- renderPlot({
    
    x_values <- input$slider_x_range[1]:input$slider_x_range[2]
    
    plot(x_values^3, type = "l")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
