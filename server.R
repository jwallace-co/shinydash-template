################################################################################
server <- function(input, output, session) {
  source("pages/agegroup server.R",local=TRUE)
  source("pages/download server.R",local=TRUE)
}