wide_slide <- function(power,title,graph,scaling,placeholder="Placeholder - insight and caveats") {
  # If reactive, evaluate
  if ("reactiveExpr" %in% class(graph)) graph <- graph()

  # Use the Title if there is one, otherwise use a placeholder
  if (!is.null(graph$labels$title)) graphtitle = graph$labels$title else graphtitle = "Graph title"
  
  power %>%
    add_slide(layout="Wide",master="AandI Style") %>%
    ph_with(title,ph_location_type(type="title")) %>%
    ph_with(placeholder,ph_location_type(type="body",id=1)) %>% #1
    ph_with(graph + labs(title=NULL),ph_location_type(type="body",id=3),scale=scaling) %>% #3
    ph_with(graphtitle,ph_location_type(type="body",id=2)) #2
}

square_slide <- function(power,title,graph,scaling,placeholder="Placeholder - insight and caveats") {
  # If reactive, evaluate
  if ("reactiveExpr" %in% class(graph)) graph <- graph()

  # Use the Title if there is one, otherwise use a placeholder
  if (!is.null(graph$labels$title)) graphtitle = graph$labels$title else graphtitle = "Graph title"
  
power %>%
    add_slide(layout="Square",master="AandI Style") %>%
    ph_with(title,ph_location_type(type="title")) %>%
    ph_with(placeholder,ph_location_type(type="body",id=1)) %>%
    ph_with(graph + labs(title=NULL),ph_location_type(type="body",id=2),scale=scaling) %>%
    ph_with(graphtitle,ph_location_type(type="body",id=3)) #3
}