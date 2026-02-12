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
            )
        ),

        mainPanel(
            plotOutput("chick_weights"),
            tableOutput("chick_data")
        )
    )
)

server <- function(input, output) {
    
    observe({
      
      print(paste0("observe, diets = ", paste0(input$selected_diets, collapse = ",")))
      print(paste0("observe, diets from diets_re() = ", paste0(diets_re(), collapse = ",")))
      
    })
    
    diets_re <- reactive({

      input$selected_diets
      
    })
    
    data_subset <- reactive({
      
      ChickWeight %>%
        filter(Diet %in% diets_re())
      
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
