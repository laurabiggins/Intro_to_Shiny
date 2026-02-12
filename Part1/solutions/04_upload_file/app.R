library(shiny)
library(tidyverse)

options(shiny.maxRequestSize = 10 * 1024^2) # allow file up to 10MB to be uploaded

ui <- fluidPage(

  titlePanel("Uploading a file"),

  sidebarLayout(
    sidebarPanel(
      fileInput(
        inputId = "file", 
        label   = "select file",
        accept  = ".csv"
      ),
      numericInput(
        inputId = "rows",
        label   = "select number of rows to display",
        value   = 5
      )
    ),
    mainPanel(
       tableOutput("data_table")
    )
  )
)

server <- function(input, output, session) {

  output$data_table <- renderTable({
    
    req(input$file)
    ext <- tools::file_ext(input$file$name)
    validate(need(ext == "csv", "Please upload a csv file"))
    dataset <- read_csv(input$file$datapath)
    
    head(dataset, n = input$rows)
  })
}

shinyApp(ui = ui, server = server)
