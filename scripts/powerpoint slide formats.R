wide_slide <- function(power,title,graph,scaling) {
  power %>%
    add_slide(layout="Wide",master="AandI Style") %>%
    ph_with(title,ph_location_type(type="title")) %>%
    ph_with("Placeholder - insight and caveats",ph_location_type(type="body",id=1)) %>% #1
    ph_with(graph() + labs(title=NULL),ph_location_type(type="body",id=3),scale=scaling) %>% #3
    ph_with(graph()$labels$title,ph_location_type(type="body",id=2)) #2
}
square_slide <- function(power,title,graph,scaling) {
  power %>%
    add_slide(layout="Square",master="AandI Style") %>%
    ph_with(title,ph_location_type(type="title")) %>%
    ph_with("Placeholder - insight and caveats",ph_location_type(type="body",id=1)) %>% #
    ph_with(graph() + labs(title=NULL),ph_location_type(type="body",id=2),scale=scaling) %>% #
    ph_with(graph()$labels$title,ph_location_type(type="body",id=3)) #
}