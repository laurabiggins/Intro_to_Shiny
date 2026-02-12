library(shiny)
library(tidyverse)
library(DT)

# Exercise
# 
# 1. Add select inputs so any of the conditions (naive or primed) can be plotted on the x or y axes.
# 2. Use a sidebar layout to separate the inputs from the plot
# 3. a. Add a slider to allow the user to select the range of PepCounts. 
#    b. Use a reactive expresion to create a dataset filtered by the pepcount range. 
#       This should be used in the table and the plot.
# 
# [Optional]      
# 4. Change the tableOutput to a dataTableOutput. Remember to change the corresponding render function too. 
# 5. Highlight selected genes on the plot (use input$[data_table_name]_rows_selected to get the selected row numbers)
# 6. Add an actionButton to clear the selected rows (you can use the function dataTableProxy())
# 7. Use a tabset layout to add another plot that shows each of the values for a selected
# gene. e.g. a jitter plot coloured by naive vs primed.
# 
load("data/wide_data.rda")

long_data <- wide_data %>%
  pivot_longer(cols = c(starts_with("NAIVE"), starts_with("PRIMED")), 
               names_to = "sample", 
               values_to = "expression") %>%
  separate(sample, into = c("type", "rep")) 

conditions <- wide_data %>%
  select(starts_with("NAIVE"), starts_with("PRIMED")) %>%
  colnames()

pep_counts <- pull(wide_data, PepCount)



ui <- fluidPage(
  
  titlePanel("Exercise"),

  #actionButton("browser","browser"),

  tabsetPanel(
    tabPanel("all_data", 
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
                             value = range(pep_counts)),
                 actionButton("clear_selections", "Clear selected rows")
               ),
               mainPanel(
                 plotOutput(outputId = "scatter", height = 400, width = 400), 
                 dataTableOutput(outputId = "data_table")
               )
             )
    ),
    tabPanel("selected_data",
             plotOutput("jitter")
    )
  )
)


server <- function(input, output, session) {

  filtered_pep_data <- reactive({
    
    wide_data %>%
      filter(PepCount <= input$pep_count_slider[2] & PepCount >= input$pep_count_slider[1])
    
  })
  
  
  selected_data <- reactive({
    
    if(is.null(input$data_table_rows_selected)) return(NULL)
    
    slice(filtered_pep_data(), input$data_table_rows_selected)
    
  })
  
  selected_genes <- reactive({
    
    pull(selected_data(), gene_name)
    
  })
  
  plain_scatter_plot <- reactive({
    
    filtered_pep_data() %>%
      ggplot(aes(x = .data[[input$condition1]], y = .data[[input$condition2]])) +
      geom_point()
    
  })
  
  scatter_plot_object <- reactive({

     if(is.null(input$data_table_rows_selected)) return(plain_scatter_plot())
     
     plain_scatter_plot() + 
       geom_point(data = selected_data(), colour = "red")

  })

  jitter_plot_object <- reactive({
    
    set.seed(1)
    
    long_data %>%
      filter(gene_name %in% selected_genes()) %>%
        ggplot(aes(x = gene_name, y = expression, colour = type)) +
        geom_jitter(height = 0, width = 0.1)
    
  })
  
  output$jitter <- renderPlot({
    
    req(input$data_table_rows_selected)
    
    jitter_plot_object()
    
  })
  
  output$scatter <- renderPlot({
    
    scatter_plot_object()
    
  })
  
  output$data_table <- renderDataTable({

    filtered_pep_data() %>%
      datatable() %>%
      formatRound(columns = 3:ncol(filtered_pep_data()), digits = 3)

  })
  
  myProxy <- dataTableProxy("data_table")
  
  observeEvent(input$clear_selections, {
    
    selectRows(myProxy, selected = NULL)
    
  })
  
  #observeEvent(input$browser, browser())
  
}

shinyApp(ui, server)
