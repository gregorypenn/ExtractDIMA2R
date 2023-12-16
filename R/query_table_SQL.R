#' Construct a SQL query
#'
#' @param table The name of the table to query.
#' @param cols A character vector of column names to query.
#'  Alternatively a character string with comma separated column names.
#' @param condition A logical condition to determine which rows to select.
#'  Defaults to `NULL` to select all rows.
#'
#' @return A character string containing a valid SQL query for the contents of a table.
#' @export
#'
#' @examples
#' query_table_SQL("TableName", "Column_A")
#' query_table_SQL("TableName", c("ID", "Column_A"))
#' query_table_SQL("TableName", "Column_A, Column_B")
#' query_table_SQL("TableName", c("Column_A"), condition = "some condition")

query_table_SQL <- function (table, cols = "*", condition = NULL) {
  cols <- ifelse(length(cols) > 1, paste(cols, collapse = ", "), cols)
  query <- paste("SELECT", cols, "FROM", table)
  if (!is.null(condition)) query <- paste(query, "WHERE", condition)
  return(query)
}
