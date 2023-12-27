#' Extract DIMA Database to R Dataframes
#'
#' @description
#' `extract_dima_tables()` queries all rows of all tables for DIMA 5.6.
#'
#' **Note: This function only works on Windows systems, due to unavailability
#' of a MS Access driver on other systems.**
#'
#' @param dima_path A filepath to a DIMA database.
#' @param exclude_empty_tables Logical. If TRUE, tables with no data will not be returned.
#'
#' @return A list of dataframes, one for each DIMA table and with the same names.
#' @export
extract_dima_tables <- function (dima_path, exclude_empty_tables = TRUE) {
  query_list <- purrr::map(query_table_SQL(ExtractDima2R::DIMA_tablenames))
  names(query_list) <- DIMA_tablenames
  query_results <- query_dima(query_list)
  if (exclude_empty_tables) {
    query_results <- query_results[which(purrr::map(query_results, nrow) > 0)]
  }
  return(query_results)
}
