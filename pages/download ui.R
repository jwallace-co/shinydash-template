# Download page
download_body <- dashboardBody(box(warning_text,
                            br(),br(),
                            downloadButton(outputId = "download_pptx", label = "Download PowerPoint"))) # end dashboard body

download_page = dashboardPage(
  dashboardHeader(disable=TRUE),
  dashboardSidebar(disable = TRUE),
  download_body,
  skin='black'
)