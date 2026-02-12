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
      width = 3
    ),
    mainPanel(
      plotOutput("chick_weights"), 
      width = 9
    )
  )
)

server <- function(input, output) {
  
  data_subset <- reactive({
    
    print("running data_subset reactive code")
    ChickWeight %>%
      filter(Diet %in% input$selected_diets)
  })
  
  output$chick_weights <- renderPlot({
    
    print("running renderPlot code")
    
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

