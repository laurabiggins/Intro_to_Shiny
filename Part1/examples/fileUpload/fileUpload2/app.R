library(shiny)
library(readr)

options(shiny.maxRequestSize = 10 * 1024^2) 

ui <- fluidPage(
  titlePanel("Uploading files"),
  fileInput(inputId = "upload", 
            label = "Upload...",),
  tableOutput("files")
)

server <- function(input, output) {
  
  output$files <- renderTable({
    req(input$upload)
    dataset <- read_csv(input$upload$datapath)
    head(dataset)
  })
}

shinyApp(ui = ui, server = server)
