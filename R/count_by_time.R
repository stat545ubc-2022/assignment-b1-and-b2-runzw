#' @title count_by_time function
#'
#' @details Given a Date column, count the occurrence of a date unit specified by floor_unit. This could be useful when finding the pattern between values and specified time frames.
#'
#' @param dataset, the dataset to be analyzed
#'
#' @param date_column, name of the Date column on which to be applied the operation
#'
#' @param floor_unit, the date unit to be counted
#'
#' @return a N X 2 dataframe with column "time" and "count", which represents the list of date unit values and the number of their occurrence, respectively.
#'
#' @examples
#' library(lubridate)
#' library(dplyr)
#' library(tidyr)
#' library(datateachr)
#' count_by_time(vancouver_trees, "date_planted", "year")
#' count_by_time(vancouver_trees, "date_planted", "month")
#' count_by_time(vancouver_trees, "date_planted", "day")
#'
#' @export
#'
count_by_time <- function(dataset, date_column, floor_unit) {
  if (!is.character(date_column) | (length(date_column) != 1)) {
    stop("The selected column must be a single string.")
  }

  if(!(date_column %in% names(dataset))){
    stop("The selected column does not exist in the given dataset.")
  }

  if(!(inherits(dataset[[date_column]], 'Date'))){
    stop("The selected column must be a Date.")
  }

  if(!(floor_unit %in% c("year", "month", "day"))){
    stop("floor_unit must be one of year, month, or day.")
  }

  format_unit <- if(floor_unit == "year") "%Y" else (if(floor_unit == "month") "%b" else "%d")
  return (dataset %>%
    tidyr::drop_na(.data[[date_column]]) %>%
    dplyr::mutate(date_floored = lubridate::floor_date(.data[[date_column]], unit=floor_unit)) %>%
    dplyr::mutate(time = format(date_floored, format_unit)) %>%
    dplyr::group_by(time) %>%
    dplyr::count(time, name = "count"))
}
