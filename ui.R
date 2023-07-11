################################################################################
# Pages
source("pages/agegroup ui.R") # defines agegroup_page
source("pages/download ui.R") # defines download_page

################################################################################
# tabPanel wrapper
ui = navbarPage(
  title="CS Workforce",
  header=tagList(
    # CSS style tags to tweak appearance
    tags$style(HTML(".container-fluid:has(.tab-content) {padding-left: 0px; padding-right: 0px;}"), # note that support for has() is somewhat limited
               HTML(".navbar-static-top {margin-bottom: 0px;}"),
               HTML(".inline-select {padding: 0px;}"),
               HTML(".form-group {margin-bottom: 0px;}"),
               HTML(".default-sortable.bucket-list-container {padding: 0px; margin: 0px;}"),
               HTML(".default-sortable .rank-list-container {padding: 2px; margin: 0px 0px;}"),
               HTML(".rank-list-title {margin: 0px 0px;}"),
               HTML(".default-sortable .rank-list {margin: 2px; min-height: 5px;}"),
               HTML(".default-sortable .rank-list-item {padding: 0px 2px; margin: 2px; display: inline-flex; box-sizing: content-box;}")
    ),
    
    useShinydashboard(),
    useShinyjs() # Enables the shinyJS package
  ),
  navbarMenu("Age",
             tabPanel("Age groups",agegroup_page)
  ),
  # Placeholder example of multiple tabs
  navbarMenu("Placeholder",
             tabPanel("Tab 1",""),
             tabPanel("Tab 2","")
  ),
  tabPanel("Save dashboard",download_page)
)
