library(shiny)

ui <- fluidPage(

  titlePanel("Reactive Values"),

  sidebarLayout(
    sidebarPanel(
      verticalLayout(
        actionButton(
          "lwd_increase", 
          "increase line width"
        ),
        br(),
        actionButton(
          "lwd_decrease", 
          "decrease line width"
        ),
        br(),
        actionButton(
          "plot_x_squared", 
          "plot x squared"
        ),
        br(),
        actionButton(
          "plot_x_cubed", 
          "plot x cubed"
        )
      )
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

  rv <- reactiveValues(
    line_width = 3,
    y_values   = x_values
  )
  observeEvent(input$lwd_increase, {
      rv$line_width <- rv$line_width*1.5
  })    
  observeEvent(input$lwd_decrease, {
    rv$line_width <- rv$line_width/1.5
  })
  observeEvent(input$plot_x_squared, {
    rv$y_values <- x_values^2
  })
  observeEvent(input$plot_x_cubed, {
    rv$y_values <- x_values^3
  })
  output$x_plot <- renderPlot({
    plot(x_values, 
         rv$y_values, 
         type = "l", 
         lwd = rv$line_width)
  })    
}

# Run the application 
shinyApp(ui = ui, server = server)


















