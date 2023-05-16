################################################################################################################################################################
# Dynamically generated UI items

# Define the available options for variables based on those included in the year selected
output$agegroup_filter_var <- renderUI({
  varlist <- acses_vars %>%
    filter(year==input$agegroup_select_year) %>%
    pull(var) %>%
    setdiff("Age") %>%
    c("--",.)
  selectInput(inputId="agegroup_select_var",label="Choose a variable",choices=varlist,selected="--")
})

# Define the available options for filtering the variable based on the selected variable
output$agegroup_filter_values <- renderUI({
  if (input$agegroup_select_var=="--") {
    # Return a hidden selector which returns a value of '--' if there is no variable selected
    div(style="display:none",selectInput("agegroup_select_values",NULL,choices="--"))
    
  } else {
    valuelist <- acses_var_values %>%
      filter(year==input$agegroup_select_year,var==input$agegroup_select_var) %>%
      pull(values) %>%
      sort()
    selectInput("agegroup_select_values",NULL,choices=valuelist,selected=setdiff(valuelist,c("Unknown","Undeclared")),multiple=TRUE,size=5,selectize=FALSE)
  }
})

################################################################################################################################################################
# Data setup

agegroup_vars <- reactive({ c("Age",setdiff(input$agegroup_select_var,"--")) }) # Returns age and any selected variable

# Unfiltered data from the Civil Service statistics data browser, including footnotes
agegroup_data_raw <- reactive({
  vars <- agegroup_vars()
  year <- input$agegroup_select_year

  # returns a list(data=data,notes=footnotes) based on selections
  acses_data(vars,year)
})

agegroup_data_filtered <- reactive({
  dat <- agegroup_data_raw()$data
  vars <- agegroup_vars()
  
  # Filter
  dat <- dat %>%
    filter(Status%in%input$agegroup_select_status) %>% # selected status
    filter(Age!="Unknown") # remove missings
  
  # Filter on selected values if a variable has been chosen, and any values are selected
  if (input$agegroup_select_var!="--" & input$agegroup_select_values[1]!="") {
    var = input$agegroup_select_var
    values = input$agegroup_select_values
    dat <- dat %>%
      filter(if_any(any_of(var),~.x%in%values)) # Syntax for filtering where the name of the variable and values are dynamic
  }
  
  dat %>%
    select(Year,any_of(vars),Headcount) %>%
    mutate(Headcount=as.numeric(Headcount))
})

################################################################################################################################################################
# Table setup

# Data to use for table / download
agegroup_data_table <- reactive({
  dat <- agegroup_data_filtered()
  vars <- agegroup_vars()
  
  # Introduce a dummy variable if none is selected
  if (input$agegroup_select_var=="--") {
    dat <- mutate(dat,Total="Civil Service")
    vars <- c("Age","Total")
  }
  
   dat %>%
    pivot_wider(names_from="Age",values_from=Headcount)
})

# Table to display in UI
output$agegroup_table <- reactive({
  dat <- agegroup_data_table()
  format_table(dat,format_numeric="thousands")
})

# Download button for data in table
output$agegroup_data_download <- downloadHandler(filename="CS Age by group.csv",content=function(file) {
  write.csv(agegroup_data_table(),file,row.names=FALSE,fileEncoding="latin1") # Need to convert to windows default encoding (latin1) for some symbols
})


################################################################################################################################################################
# Graph setup
age_format <- function(x) ifelse(is.na(x),"",formatC(x,big.mark=",",format="f",digits=0))

agegroup_graph_func <- reactive({
  
  # Data setup
  dat <- agegroup_data_filtered()
  if (input$agegroup_select_var=="--") {
    dat <- mutate(dat,group="Civil Service") # Introduce a dummy variable if none is selected
  } else {
    dat <- rename(dat,"group"=input$agegroup_select_var)
  }
  dat <- dat %>%
    arrange(group,Age) %>%
    mutate(group=gsub("(Ministry of )|(Department of )|(Department for)|(Office of the )|(Office for )|(Office of )","",group)) %>%
    mutate(group=str_wrap(group,24))
  
  
  # Get values
  agegroups <- dat$Age %>%
    unique() %>%
    sort()
  hc_max <- max(dat$Headcount,na.rm=T)
  
  graphtitle <- paste0("Headcount of civil servants by age group in ",input$agegroup_select_year)
  graphnotes <- "Figures are sourced from the Civil Service Statistics data browser"
  
  dat %>%
    mutate(hc_scale = Headcount/hc_max) %>%
    mutate(lowlabel=ifelse(hc_scale<.2,age_format(Headcount),"")) %>%
    mutate(highlabel=ifelse(hc_scale>=.2,age_format(Headcount),"")) %>%
    ggplot(aes(x=Age,y=Headcount,fill=Age)) +
    geom_bar(stat='identity',position="dodge",show.legend=FALSE) +
    scale_fill_manual(palette=col_seq,limits=agegroups) +
    geom_text(aes(label=highlabel,y=Headcount-hc_max*.02,fontface="bold"),hjust=1,show.legend=FALSE,colour=grey(1)) +
    geom_text(aes(label=lowlabel,y=Headcount+hc_max*.02,fontface="bold"),hjust=0,show.legend=FALSE,colour=grey(0.4)) +
    labs(title=graphtitle,caption=graphnotes) +
    facet_wrap(~group) +
    coord_flip() +
    scale_x_discrete(name=NULL) +
    scale_y_continuous(name="Headcount",labels=age_format) +
    theme(text=element_text(size=14),
          panel.border=element_blank(),
          legend.title=element_blank(),
          plot.title=element_text(margin=margin(0,0,10,0),size=16,colour=grey(.4)),
          axis.title=element_text(size=14,colour=grey(.4)),
          plot.caption=element_text(size=10,colour=grey(.4)))
})

output$agegroup_graph <- renderPlot({agegroup_graph_func()})
