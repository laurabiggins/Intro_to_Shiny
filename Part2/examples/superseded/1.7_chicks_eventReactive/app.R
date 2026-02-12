library(shiny)
library(dplyr)
library(ggplot2)

options(shiny.reactlog = TRUE)
all_diets <- unique(ChickWeight$Diet)

ui <- fluidPage(

    # Application title
    titlePanel("Chick weights"),

    sidebarLayout(
        sidebarPanel(width = 2,
            checkboxGroupInput(
                inputId = "selected_diets",
                label   = "include diet",
                choices = all_diets,
                selected = all_diets
            ),
            br(),
            actionButton("update", "update")
        ),

        mainPanel(
            plotOutput("chick_weights"),
            tableOutput("chick_data")
        )
    )
)

server <- function(input, output) {
  

    data_subset <- eventReactive(input$update, 
                                 ignoreNULL = FALSE, {
      
      filter(ChickWeight, Diet %in% input$selected_diets)
      
    })
    
    output$chick_weights <- renderPlot({

      data_subset() %>% 
          ggplot(aes(x = Time, 
                     y = weight, 
                     colour = Diet, 
                     group = interaction(Diet, Chick)))+
          geom_line()
    })
    
    output$chick_data <- renderTable({
        
      head(data_subset())
      
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
