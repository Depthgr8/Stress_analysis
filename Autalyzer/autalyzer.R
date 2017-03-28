# Documentation -----------------------------------------------------------

# Title: Stress prediction using IBI
# Author: "Deepak Sharma"
# Date: "March 27, 2017"


# Import libraries --------------------------------------------------------

library(shiny)
require(xlsx)

# User interface ----------------------------------------------------------

ui <- fluidPage(sidebarLayout(
  sidebarPanel(
    fileInput(
      "file1",
      "Choose Excel data file",
      accept = c(
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        '.xls',
        '.xlsx'
      )
    ),
    tags$hr()
  ),
  mainPanel(tableOutput("contents"))
))

# Server ------------------------------------------------------------------

server <- function(input, output){
  output$contents <- renderTable({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    a <- read.xlsx(inFile$datapath,
                   sheetIndex = 1)
    ibi_col <- as.data.frame(a)
    write.csv(ibi_col, file = "ibi.csv")
  })
}
     
# Run application ---------------------------------------------------------

shinyApp(ui = ui, server = server)


