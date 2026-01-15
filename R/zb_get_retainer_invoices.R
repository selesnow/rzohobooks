#' Get List of Retainer Invoices
#'
#' @param organization_id Organizations id, you can get list pf organization use `zb_get_organizations()`.
#' @param filter_by Filter invoices by any status or payment expected date. Allowed Values: `Status.All`, `Status.Sent`, `Status.Draft`, `Status.OverDue`, `Status.Paid`, `Status.Void`, `Status.Unpaid`, `Status.PartiallyPaid`, `Status.Viewed` and `Date.PaymentExpectedDate`.
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' retainer_invoices <- zb_get_retainer_invoices(
#'     organizations$organization_id
#' )
#' }
zb_get_retainer_invoices <- function(
  organization_id,
  filter_by = NULL
) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint        = 'retainerinvoices',
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
