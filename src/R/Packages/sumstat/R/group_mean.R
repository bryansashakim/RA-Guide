#' A group_by mean Function
#'
#' This function allows you to get means of a each variable group
#' @param data data you are working with
#' @param group variable you want to tab
#' @param value variable you want to tab
#' @keywords 
#' @export
#' @examples
#' group_mean()
#' 
group_mean = function(data, group, value) {
  data %>% group_by({{ group}} ) %>% summarize(mean=mean({{ value }}))
}