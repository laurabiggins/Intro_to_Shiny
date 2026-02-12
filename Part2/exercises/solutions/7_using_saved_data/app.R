library(shiny)
library(tidyverse)
library(pastecs)

# Files have been imported and saved, and there is a drop down 
# list to choose from 
# the summary data only shows up when the button is clicked

load("RData/all_data.RData")
dataset_names <- names(all_data)

ui <- fluidPage(

    titlePanel("Pre-processing datasets"),
    
    br(),
    
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "selected_file", 
                      label     = "select dataset",
                      choices   = dataset_names),
            selectInput(inputId = "selected_var", 
                        label   = "select variable",
                        choices = NULL),
            actionButton("summarise", "show summary data")
            #actionButton("browser", "browser")
        ),

        mainPanel(
           tableOutput("summary")
        )
    )
)

server <- function(input, output, session) {

    output$summary <- renderTable(summary_data(), rownames = TRUE)
     
    dataset <- reactive(all_data[[input$selected_file]])
    
    observeEvent(dataset(), {
        
        numeric_columns <- select_if(dataset(), is.numeric)
        updateSelectInput(session, 
                          inputId = "selected_var", 
                          choices = colnames(numeric_columns))
    })
    
    summary_data <- eventReactive(input$summarise, {
        req(input$selected_var)
        selected_data <- select(dataset(), input$selected_var) 
        summary_stats <- stat.desc(selected_data)
        round(summary_stats, digits = 3)
    }) 
    
    #observeEvent(input$browser, browser())
}

shinyApp(ui = ui, server = server)
