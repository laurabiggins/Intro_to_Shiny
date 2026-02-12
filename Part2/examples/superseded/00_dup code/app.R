library(shiny)
library(tidyverse)

ui <- fluidPage(

    # Application title
    titlePanel("Iris Data"),

    # Sidebar with a select input 
    sidebarLayout(
        sidebarPanel(
            
            selectInput(inputId = "iris_species",
                        label   = "Select species",
                        choices = unique(iris$Species))
        ),

        mainPanel(
           tabsetPanel(
               tabPanel("text", 
                        br(),
                        textOutput(outputId = "text")), 
            
               tabPanel("verbatim", 
                        br(), 
                        verbatimTextOutput(outputId = "data_printed")),
                    
               tabPanel("table", 
                        br(), 
                        tableOutput(outputId = "iris_data")),
               
               tabPanel("DT",
                        br(), 
                        DT::dataTableOutput(outputId = "iris_dataTable")),
                                   
               tabPanel("plot", 
                     plotOutput(outputId = "iris_plot", height = "500", width = "500")),
               
               tabPanel("image", 
                        br(),
                        imageOutput(outputId = "iris_image", height = "200", width = "200"))
           )
        )
    )
)


server <- function(input, output) {

    
    #iris_filt <- filter(iris, Species == input$iris_species)
    
    
    output$text <- renderText(paste0("Selected species is ", input$iris_species))
    
    output$data_printed <- renderPrint({
        
        iris %>%
            filter(Species == input$iris_species) %>%
            head()
    })

    output$iris_data <- renderTable({
        
        iris %>%
            filter(Species == input$iris_species) %>%
            head()
    })
    
    output$iris_dataTable <- DT::renderDataTable({
        
        iris %>%
            filter(Species == input$iris_species)
    })
        
    output$iris_plot <- renderPlot({
        
        iris_filtered <- iris %>%
            filter(Species == input$iris_species) %>%
            select(-Species)
        
        boxplot(iris_filtered)
    })
    
    output$iris_image <- renderImage({
        filename <- normalizePath(file.path(paste0("iris_", input$iris_species, ".png")))
        
        list(src = filename)
    }, deleteFile = FALSE) 
}

# Run the application 
shinyApp(ui = ui, server = server)
