#' Get currencies
#'
#' @param organization_id Organizations ids
#'
#' @details
#' See [api docs](https://www.zoho.com/books/api/v3/currency/#list-currencies)
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' currencies <- zb_get_currencies(organizations$organization_id)
#' }
zb_get_currencies <- function(
    organization_id
) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint = 'currencies',
                          add_path = 'settings',
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
