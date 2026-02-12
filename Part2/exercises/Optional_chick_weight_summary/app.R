library(shiny)
library(tidyverse)

# Task
# add an option to summarise the lines on the plot to show the mean or median 
# for each diet


all_diets <- unique(ChickWeight$Diet)

ui <- fluidPage(

    titlePanel("Chick weights"),

    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput(
                inputId = "selected_diets",
                label = "include diet",
                choices = all_diets,
                selected = all_diets,
                inline = TRUE
            )
        ),
        mainPanel(
           plotOutput("chick_weights")
        )
    )
)

server <- function(input, output) {

  
    data_subset <- reactive({
      
      filter(ChickWeight, Diet %in% input$selected_diets)
    })
    

        
    plotting_object <- reactive({
        
        data_subset() %>%
          ggplot(aes(x = Time, y = weight, colour = Diet, group = interaction(Diet, Chick)))+
          geom_line()

    })
    
    
    output$chick_weights <- renderPlot({
      
      plotting_object()
      
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
