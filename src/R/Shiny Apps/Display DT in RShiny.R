library(shiny)
library(ggplot2)
library(DT)

ui <- fluidPage(
  title = "Examples of DataTables",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "diamonds"',
        checkboxGroupInput("show_vars", "Columns in diamonds to show:",
                           names(diamonds), selected = names(diamonds))
      ),
      conditionalPanel(
        'input.dataset === "mtcars"',
        helpText("Click the column header to sort a column.")
      ),
      conditionalPanel(
        'input.dataset === "iris"',
        helpText("Display 5 records by default.")
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("diamonds", DT::dataTableOutput("mytable1")),
        tabPanel("mtcars", DT::dataTableOutput("mytable2")),
        tabPanel("iris", DT::dataTableOutput("mytable3"))
      )
    )
  )
)

server <- function(input, output) {
  
  # choose columns to display
  diamonds2 = diamonds[sample(nrow(diamonds), 1000), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(diamonds2[, input$show_vars, drop = FALSE])
  })
  
  # sorted columns are colored now because CSS are attached to them
  output$mytable2 <- DT::renderDataTable({
    DT::datatable(mtcars, options = list(orderClasses = TRUE))
  })
  
  # customize the length drop-down menu; display 5 rows per page by default
  output$mytable3 <- DT::renderDataTable({
    DT::datatable(iris, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  })
  
}
shinyApp(ui, server)

shinyApp(
  ui = fluidPage(DTOutput('tbl')),
  server = function(input, output) {
    output$tbl = renderDT(
      iris, options = list(lengthChange = FALSE)
    )
  }
)

################################################################################################

shinyUI(fluidPage(
  titlePanel("Sales trends"),titlePanel("People score"),
  
  sidebarLayout(sidebarPanel(
    
    textInput("text", label = h3("Text input"), value = "Enter text..."),
    
    numericInput("obs", "Number of observations to view:", 3),
    
    helpText("Note: while the data view will show only the specified",
             "number of observations, the summary will still be based",
             "on the full dataset."),
    
    submitButton("Update View")
  ),
  
  mainPanel(
    h4("Volume: Total sales"),
    verbatimTextOutput("volume"),
    
    h4("Top people"),
    tableOutput("view")
  ))))

df1<-data.frame (Name=c("Carlos","Pete","Carlos","Carlos","Carlos","Pete","Pete","Pete","Pete","Homer"),Sales=(as.integer(c("3","4","7","6","4","9","1","2","1","9"))))
shinyServer(function(input, output) {
  output$value <- renderPrint({ input$text })
  datasetInput <- reactive({
    switch(input$dataset,df1%>% filter(Name %in% "input$text")%>% select(Name, Sales)%>% arrange(desc(Sales)))
  })
  output$volume <- renderPrint({
    dataset <- datasetInput()
    sum(dataset$Sales)
  })})

shinyApp(shinyUI,shinyServer)
