library(shiny)
library(tidyverse)
library(palmerpenguins)

#options(shiny.reactlog = TRUE)

all_islands <- unique(penguins$island)

ui <- fluidPage(
  
  titlePanel("Penguins"),
  
  sidebarLayout(
    sidebarPanel(width = 2,
                 checkboxGroupInput(
                   inputId = "islands",
                   label   = "include island",
                   choices = all_islands
                 ),
                 actionButton("browser", "browser")
    
    ),
    mainPanel(
      plotOutput(outputId = "penguin_plot")
    )
  )
)

server <- function(input, output) {
  
  data_subset <- reactive({
    
    print(paste0("data_subset updated"))
    
    penguins %>%
      filter(island %in% input$islands)
  })
  
  output$penguin_plot <- renderPlot({
    
    data_subset() %>%
      ggplot(aes(x = species, y = bill_length_mm, color = species)) +
      geom_boxplot()
  })
  observeEvent(input$browser, browser())
}

shinyApp(ui, server)