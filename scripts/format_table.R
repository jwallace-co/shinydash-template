# Call from within a reactive environment
format_table <- function(dat,format_numeric="none",format_ignore=NULL,align_char="l",align_num="r",show_header=TRUE,has_html=FALSE) {
  
  # Identify column types
  col_n <- ncol(dat)
  col_numeric <- unlist(lapply(dat,is.numeric))
  col_char <- unlist(lapply(dat,is.character))
  
  # Select a function to format numeric columns
  form_type <- switch(format_numeric,
                      percent_signed0 = function(x) paste0(sprintf("%+.0f",x*100),"%"),
                      percent_signed1 = function(x) paste0(sprintf("%+.1f",x*100),"%"),
                      percent_unsigned0 = function(x) paste0(sprintf("%.0f",x*100),"%"),
                      percent_unsigned1 = function(x) paste0(sprintf("%.1f",x*100),"%"),
                      pounds = function(x) paste0("£",formatC(x,big.mark=",",format="f",digits=0)), # note the £ will display incorrectly locally, but is fine once published
                      thousands = function(x) formatC(x,big.mark=",",format="f",digits=0),
                      function(x) x)
  form_func <- function(x) ifelse(is.na(x),"[c]",form_type(x)) # NA handling
  
  # Apply numeric formating
  dat_formed <- dat %>%
    mutate(across(where(is.numeric),~ form_func(.x)))
  
  # Select alignments
  alignments <- rep("?",col_n)
  alignments[col_numeric] <- align_num
  alignments[col_char] <- align_char
  alignments <- paste0(alignments,collapse="")
  
  # Output table
  if (has_html) {
    renderTable({dat_formed},align=alignments,rownames=FALSE,colnames=show_header,sanitize.text.function = function(x) x)()
  } else {
    renderTable({dat_formed},align=alignments,rownames=FALSE,colnames=show_header)()
  }
}