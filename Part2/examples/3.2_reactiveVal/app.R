library(shiny)

ui <- fluidPage(

  titlePanel("Reactive Val"),

  sidebarLayout(
    sidebarPanel(
      verticalLayout(
        actionButton(
          inputId = "lwd_increase",
          label   = "increase line width"
        ),
        br(),
        actionButton(
          inputId = "lwd_decrease",
          label   = "decrease line width"
        ),
        br(),
        actionButton(
          inputId = "plot_x_squared",
          label   = "plot x squared"
        ),
        br(),
        actionButton(
          inputId = "plot_x_cubed",
          label   = "plot x cubed"
        )
      ), width = 3
    ),
    mainPanel(
      plotOutput(
        "x_plot",
        width = 400, 
        height = 400
      )
    )
  )    
)


x_values <- -20:20

server <- function(input, output) {

  line_width <- reactiveVal(3)
  y_values <- reactiveVal(x_values)
      
  observeEvent(input$lwd_increase, {
    line_width(line_width()*1.5)
  })    
  observeEvent(input$lwd_decrease, {
    line_width(line_width()/1.5)
  })
  observeEvent(input$plot_x_squared, {
    y_values(x_values^2)
  })
  observeEvent(input$plot_x_cubed, {
    y_values(x_values^3)
  })
  output$x_plot <- renderPlot({
    plot(x_values, 
         y_values(), 
         type = "l", 
         lwd = line_width())
  })    
}

# Run the application 
shinyApp(ui = ui, server = server)






















