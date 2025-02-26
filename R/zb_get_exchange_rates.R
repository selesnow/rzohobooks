#' Get currency exchange rates
#'
#' @details
#' See [api docs](https://www.zoho.com/books/api/v3/currency/#list-exchange-rates)
#'
#'
#' @param organization_id Organizations id, you can set only one id
#' @param currency_id Id of currency, use `zb_get_currencies()` to takes currency ids
#' @param from_date Returns the exchange rate details from the given date or from previous closest match in the absence of the exchange rate on the given date.
#' @param is_current_date To return the exchange rate only if available for current date.
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' cur <- zb_get_currencies(organizations$organization_id)
#' cur_id <- filter(cur, organization_id == organizations$organization_id[1])$currency_id
#' exc <- zb_get_exchange_rates(organization_id = '20103522465', currency_id = cur_id[11])
#' }
zb_get_exchange_rates <- function(
    organization_id,
    currency_id,
    from_date       = NULL,
    is_current_date = NULL
) {
  suppressMessages({
    result <- map_dfr(currency_id, \(cur) {
                          zb_make_request(
                            endpoint        = 'exchangerates',
                            add_path        = str_glue('settings/currencies/{cur}'),
                            organization_id = organization_id,
                            from_date       = from_date,
                            is_current_date = is_current_date
                          ) %>%
                            zb_parse()
                        }
                      )
  })

  cli::cli_alert_success('success')

  return(result)

}
