library(shiny)
library(tidyverse)

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
            ),
            br(),
            wellPanel(
              checkboxInput(
                  inputId = "summarise",
                  label = "summarise plot"
              ),
              radioButtons(
                inputId = "summary_option",
                label = NULL,
                choices = c("mean", "median"),
                selected = "mean",
                inline = TRUE
              )
            ),
            br(),
            actionButton("browser", "browser")
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
    

    data_summary <- reactive({
      
      grouped <- data_subset() %>%    
        group_by(Diet, Time)
      
      switch(input$summary_option,
             mean = summarise(grouped, weight = mean(weight)),
             median = summarise(grouped, weight = median(weight))
             )
    })

        
    plotting_object <- reactive({
      
      if(input$summarise){
        
        data_summary() %>%
          ggplot(aes(x = Time, y = weight, colour = Diet))+
          geom_line()
        
      } else { 
        
        data_subset() %>%
          ggplot(aes(x = Time, y = weight, colour = Diet, group = interaction(Diet, Chick)))+
          geom_line()
      } 
    })
    
    
    output$chick_weights <- renderPlot({
      
      plotting_object()
      
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
