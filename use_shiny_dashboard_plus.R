#' Creates a shinydashboardPlus skeleton
#'
#' @param folder_name name of the folder to create
use_shiny_dashboard_plus <- function(folder_name) {
  # Create dir if not exists
  if (dir.exists(folder_name)) {
    unlink(folder_name, recursive = TRUE)
  }
  dir.create(folder_name)
  # Insert necessary app folders
  file.create(sprintf("%s/%s", folder_name, c("ui.R", "server.R")))
  # Write UI file
  file_in <- file(sprintf("%s/ui.R", folder_name))
  writeLines(
    'shinyUI(dashboardPagePlus(
  dashboardHeaderPlus(
    title = tagList(
      tags$span(
        class = "logo-mini", "LM"
      ),
      tags$span(
        class = "logo-lg", "Logo Large"
      )
    )
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Tab 1", tabName = "tab1", icon = icon("plus-circle")),
      menuItem("Tab 2", tabName = "tab2", icon = icon("bar-chart"))
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css"),
      tags$script(type = "text/javascript", src = "js/event.js")
    ),
    tabItems(
      tabItem(
        tabName = "tab1",
        fluidRow(box("Text 1"))
      ),
      tabItem(
        tabName = "tab2",
        fluidRow(box("Text 2"))
      )
    )
  )
))', 
    file_in
  )
  close(file_in)
  
  # Write Server file
  file_in <- file(sprintf("%s/server.R", folder_name))
  writeLines(
    'shinyServer(function(input, output, session) { \n})', 
    file_in
  )
  close(file_in)
  
  # Write globe.R
  file_in <- file(sprintf("%s/global.R", folder_name))
  writeLines(sprintf("library(%s)", 
                     c("shiny", "shinydashboard", "shinydashboardPlus")), 
    file_in
  )
  close(file_in)
  
  # Create www and data folder
  lapply(c("www/js", "www/css", "www/img", "data"), function(folder) {
    dir.create(sprintf("%s/%s", folder_name, folder), recursive = TRUE)
  })
  # Create JS and CSS file
  file.create(sprintf("%s/www/%s/%s", folder_name, c("js", "css"), 
                      c("event.js", "style.css")))
}
