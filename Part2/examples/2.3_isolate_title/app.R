library(shiny)

ui <- fluidPage(
    
    titlePanel("isolate with actionButton"),
    
    plotOutput("distPlot", width = 600, height = 400),
    sliderInput(inputId = "bins",
                label = "Number of bins:",
                min = 1, max = 50, value = 30),
    textInput(inputId = "title_text",
              label = "Enter title for plot"),
    textOutput(outputId = "message"),
    actionButton(inputId = "update_title_button",
                 label = "Update title")
)

server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        
        input$update_title_button
        
        plotting_data <- faithful[, 2]
        
        bins <- seq(min(plotting_data), 
                    max(plotting_data), 
                    length.out = input$bins + 1)
        
        hist(plotting_data, 
             breaks = bins, 
             main   = isolate(input$title_text), 
             col = 'darkgray', border = 'white')
    })
    
    output$message <- renderText({
        paste0("Value of action button = ", input$update_title_button)
    })

}














# Run the application 
shinyApp(ui = ui, server = server)
