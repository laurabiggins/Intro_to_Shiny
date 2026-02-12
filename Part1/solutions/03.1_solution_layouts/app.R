library(shiny)

# Exercise 3

#  a. Add another plot showing x^3, make this use the x values 
#  from the slider.
#  b. Use sidebarLayout() - put the slider in a sidebar panel 
#  and the plots in the main panel.
#  c. Use the fluidRow() layout within the main panel to put 
#  the 2 plots in the same row. 
#  d. Resize the app (by clicking and dragging) to check that the 
#  plots stack one on top of the other when the window is narrow enough. 
#  e. Try changing the fluidRow() layout to a splitLayout() and 
#  resize the app again to see how it differs from using fluidRow().


ui <- fluidPage(

  titlePanel("Exercise 3"),
  br(),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "slider_x_range",
        label = "Select range for x",
        min = -100,
        max = 100,
        value = c(-10,10)
      )
    ),
    mainPanel(
      fluidRow(
        column(6, plotOutput("x_squared")),
        column(6, plotOutput("x_cubed"))
      )
      #splitLayout(plotOutput("x_squared"), plotOutput("x_cubed"))
    )
  )
)


server <- function(input, output) {

    output$x_squared <- renderPlot({

        x <- input$slider_x_range[1]:input$slider_x_range[2]

        plot(x^2, type = "l")
    })
    
    output$x_cubed <- renderPlot({
        
        x <- input$slider_x_range[1]:input$slider_x_range[2]
        
        plot(x^3, type = "l")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
