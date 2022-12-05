ui <- fluidPage(

  # App title ----
  titlePanel("Query Testing"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(
        textAreaInput('query','Write Query', '', height = 500, resize = 'none'),
        actionButton('runQuery', 'Run Query')
        
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      dataTableOutput("queryOutput")
    )
  )
)