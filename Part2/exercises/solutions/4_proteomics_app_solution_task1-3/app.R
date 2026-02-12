library(shiny)
library(tidyverse)
library(DT)

# Exercise
# 
# 1. Add select inputs so any of the conditions (naive or primed) can be plotted on the x or y axes.
# 2. Use a sidebar layout to separate the inputs from the plot
# 3. a. Add a slider to allow the user to select the range of PepCounts. 
#    b. Use a reactive expresion to create a dataset filtered by the pepcount range. 
# This should be used in the table and the plot.

load("data/wide_data.rda")

conditions <- wide_data %>%
  select(starts_with("NAIVE"), starts_with("PRIMED")) %>%
  colnames()

pep_counts <- pull(wide_data, PepCount)



ui <- fluidPage(
  
  titlePanel("Exercise"),

  sidebarLayout(
   
    sidebarPanel(
     
      selectInput(inputId = "condition1", 
                 label = "select condition for x axis",
                 choices = conditions,
                 selected = conditions[1]),
      selectInput(inputId = "condition2", 
                 label = "select condition for y axis",
                 choices = conditions,
                 selected = conditions[4]),
      sliderInput(inputId = "pep_count_slider",
                 label = "pep count range",
                 min = min(pep_counts),
                 max = max(pep_counts),
                 value = range(pep_counts))
      ),
    mainPanel(
      plotOutput(outputId = "scatter", height = 400, width = 400)
    )
  ),
  dataTableOutput(outputId = "data_table")
)


server <- function(input, output, session) {
  
  filtered_pep_data <- reactive({
    
    wide_data %>%
      filter(PepCount <= input$pep_count_slider[2] & PepCount >= input$pep_count_slider[1])
    
  })
  
  scatter_plot_object <- reactive({

    filtered_pep_data() %>%
      ggplot(aes(x = .data[[input$condition1]], y = .data[[input$condition2]])) +
      geom_point()

  })

  output$scatter <- renderPlot({
    
    scatter_plot_object()
    
  })
  
  output$data_table <- renderTable({

    filtered_pep_data() 

  })

}

shinyApp(ui, server)
