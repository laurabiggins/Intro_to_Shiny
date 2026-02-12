library(shiny)
library(magrittr)
library(ggplot2)

ui <- fluidPage(
  br(),
  h1("Layouts", style = "text-align: center; font-size: 400%;"),
  br(),
  h4("The 'objects' referred to within the layouts could be single elements such as a plot, table, image or piece of text, or a panel containing multiple elements. Panels can be nested within panels."),
  br(),
  #navlistPanel(widths = c(2,10),
  tabsetPanel(             
    tabPanel("sidebarLayout()",
      wellPanel(style = "background-color: #bad1d0;",
        h1("sidebarLayout()"),
        h4("Contains a sidebarPanel and a mainPanel")
      ),  
      br(),
      wellPanel(
        sidebarLayout(
          sidebarPanel(width = 3,
            h3("sidebarPanel()"),
            p("The sidebar panel generally contains input fields"),
            textInput("", "", placeholder = "Enter text here"),
            br(),
            fileInput("", label = "Choose file")
          ),
          mainPanel(width = 9,
            h3("mainPanel()"),
            h4("This is a classic simple layout that is often used to keep user input components in the sidebar separate from
               the outputs in the mainPanel, though there are no restrictions on the placement of elements. Inputs can be located in the main panel and outputs in the sidebar, or some in one, and some in the other."),
            h4("Single elements can be added one by one in the main panel or they could be nested inside other 
               panels"),
            h4("The width of the sidebar can be adjusted by setting the width argument, by default it is 4."),
            h4("The widths of the sidebarPanel and mainPanel should add up to 12, as in the fluidRow examples in the next tab.")
          )
        )
      ),  
      br(),
      tags$pre(
        'sidebarLayout(
          sidebarPanel(width = 3,
            h3("sidebarPanel()"),
            p("The sidebar panel generally contains input fields"),
            textInput("", "", placeholder = "Enter text here"),
            br(),
            fileInput("", label = "Choose file")
          ),
          mainPanel(width = 9,
            h3("mainPanel()"),
            h4("This is a classic simple layout that is often used to keep user input components in the sidebar separate from
               the outputs in the mainPanel, though there are no restrictions on the placement of elements. Inputs can be located in the main panel and outputs in the sidebar, or some in one, and some in the other."),
            h4("Single elements can be added one by one in the main panel or they could be nested inside other 
               panels"),
            h4("The width of the sidebar can be adjusted by setting the width argument, by default it is 4."),
            h4("The widths of the sidebarPanel and mainPanel should add up to 12, as in the fluidRow examples in the next tab.")
          )
        )'
      )
    ),
    # br(),
    # hr(style = "border: 3px double #58595c;"),
    # br(),
    tabPanel("fluidRow()",
      wellPanel(style = "background-color: #bad1d0;",
        h1("fluidRow()"),
        h4("To put components on the same row. The page is 12 units wide.")
      ),  
      br(),
      wellPanel(
        fluidRow(
          column(width = 6,  style = "background-color: #cdced1; border: 3px solid #6e717a;",
                 h4("column(width = 6)"), p("The page contains 12 units, so the widths of the columns can add up to 12.")),
          column(width = 6,  style = "background-color: #a7b6d1; border: 3px solid #6e717a;", 
                 h4("column(width = 6)"), p("If the page is resized, these elements may stack up vertically on each other."))
        )
      ),  
      br(),
      wellPanel(
        fluidRow(
          column(width = 4,  style = "background-color: #cdced1; border: 3px solid #6e717a;",
                 h4("column(width = 4)"), img(src="bioinformatics_logo.png", width = "200px", height = "80px"), p("Multiple
                       elements can be placed in a column")),
          column(width = 7,  style = "background-color: #a7b6d1; border: 3px solid #6e717a;", 
                 h4("column(width = 7)"), p("If the widths add up to less than 12, there may be an empty space at the end."))
        )
      ),
      wellPanel(
        br(),
        fluidRow(
          column(width = 3,  style = "background-color: #cdced1; border: 3px solid #6e717a;",
                 h4("column(width = 3)")),
          column(width = 4,  style = "background-color: #a7b6d1; border: 3px solid #6e717a;", 
                 h4("column(width = 4)")),
          column(width = 3, offset = 2, style = "background-color: #cdced1; border: 3px solid #6e717a;", 
                 h4("column(width = 3, offset = 2)"))
        )
      ),
      br(),
      hr(style = "border: 3px double #58595c;"),
      p("The code for colouring these columns has been removed from the code below to simplify it."),
      tags$pre(
        'fluidRow(
          column(width = 6,  
                 h4("column(width = 6)"), p("The page contains 12 units, so the widths of the columns can add up to 12.")),
          column(width = 6,   
                 h4("column(width = 6)"), p("If the page is resized, these elements may stack up vertically on each other."))
        ),
        br(),
        fluidRow(
          column(width = 4,  
                 h4("column(width = 4)")),
          column(width = 7,   
                 h4("column(width = 7)"), p("If the widths add up to less than 12, there may be an empty space at the end."))
        ),
        br(),
        fluidRow(
          column(width = 3,  
                 h4("column(width = 3)")),
          column(width = 4,   
                 h4("column(width = 4)")),
          column(width = 3, offset = 2,  
                 h4("column(width = 3, offset = 2)"))
        )'
      )  
    ),  
    # br(),
    # hr(style = "border: 3px double #58595c;"),
    # br(),
    tabPanel("flowLayout", 
      wellPanel(style = "background-color: #bad1d0;",
        h1("flowLayout()"),
        h4("Elements are arranged left-to-right, top-to-bottom. If the page is resized, 
          elements may move around.")
      ),  
      br(),
      wellPanel(
        flowLayout(
          h3("object 1", style = "background-color: #a7b6d1; border: 3px solid #6e717a;"),
          h3("object 2, maybe a plot", style = "background-color: #cdced1; border: 3px solid #6e717a;"),
          h3("object 3, could be a table", style = "background-color: #a7b6d1; border: 3px solid #6e717a;"),
          h3("object 4, some text", style = "background-color: #cdced1; border: 3px solid #6e717a;"),
          h3("object 5, an image", style = "background-color: #a7b6d1; border: 3px solid #6e717a;")
        )
      )
    ),  
    # br(),
    # hr(style = "border: 3px double #58595c;"),
    # br(),
    tabPanel("splitLayout",
      wellPanel(style = "background-color: #bad1d0;",
        h1("splitLayout()"),
        h4("The page is split horizontally to fit in the components. By default, equal width is given to each 
          component but this can be adjusted using the cellWidths argument. If the page is resized the components may
          change width but they do not flow on to separate lines.")
      ),
      wellPanel(
        splitLayout(
          h3("object 1, maybe a plot", style = "background-color: #cdced1; border: 3px solid #6e717a;"),
          h3("object 2, could be a table", style = "background-color: #a7b6d1; border: 3px solid #6e717a;"),
          h3("object 3, a panel containing multiple elements", style = "background-color: #cdced1; border: 3px solid #6e717a;")
        )
      )
    ),  
    # br(),
    # hr(style = "border: 3px double #58595c;"),
    # br(),
    tabPanel("verticalLayout",
      wellPanel(style = "background-color: #bad1d0;",
        h1("verticalLayout()"),
        h4("For arranging objects vertically.")
      ),
      verticalLayout(
        wellPanel(
          wellPanel(
            h3("object 1"), 
            h4("This could be a single elements like plots and pieces of text, or panels containing multiple elements"), 
            style = "background-color: #a7b6d1; border: 3px solid #6e717a;"
          ),
          wellPanel(
            h3("object 2"), 
            h4("maybe a plot"), 
            style = "background-color: #cdced1; border: 3px solid #6e717a;"
          ),
          wellPanel(
            h3("object 3"),
            h4("could be a table"), 
            style = "background-color: #a7b6d1; border: 3px solid #6e717a;"
          )
        )
      )
    ),  
    # br(),
    # hr(style = "border: 3px double #58595c;"),
    # br(),
    tabPanel("panels",
      wellPanel(style = "background-color: #bad1d0;",
        h1("flowLayout() with different types of panel"),
        h4("This is a flowLayout() just as in the flowLayout tab, but each element here is a panel. The third one is a 
          conditional panel and requires the checkbox in the 2nd panel to be ticked in order to appear.")
      ),
      br(),
      wellPanel(
        flowLayout(
          wellPanel(h3("wellPanel()"), 
                    h4("slightly inset border and grey background")
                    ),
          wellPanel(h3("wellPanel()"), 
                    h4("This one contains a checkbox"), 
                    checkboxInput("show_conditional_panel", "show next panel")
                    ),
          conditionalPanel(condition = "input.show_conditional_panel == 1", 
                           h3("conditionalPanel()"), 
                           h4("Creates a panel that is visible or not, depending on the value of a JavaScript expression")
                           ),
          titlePanel("titlePanel(), for creating an application title", 
                     windowTitle = "Shiny layouts"),
          inputPanel(h3("inputPanel()"), 
                     h4("A flowLayout() with a grey border and light grey background, suitable for wrapping inputs")
                     )
        )
      ),  
      br(),
      h4("If the checkbox is selected, more panels appear including an absolutePanel()"),
      checkboxInput("show_absolute_panel", "show some messy panels"),
      conditionalPanel(condition = "input.show_absolute_panel == 1", 
                       h4("This is a conditional panel that has other panels nested within it, the code is the same as the set of panels above, except the first wellPanel has been swapped for an absolutePanel."),
        wellPanel(
          flowLayout(
            absolutePanel(h3("absolutePanel()"), 
                          h4("contents are absolutely positioned"), 
                          h4("not generally recommended"), 
                          style = "background-color: #a7b6d1; border: 3px solid #6e717a;"
                          ),
            wellPanel(h3("wellPanel()"), 
                      h4("This one contains a checkbox"), 
                      checkboxInput("show_conditional_panel2", "show next panel")
                      ),
            conditionalPanel(condition = "input.show_conditional_panel2 == 1", 
                             h3("conditionalPanel()"), 
                             h4("Creates a panel that is visible or not, depending on the value of a JavaScript expression")
                             ),
            titlePanel("titlePanel(), for creating an application title", 
                       windowTitle = "Shiny layouts"),
            inputPanel(h3("inputPanel()"), 
                       h4("A flowLayout() with a grey border and light grey background, suitable for wrapping inputs"))
          )
        )  
      )
    ),  
    # br(),
    # hr(style = "border: 3px double #58595c;"),
    # br(),
    tabPanel("tabPanels",
      wellPanel(style = "background-color: #bad1d0;",
        h1("tabPanel layouts"),
        h4("There are 3 different types of tabPanel layouts. The first shown here, tabsetPanel(), is also used in the main application to show the different types of layouts.")
      ),  
      br(),
      h2("tabsetPanel()"),
      tabsetPanel(
        tabPanel("tab1",
                 plotOutput(outputId = "tab1_plot", width = "300px", height = "300px"),
                 tableOutput(outputId = "tab1_table"),
                 textOutput(outputId  = "tab1_text")
                 ),
        tabPanel("tab2", br(), "tab2 panel contents"),
        tabPanel("tab3", br(), "tab3 panel contents")
      ),
      br(),
      hr(),
      br(),
      h2("navlistPanel()"),
      navlistPanel(
        tabPanel("tab1", "tab1 panel contents"),
        tabPanel("tab2", "tab2 panel contents"),
        tabPanel("tab3", "tab3 panel contents")
      ),
      br(),
      hr(),
      br(),
      h2("navbarPage()"),
      navbarPage(title = "Title here",
        tabPanel("tab1", "tab1 panel contents", br(), br(), br(), br()),
        tabPanel("tab2", "tab2 panel contents", br(), br(), br(), br()),
        tabPanel("tab3", "tab3 panel contents", br(), br(), br(), br())
      ),
      tags$pre(
         'tabsetPanel(
            tabPanel("tab1",
                     plotOutput(outputId = "tab1_plot", width = "300px", height = "300px"),
                     tableOutput(outputId = "tab1_table"),
                     textOutput(outputId  = "tab1_text")
                     ),
            tabPanel("tab2", br(), "tab2 panel contents"),
            tabPanel("tab3", br(), "tab3 panel contents")
        ),'
      ),
      tags$pre(   
         'navlistPanel(
           tabPanel("tab1", "tab1 panel contents"),
           tabPanel("tab2", "tab2 panel contents"),
           tabPanel("tab3", "tab3 panel contents")
         )'
      ),
      tags$pre(          
         'navbarPage(
            title = "Title here",
            tabPanel("tab1", "tab1 panel contents",
            tabPanel("tab2", "tab2 panel contents",
            tabPanel("tab3", "tab3 panel contents")
         )'
      )
    )
  )
)
  
server <- function(input, output, session) {

  output$tab1_plot <- renderPlot(plot(1:50))
  
  output$tab1_table <- renderTable(head(iris))
  
  output$tab1_text <- renderText("some text here")

  
  observeEvent(input$browser, {
    
    browser()
    
  })
  
}

shinyApp(ui, server)
#shinyAppDir("D:/Shiny_course/Shiny_intro/Intro_to_Shiny_course/Part1/examples/layouts_with_tabsetPanel/")

