#' Extract DIMA tables for the BLM's Carlsbad Field Office
#'
#' @details
#' The names of DIMA tables extracted are stored in the character vector
#' `CFO_tables`, which is exported from this package.
#'
#' @param dima A filepath to a DIMA database.
#'
#' @return A list of dataframes, each with the name and contents of a DIMA table.
#' @export
extract_CFO_tables <- function (dima) {
  tables <- ExtractDima2R::CFO_tables
  query <- purrr::map(tables, query_table_SQL)
  names(query) <- tables
  return(query_dima(dima, query))
}
