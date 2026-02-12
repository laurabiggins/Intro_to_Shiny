library(shiny)
library(tidyverse)
library(DT)
library(bslib)

ui <- page_sidebar(

  title = "Star wars app",
  
  sidebar = sidebar(
   # sidebarPanel(
      radioButtons(
        inputId = "colour_option", 
        label = "Colour by...", 
        choices = c(
          "homeworld", 
          "species", 
          "eye colour" = "eye_color"
       # )
      ),
      br(),
      p("Select rows from the data table, 
       then click 'Update plot' to change 
       the characters that are plotted"),
      actionButton("update", "Update plot"),
      width = 2
    ),
   # mainPanel(
        #actionButton("browser", "browser"),
        plotOutput("bar_plot", height = 300),
        dataTableOutput("starwars_table"),
        br(),
        actionButton("clear_selections", 
                     "Clear selected rows"),
   #     width = 10
  #  )
  )
)

server <- function(input, output) {

    
    rv <- reactiveValues(
        
        plotting_subset = slice(starwars, 10:15)
    )
    

    output$bar_plot <- renderPlot({

      rv$plotting_subset %>%
        ggplot(aes(x = name, 
                   y = height, 
                   fill = .data[[input$colour_option]])) +
        geom_col() +
        coord_flip()
        
    })
    
    output$starwars_table <- renderDataTable({
        
      data <- starwars %>%
          select(-films, -vehicles, 
                 -starships, -birth_year, -hair_color)
        
       DT::datatable(data, rownames = FALSE,  
                      options = list(
                        dom = "tl", 
                        columnDefs = list(
                          list(
                           targets = 0,
                           width = "800px"
                        )
                       )
                      )
                     ) %>%
                     DT::formatStyle(0, target = 'row', 
                                     lineHeight = "70%", 
                                     fontSize = "90%") 
        
    })
    
    observeEvent(input$update, {
        
        req(input$starwars_table_rows_selected)
        
        rv$plotting_subset <- starwars %>%
            slice(input$starwars_table_rows_selected)
        
    })
    
    myProxy <- dataTableProxy("starwars_table")
    
    observeEvent(input$clear_selections, {
        
        selectRows(myProxy, selected = NULL)
        
    })
    
    observeEvent(input$browser, browser())
    
}

# Run the application 
shinyApp(ui = ui, server = server)
