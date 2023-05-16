# Set options
options(scipen=99999999)

# Load relevent libraries
source("scripts/load libraries.R")

# Titles for graphs
agegroup_title <- "Civil Service age groups"

# Disclaimer
warning_text <- paste0("This dashboard is an example of using published data on the Civil Service workforce in an interactive R Shiny dashboard. ",
"All figures are for demonstration purposes only, are not part of the official publication, and are not suitable to be used for any other purposes.")

################################################################################
# Small utility functions
################################################################################
rounding <- function (x, accuracy) plyr::round_any(x, accuracy, janitor::round_half_up)

################################################################################
# Functions
################################################################################
# Powerpoint slide format wrappers
source("scripts/powerpoint slide formats.R")
# Defines wide_slide(), square_slide()

# Table wrapper functions
source("scripts/format_table.R")
# Defines format_table()

# Wrappers for defining colour schemes
source("scripts/colour schemes.R")
# Defines lab_seq(), col_seq(), grade_seq()

# Functions to access CS data browser and metadata
source("scripts/data browser functions.R")
# Defines:
# acses_measures
# acses_status
# acses_years
# acses_current
# acses_var_values
# acses_vars
# acses_data_url()
# acses_data()