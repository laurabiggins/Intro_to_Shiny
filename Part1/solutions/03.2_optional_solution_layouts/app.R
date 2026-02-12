library(shiny)

# Exercise 3 - solution to optional section

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
#   
# [Optional]
#  1. Add a tabsetPanel() within the main panel and put each 
#   plot in a tabPanel().
#  2. Make the plots square (ish) - use height and and width 
#   arguments in the plotOutput() function.
#  3. Try out the other tabPanel() layouts - alternatives to 
#   tabsetPanel() are navlistPanel() and navbarPage()

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
      tabsetPanel(
      #navlistPanel(
      #navbarPage(title = "plots",
        tabPanel(
          title = "x squared", 
          plotOutput("x_squared", width = 400, height = 400)
        ),
        tabPanel(
          title = "x cubed", 
          plotOutput("x_cubed", width = 400, height = 400)
        )
      )
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
