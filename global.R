packages <- c('shiny', 'DT','RSQLite', 'DBI')
invisible(lapply(packages, library, character.only = TRUE))

con <- dbConnect(RSQLite::SQLite(), dbname = "exampledb1.db")

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server, options = list(port = 5737))
