#' Get credit notes
#'
#' @param organization_id Organizations ids
#'
#' @details
#' See [api docs](https://www.zoho.com/books/api/v3/credit-notes/#list-all-credit-notes)
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' contacts <- zb_get_credit_notes(organizations$organization_id)
#' }
zb_get_credit_notes <- function(
    organization_id
) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint = 'creditnotes',
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
