server <- function(input, output) {
    numPressed <- 1
    output$queryOutput <- renderDataTable({
        req(input$runQuery == numPressed)
        numPressed <<- numPressed + 1
        dbGetQuery(con, input$query)
    })

}