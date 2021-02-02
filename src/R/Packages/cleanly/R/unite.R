#' A `unite` Function
#'
#' This function allows you to combine two columns into where the variables are the same just with different names
#' And you want to combine them because one column has NA in rows where the other column is filled
#' I came across these things a lot working with Monitoring the Future data which is absolute trash data
#' to work with
#' @param data data you are working with
#' @param col1 column 1
#' @param col2 column 2
#' @keywords 
#' @export
#' @examples
#' unite()
#' 
#' 
#' Lets say the variables V1112 and V1113 both are variables for "how likely is it you will graduate college?"
#' They were asked on different forms hence different variable names. We want to combine them into one
unite = function(col1, col2) {
  # data$new_var = col1
  # data$new_var = ifelse(!is.na(data$new_var), data$new_var, data$col2)
  temp=ifelse(!is.na(df$test1), df$test1, df$test2)
  # return(data$new_var)
  return(temp)
}
