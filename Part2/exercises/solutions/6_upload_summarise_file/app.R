library(shiny)
library(tidyverse)
library(pastecs)
library(tools)

options(shiny.maxRequestSize = 10 * 1024^2) # allow file up to 10MB to be uploaded

ui <- fluidPage(

    titlePanel("Upload file and summarise data"),
    
    br(),
    
    sidebarLayout(
        sidebarPanel(
            fileInput(inputId = "file", 
                      label   = "select file",
                      accept  = ".csv"),
            selectInput(inputId = "selected_var", 
                        label   = "select variable",
                        choices = NULL)
        ),
        mainPanel(
           DT::dataTableOutput("summary")
        )
    )
)

server <- function(input, output, session) {

    dataset <- eventReactive(input$file, {
        req(input$file)
        ext <- tools::file_ext(input$file$name)
        validate(need(ext == "csv", "Please upload a csv file"))
        read_csv(input$file$datapath)
    })
    
    observeEvent(dataset(), {
        numeric_columns <- select_if(dataset(), is.numeric)
        updateSelectInput(session, 
                          inputId = "selected_var", 
                          choices = colnames(numeric_columns))
    })
    
    summary_data <- reactive({
        req(input$selected_var)
        selected_data <- select(dataset(), input$selected_var) 
        summary_stats <- stat.desc(selected_data)
        round(summary_stats, digits = 3)
    }) 
    
    output$summary <- DT::renderDataTable(summary_data(), rownames = TRUE) 

}

shinyApp(ui = ui, server = server)
