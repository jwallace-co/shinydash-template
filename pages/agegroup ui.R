
agegroup_body <- dashboardBody(
  # Define the structure of the page
  fluidRow(
    column(width = 9,
           tabBox(title=tagList(div(class='lefttitle',agegroup_title)),
                  id="agegroup_panels",width=NULL,side="right",#height="600px",
                  tabPanel("Graph",plotOutput("agegroup_graph",height="600px")),
                  tabPanel("Table",tableOutput('agegroup_table')),#tableOutput('paygroup_notetable'))
           )
    ), # end column

    column(width = 3,
           box(width = NULL, status = "info",collapsible=FALSE,title="Tab for filters",
               selectInput(inputId="agegroup_select_year",label="Year",choices=c(acses_years),selected=acses_current),
               selectInput(inputId="agegroup_select_status",label="Status",choices=c(acses_status)),
               uiOutput("agegroup_filter_var"), # inputId is agegroup_select_var
               uiOutput("agegroup_filter_values"), # inputId is agegroup_select_values
               br(),
               div(style="padding: 5px 0px; display: block",downloadButton("agegroup_data_download","Download data"))
           ),

           box(width = NULL, title="About", collapsible=TRUE,
               p(warning_text)
           )
    )
    
  ) # end fluid row
) # end dashboard body

agegroup_page = dashboardPage(
  dashboardHeader(disable=TRUE),
  dashboardSidebar(disable = TRUE),
  agegroup_body,
  skin='black'
)