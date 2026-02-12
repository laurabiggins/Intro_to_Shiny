library(shiny)
library(dplyr)
library(ggplot2)

options(shiny.reactlog = TRUE)
all_diets <- unique(ChickWeight$Diet)

ui <- fluidPage(

    # Application title
    titlePanel("Chick weights"),

    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput(
                inputId = "selected_diets",
                label   = "include diet",
                choices = all_diets,
                selected = all_diets),
            textInput("text_input", label = "Enter text")
        ),

        mainPanel(
            tableOutput("chick_table")
        )
    )
)

server <- function(input, output) {

    output$chick_table <- renderTable({

      ChickWeight %>%
        filter(Diet %in% diets_re()) %>% 
        count(Diet)
      
    })
   
    diets_re <- reactive({
      
      print(paste0("reactive, diets = ", 
                   paste0(input$selected_diets, collapse = ",")))
      
      input$selected_diets 
      
    })
    
    observeEvent(input$selected_diets, {

      print(paste0("I've observed an event - the selections have changed"))
      print(paste0("text is: ", input$text_input))

    })
    
    # observe({
    # 
    #   print(paste0("observe, diets = ", paste0(input$selected_diets, collapse = ",")))
    #   print(paste0("text is: ", input$text_input))
    # 
    # })
}

# Run the application 
shinyApp(ui = ui, server = server)
