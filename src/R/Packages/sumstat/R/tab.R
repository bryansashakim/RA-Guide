#' A Tabulate Function
#'
#' This function allows you to create one-way tabulations (two-way coming soon!).
#' @param dataset data you are working with
#' @param var variable you want to tab
#' @keywords tab
#' @export
#' @examples
#' tab()

tab <- function(dataset, var) {
  dataset %>%
    group_by({{var}}) %>%
    summarise(n = n()) %>%
    mutate(totalN = (cumsum(n)),
           percent = round((n / sum(n)), 2),
           cumpercent = round(cumsum(freq = n / sum(n)), 2))
}

