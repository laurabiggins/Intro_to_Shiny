library(shiny)
library(tidyverse)

ui <- fluidPage(

    # Application title
    titlePanel("Iris Data"),

    tags$head(
        tags$style(HTML("
                    h3 {
                        color: black;
                        margin: 10px;
                        font-size: 28px;
                    }
                    .UI_block1 {
                        color: blue;
                        background-color: #a7b6d1; 
                        border: 3px solid #6e717a; 
                        text-align: center;
                        font-family: 'Lucida Console', Courier, monospace;
                        padding: 10px;
                        margin: 10px;
                    }
                    .server_block1 {
                        color: blue;
                        background-color: #cdced1; 
                        border: 3px solid #6e717a; 
                        text-align: center;
                        font-family: 'Lucida Console', Courier, monospace;
                        padding: 10px;
                        margin: 10px;
                    }
                    .UI_block2 {
                        background-color: #a7b6d1; 
                        border: 3px solid #6e717a;
                        font-family: 'Lucida Console', Courier, monospace;
                        margin: 10px;
                    }
                    .server_block2 {
                        background-color: #cdced1; 
                        border: 3px solid #6e717a; 
                        font-family: 'Lucida Console', Courier, monospace;
                        margin: 10px;
                    }
                   ")
        )
                   
    ),
    
    # Sidebar with a select input 
    sidebarLayout(
        
        sidebarPanel(width = 3,
            
            # selectInput(inputId = "iris_species",
            #             label   = "Select species",
            #             choices = unique(iris$Species))
            radioButtons(inputId = "iris_species",
                        label   = "Select species",
                        choices = unique(iris$Species)),
            br(),
            checkboxInput("show_code", "show code")
            
        ),

        mainPanel(
           tabsetPanel(
               tabPanel("text", 
                        br(),
                        br(),
                        br(),
                        textOutput(outputId = "text"),
                        br(),
                        hr(style = "border: 3px double #58595c;"),
                        
                        conditionalPanel(condition = "input.show_code == 1",
                            fluidRow(
                                column(6,
                                       wellPanel(class = "UI_block1",
                                                h3("UI"),
                                                h4("textOutput()")
                                       )
                                ),
                                column(6,
                                       wellPanel(class = "server_block1",
                                                h3("server"),
                                                h4("renderText()")
                                       )
                                )
                            ),
                            br(),
                            br(),
                            verticalLayout(
                                wellPanel(
                                    wellPanel(class = "UI_block2",
                                              p('textOutput(outputId = "text")')
                                    ),
                                    wellPanel(class = "server_block2",
                                              p('output$text <- renderText(paste0("Selected species is ", input$iris_species))')
                                    )
                                )
                            )
                        )
                ), 
               tabPanel("verbatim", 
                        br(), 
                        verbatimTextOutput(outputId = "data_printed"),
                        br(),
                        hr(style = "border: 3px double #58595c;"),
                        conditionalPanel(condition = "input.show_code == 1",
                            fluidRow(
                                column(6,
                                       wellPanel(class = "UI_block1",
                                                 h3("UI"),
                                                 h4("verbatimTextOutput()")
                                       )
                                ),
                                column(6,
                                       wellPanel(class = "server_block1",
                                                 h3("server"),
                                                 h4("renderPrint()")
                                       )
                                )
                            )
                        )    
                ),
               tabPanel("table", 
                        br(), 
                        tableOutput(outputId = "iris_data"),
                        br(),
                        hr(style = "border: 3px double #58595c;"),
                        conditionalPanel(condition = "input.show_code == 1",
                            fluidRow(
                                column(6,
                                       wellPanel(class = "UI_block1",
                                                 h3("UI"),
                                                 h4("tableOutput()")
                                       )
                                ),
                                column(6,
                                       wellPanel(class = "server_block1",
                                                 h3("server"),
                                                 h4("renderTable()")
                                       )
                                )
                            ) 
                        )    
                        
                ),
               
               tabPanel("DT",
                        br(), 
                        DT::dataTableOutput(outputId = "iris_dataTable"),
                        br(),
                        hr(style = "border: 3px double #58595c;"),
                        conditionalPanel(condition = "input.show_code == 1",
                            fluidRow(
                                column(6,
                                       wellPanel(class = "UI_block1",
                                                 h3("UI"),
                                                 h4("DT::dataTableOutput()")
                                       )
                                ),
                                column(6,
                                       wellPanel(class = "server_block1",
                                                 h3("server"),
                                                 h4("DT::renderDataTable()")
                                       )
                                )
                            )        
                        ) 
                ),
                                   
               tabPanel("plot", 
                     plotOutput(outputId = "iris_plot", height = "450", width = "450"),

                     hr(style = "border: 3px double #58595c;"),
                     conditionalPanel(condition = "input.show_code == 1",     
                        fluidRow(
                             column(6,
                                    wellPanel(class = "UI_block1",
                                              h3("UI"),
                                              h4("plotOutput()")
                                    )
                             ),
                             column(6,
                                    wellPanel(class = "server_block1",
                                              h3("server"),
                                              h4("renderPlot()")
                                    )
                             )
                         ) 
                     )    
                ),
               tabPanel("image", 
                        br(),
                        imageOutput(outputId = "iris_image", height = "200", width = "200"),
                        br(),
                        hr(style = "border: 3px double #58595c;"),
                        conditionalPanel(condition = "input.show_code == 1",
                            fluidRow(
                                column(6,
                                       wellPanel(class = "UI_block1",
                                                 h3("UI"),
                                                 h4("imageOutput()")
                                       )
                                ),
                                column(6,
                                       wellPanel(class = "server_block1",
                                                 h3("server"),
                                                 h4("renderImage()"))
                                )
                            ) 
                        )
               )    
           ),
           br(), br(), br(),
          # img(src = "render_cheatsheet.png")
        )
    )
)


server <- function(input, output) {


    output$text <- renderText(paste0("Selected species is ", input$iris_species))
    
    output$data_printed <- renderPrint(head(filter(iris, Species == input$iris_species)))

    output$iris_data <- renderTable(head(filter(iris, Species == input$iris_species)))
    
    output$iris_dataTable <- DT::renderDataTable(filter(iris, Species == input$iris_species))
        
    output$iris_plot <- renderPlot({
        
        iris_filtered <- iris %>%
            filter(Species == input$iris_species) %>%
            select(-Species)
        
        boxplot(iris_filtered)
    })
    
    output$iris_image <- renderImage({

        filename <- paste0("images/iris_", input$iris_species, ".PNG") # seems windows doesn't mind about the case of png vs PNG, but the shiny-server does
        
        list(src = filename)
    }, deleteFile = FALSE) 
}

# Run the application 
shinyApp(ui = ui, server = server)
