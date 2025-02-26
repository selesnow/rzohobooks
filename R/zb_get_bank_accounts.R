#' Get bank accounts
#'
#' @param organization_id Organizations ids
#'
#' @details
#' See [api docs](https://www.zoho.com/books/api/v3/bank-accounts/#overview)
#'
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' bank_accounts <- zb_get_bank_accounts(organizations$organization_id)
#' }
zb_get_bank_accounts <- function(
    organization_id
  ) {
  suppressMessages({
  result <- map_dfr(organization_id,
          \(x) {
            zb_make_request(
              endpoint = 'bankaccounts',
              organization_id = x
            ) %>%
            zb_parse() %>%
            mutate(organization_id = x)
          }
  )
  })

  cli::cli_alert_success('success')

  return(result)

}

