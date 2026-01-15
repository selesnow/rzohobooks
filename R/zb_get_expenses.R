#' Get List of All Expenses
#'
#' @param organization_id Organizations id, you can get list pf organization use `zb_get_organizations()`.
#' @param filter_by Filter expenses by status, allowed values:  `Status.All`, `Status.Billable`, `Status.Nonbillable`, `Status.Reimbursed`, `Status.Invoiced` `Status.Unbilled`
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' projects <- zb_get_expenses(
#'     organizations$organization_id
#' )
#' }
zb_get_expenses <- function(
  organization_id,
  filter_by = NULL
) {

  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        items <- zb_make_request(
                          endpoint        = 'expenses',
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
