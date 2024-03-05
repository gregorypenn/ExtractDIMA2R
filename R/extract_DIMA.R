#' Extract DIMA tables
#'
#' `extract_DIMA()` converts the contents of a DIMA database into a named list
#' of dataframes, optionally returning only non-empty tables.
#'
#' @param path File path to a DIMA database.
#' @param empty_tables Should empty tables be returned?
#'
#' @return A named list of dataframes, each representing a table in DIMA.
#' @export
extract_DIMA <- function(path, empty_tables = FALSE) {
  tablenames <- ExtractDima2R:::DIMA_tablenames
  query_list <- list()
  for (i in seq_along(tablenames)) {
    query_list[i] <- query_table_SQL(tablenames[i])
  }
  names(query_list) <- tablenames

  results <- query_dima(path, query_list)

  if (!empty_tables) {
    has_data <- unlist(lapply(results, FUN = function (x) nrow(x) > 0))
    results <- results[has_data]
  }
  return(query_list)
}
extract_DIMA("stuff")
