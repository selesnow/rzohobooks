#' Get List of Recurring Invoice
#'
#' @param organization_id Organizations id, you can get list pf organization use `zb_get_organizations()`.
#' @param filter_by Filter Recurring invoices by any status or payment expected date. Allowed Values: `Status.All`, `Status.Active`, `Status.Stopped`, `Status.Expired`.
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' recurring_invoice <- zb_get_recurring_invoice(
#'     organizations$organization_id
#' )
#' }
zb_get_recurring_invoice <- function(
  organization_id,
  filter_by = NULL
) {
  suppressMessages({
    result <- map_dfr(organization_id[1],
                      \(x) {
                        zb_make_request(
                          endpoint        = 'recurringinvoices',
                          organization_id = x,
                          filter_by       = filter_by
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)
}
