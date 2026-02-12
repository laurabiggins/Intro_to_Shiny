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
            plotOutput("chick_weights")
        )
    )
)

server <- function(input, output) {

    output$chick_weights <- renderPlot({

      ChickWeight %>%
        filter(Diet %in% input$selected_diets) %>% 
          ggplot(aes(x = Time, 
                     y = weight, 
                     colour = Diet, 
                     group = interaction(Diet, Chick)))+
          geom_line()
    })
    

    # observe doesn't return values
    # not callable
    # eager
    observe({
      
      print(paste0("observe, diets = ", paste0(input$selected_diets, collapse = ",")))
      #diets_re()
      
    })
    
    diets_re <- reactive({
      
      print(paste0("reactive, diets = ", paste0(input$selected_diets, collapse = ",")))
      
      #input$selected_diets 
      
    })
    
    observeEvent(input$browser, browser())
    
}

# Run the application 
shinyApp(ui = ui, server = server)




#filter(Diet %in% diets_re()) %>% 
