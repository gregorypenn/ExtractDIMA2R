
# ExtractDima2R

<!-- badges: start -->
<!-- badges: end -->

The goal of ExtractDima2R is to move data out of a MS Access DIMA database and into an R-friendly format. This only works on MS Windows machines, because Windows is the only platform for which the required ODBC database driver for MS Access is available. It may be possible to make this platform independent using a Java driver, but I haven't gotten that to work yet.

This package is very narrowly focused on the single task of moving data from DIMA to R. For this reason, only a few functions are provided and all package functions are currently exported, though users may need only `extract_DIMA()`.

- `extract_DIMA()` extracts all DIMA tables to a named list of dataframes, optionally returning only non-empty tables.
- `query_table_SQL()` creates a SQL query for getting select (all by default) columns from a table.
- `query_dima()` does submits queries to the DIMA database.

## Example

The most common use case is probably:

``` r
library(ExtractDima2R)
dima_tables.list <- extract_DIMA("path/to/DIMA.mdb", empty_tables = FALSE)
```

