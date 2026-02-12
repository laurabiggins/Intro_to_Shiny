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
            actionButton("browser", "browser")
        ),

        mainPanel(
            plotOutput("chick_weights"),
            tableOutput("chick_data")
        )
    )
)

server <- function(input, output) {

  
    rv <- reactiveValues(

       data_subset = ChickWeight,
       diets = all_diets
    )
  
    # data_subset <- reactive({
    #   
    #   ChickWeight %>%
    #     filter(Diet %in% diets_re())
    #   
    # })
    # 
    # diets_re <- reactive({
    #   
    #   input$selected_diets
    #   
    # })

    
    observeEvent(input$selected_diets, {
      
      rv$diets <- input$selected_diets
      
      rv$data_subset <- ChickWeight %>%
                          filter(Diet %in% input$selected_diets)
      
    })

            
    output$chick_weights <- renderPlot({

      rv$data_subset %>% 
          ggplot(aes(x = Time, 
                     y = weight, 
                     colour = Diet, 
                     group = interaction(Diet, Chick)))+
          geom_line()
    })
    
    output$chick_data <- renderTable({
        
      head(rv$data_subset)
      
    })

    observeEvent(input$browser, browser())
    
}

# Run the application 
shinyApp(ui = ui, server = server)
