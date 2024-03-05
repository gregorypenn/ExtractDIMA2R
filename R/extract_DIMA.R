#' Extract DIMA tables
#'
#' `extract_DIMA()` extracts the contents of a DIMA database into a named list
#' of dataframes, optionally returning only non-empty DIMA tables.
#'
#' @param path File path to a DIMA database.
#' @param empty_tables Should empty tables be returned?
#'
#' @return A named list of dataframes, each representing a table in DIMA.
#' @export
extract_DIMA <- function(path, empty_tables = FALSE) {
  query_list <- vector("character", length(DIMA_tablenames))
  for (i in seq_along(DIMA_tablenames)) {
    query_list[i] <- query_table_SQL(DIMA_tablenames[i])
  }
  names(query_list) <- DIMA_tablenames

  results <- query_dima(path, query_list)

  if (!empty_tables) {
    has_data <- unlist(lapply(results, FUN = function (x) nrow(x) > 0))
    results <- results[has_data]
  }

  return(results)
}
