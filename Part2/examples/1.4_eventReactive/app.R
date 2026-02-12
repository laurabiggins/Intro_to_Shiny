library(shiny)
library(dplyr)
library(ggplot2)

options(shiny.reactlog = TRUE)
all_diets <- unique(ChickWeight$Diet)

ui <- fluidPage(
  
  titlePanel("Chick weights"),
  
  splitLayout(
    wellPanel(
      checkboxGroupInput(
         inputId  = "selected_diets",
         label    = "diet",
         choices  = all_diets,
         selected = all_diets
       ),
      actionButton("update", "update")
    ),
    plotOutput("chick_weights", 
               width  = "350px", 
               height = "233px"),
    cellWidths = c("25%", "75%")
  )
)

server <- function(input, output) {
  
  data_subset <- eventReactive(input$update, {

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

