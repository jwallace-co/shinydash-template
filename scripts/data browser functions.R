# these need to be updated manually
acses_measures <- c("Headcount","FTE","Median_salary","Mean_salary")
acses_status <- c("In post","New entrant CS","Leaver CS","Leaver Dept.")
acses_years <- c(2021,2022)
acses_current <- max(acses_years)

# Get metadata
acses_var_values <- acses_vars <- NULL
for (year in acses_years) {
  # Get metadata on each year
  ay <- read.csv(paste0("https://co-analysis.github.io/acses_data_browser_",year,"/metadata/var_values.csv")) %>%
    filter(!var%in%c("Status","Year"))
  ay$year <- year
  acses_var_values <- bind_rows(acses_var_values,ay)
  acses_vars <- bind_rows(acses_vars,select(ay,year,var) %>% unique())
}

################################################################################
# Functions
################################################################################
acses_data_url <- function(vars,year) {
  vars %>%
    map(~ {if (length(.x) >0) paste0(.x,"/") else ""}) %>%
    unlist(FALSE,FALSE) %>%
    sort() %>%
    paste0(collapse="") %>%
    paste0("https://co-analysis.github.io/acses_data_browser_",year,"/",.,"data.csv")
}

acses_data <- function(vars,years) {
  dat <- NULL
  for (year in years) {
    dy <- read.csv(acses_data_url(vars,year))
    dat <- bind_rows(dat,dy)
  }
  dat <- dat %>%
    mutate(across(where(is.character),~iconv(.x,from="latin1"))) # Need to convert from windows default encoding (latin1) for £ symbol on the linux servers
  footnotes <- filter(dat,!Status%in%acses_status) %>%
    select(Status,Year)
  data <- filter(dat,Status%in%acses_status)
  list(data=data,notes=footnotes)
}

