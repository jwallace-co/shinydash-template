################################################################################################################################################################
# Combine
output$download_pptx <- downloadHandler(
  filename = function(){paste("Civil Service dashboard ", Sys.Date(),".pptx", sep="")},
  content = function(file){
    slide_scaling=1.3
    pp <- read_pptx("template_powerpoint/Template.pptx")

    pp <- wide_slide(pp,agegroup_title,agegroup_graph_func,slide_scaling)
    pp <- square_slide(pp,agegroup_title,agegroup_graph_func,slide_scaling)

    pp %>%
      print(target=file)
  }
)