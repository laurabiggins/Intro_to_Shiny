library(shiny)
library(dplyr)
library(ggplot2)

options(shiny.reactlog = TRUE)
all_diets <- unique(ChickWeight$Diet)

ui <- fluidPage(
  
  titlePanel("Chick weights"),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
         inputId  = "selected_diets",
         label    = "diet",
         choices  = all_diets,
         selected = all_diets
       ),
      actionButton("update", "update")
    ),
    mainPanel(tableOutput("chick_weights"))
  )
)

server <- function(input, output) {
  
  observe({
    print("--------------------------------")
    print(paste0("button count = ", input$update))
    print(paste0(length(input$selected_diets),
                 " diets are currently selected"))
  })
  
  data_subset <- reactive({
    
    ChickWeight %>%
      filter(Diet %in% input$selected_diets)
  })
  
  output$chick_weights <- renderTable({
    
    head(data_subset())
  })
}

















# Run the application 
shinyApp(ui = ui, server = server)

