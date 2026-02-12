library(shiny)
library(dplyr)
library(ggplot2)

options(shiny.reactlog = TRUE)
all_diets <- unique(ChickWeight$Diet)

ui <- fluidPage(
  
  titlePanel("Chick weights"),
  
  splitLayout(
     checkboxGroupInput(
       inputId = "selected_diets",
       label   = "diet",
       choices = all_diets,
       selected = all_diets
     ),
    plotOutput("chick_weights", 
               width="350px", 
               height="233px"),
    cellWidths = c("10%", "55%", "35%")
  )
)

server <- function(input, output) {
  
  data_subset <- reactive({
    
    #print("evaluating data_subset reactive expression")
    ChickWeight %>%
      filter(Diet %in% input$selected_diets)
  })
  
  output$chick_weights <- renderPlot({
    
    #print("running renderPlot code")
    ChickWeight %>%
      filter(Diet %in% input$selected_diets) %>% 
      ggplot(aes(x = Time, 
                 y = weight, 
                 colour = Diet, 
                 group = interaction(Diet, Chick)))+
      geom_line(lwd = 2)
  })
}

















# Run the application 
shinyApp(ui = ui, server = server)

