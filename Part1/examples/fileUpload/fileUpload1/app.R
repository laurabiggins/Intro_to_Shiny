# To show the return value of fileInput() is a data frame

library(shiny)

ui <- fluidPage(
  titlePanel("Uploading files"),
  fileInput(inputId = "upload", 
            label = "Upload...",),
  tableOutput("files")
)

server <- function(input, output, session) {
  output$files <- renderTable(input$upload)
}

shinyApp(ui = ui, server = server)

