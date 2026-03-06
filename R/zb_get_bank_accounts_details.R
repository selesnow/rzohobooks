#' Get bank accounts details
#'
#' @param organization_id Organization id
#' @param account_id Vector of account ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/bankaccounts/#get-a-bank-account
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' bank_accounts <- zb_get_bank_accounts(organizations$organization_id)
#' details <- zb_get_bank_accounts_details(
#'   organization_id = organizations$organization_id[1],
#'   account_id      = bank_accounts$account_id
#' )
#' }
zb_get_bank_accounts_details <- function(
    organization_id,
    account_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      account_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("bankaccounts/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id = organization_id,
            account_id      = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
