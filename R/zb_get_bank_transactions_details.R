#' Get bank transactions details
#'
#' @param organization_id Organization id
#' @param transaction_id Vector of transaction ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/banktransactions/#get-a-transaction
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' bank_transactions <- zb_get_bank_transactions(organizations$organization_id)
#' details <- zb_get_bank_transactions_details(
#'   organization_id = organizations$organization_id[1],
#'   transaction_id  = bank_transactions$transaction_id
#' )
#' }
zb_get_bank_transactions_details <- function(
    organization_id,
    transaction_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      transaction_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("banktransactions/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id = organization_id,
            transaction_id  = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
