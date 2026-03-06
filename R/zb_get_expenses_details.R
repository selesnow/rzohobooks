#' Get expenses details
#'
#' @param organization_id Organization id
#' @param expense_id Vector of expense ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/expenses/#get-an-expense
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' expenses <- zb_get_expenses(organizations$organization_id)
#' details <- zb_get_expenses_details(
#'   organization_id = organizations$organization_id[1],
#'   expense_id      = expenses$expense_id
#' )
#' }
zb_get_expenses_details <- function(
    organization_id,
    expense_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      expense_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("expenses/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id = organization_id,
            expense_id      = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
