################################################################################
# Colour schemes
lab_seq <- function(h2,s2,v2,n) {
  pal <- colorRampPalette(hsv(h2,s2,v2),space="Lab")
  pal(n)
}
col_seq <- function(n) lab_seq(c(.65,.55),c(0.2,.65),c(.4,.9),n)
grade_seq <- function(n) c(col_seq(n-1),grey(.7))