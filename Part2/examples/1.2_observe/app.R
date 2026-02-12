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
      actionButton("update", "update"),
      width = 3
    ),
    mainPanel(
      plotOutput("chick_weights"), 
      width = 9
    )
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
  
  output$chick_weights <- renderPlot({
    
    data_subset() %>%
      ggplot(aes(x = Time, 
                 y = weight, 
                 colour = Diet, 
                 group = interaction(Diet, Chick)))+
      geom_line(lwd = 2)
  })
}

















# Run the application 
shinyApp(ui = ui, server = server)

