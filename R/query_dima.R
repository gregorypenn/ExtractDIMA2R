#' Query a DIMA database
#'
#' @param dima_path A filepath to a MS Access DIMA database.
#' @param query A list of named SQL queries.
#'
#' @return A list of query results.
#' @export
query_dima <- function (dima_path, query) {
  if (.Platform$OS.type != "windows") {
    stop(
      "Function query_dima can only be run on Windows, due to unavailability of MS Access driver on other systems."
    )
  }
  if (is.null(names(query)) |
      length(names(query)[!grepl(x = names(query),
                                 pattern = "^$")]) != length(names(query))) {
    warning(
      "The query vector must have a name for each value, even if there is only one. Using the query text as names, name the input parameter for more concise naming"
    )
    names(query) <- query
  }
  if (!grepl(x = dima_path, pattern = "\\.(MDB)|(mdb)|(accdb)|(ACCDB)$")) {
    stop("Valid file extension required for the argument dima.")
  }
  arch <- R.Version()$arch
  if (arch == "x86_64") {
    dima_channel <- RODBC::odbcConnectAccess2007(dima_path)
  }
  if (arch == "i386") {
    stop("32-bit R is no longer supported.")
  }
  query_result <-
    lapply(
      query,
      FUN = RODBC::sqlQuery,
      channel = dima_channel,
      stringsAsFactors = FALSE
    )
  RODBC::odbcClose(channel = dima_channel)
  return(query_result)
}
