#' Extract DIMA tables for the BLM's Carlsbad Field Office
#'
#' @param dima A filepath to a DIMA database.
#'
#' @return A list of dataframes, each with the name and contents of a DIMA table.
#' @export
extract_CFO_tables <- function (dima) {
  query <- purrr::map(CFO_tables, query_table_SQL)
  names(query) <- tables
  return(query_dima(dima, query))
}
