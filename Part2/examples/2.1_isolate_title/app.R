library(shiny)

ui <- fluidPage(

    titlePanel("No isolate"),
    plotOutput("distPlot", width = 600, height = 400),
    sliderInput(inputId = "bins",
                label = "Number of bins:",
                min = 1, max = 50, value = 30),
    textInput(inputId = "title_text",
              label = "Enter title for plot")
)

server <- function(input, output) {

    output$distPlot <- renderPlot({
        
        plotting_data <- faithful[, 2]
        
        bins <- seq(min(plotting_data), 
                    max(plotting_data), 
                    length.out = input$bins + 1)
        
        hist(plotting_data, 
             breaks = bins, 
             main   = input$title_text, 
             col = 'darkgray', border = 'white')
    })
}











# Run the application 
shinyApp(ui = ui, server = server)
