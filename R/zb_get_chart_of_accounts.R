#' Get List Chart of Accounts
#'
#' @param organization_id Organizations id, you can get list pf organization use `zb_get_organizations()`.
#' @param filter_by Filter accounts based on its account type and status. Allowed Values: `AccountType.All`, `AccountType.Active`, `AccountType.Inactive`, `AccountType.Asset`, `AccountType.Liability`, `AccountType.Equity`, `AccountType.Income` and `AccountType.Expense`.
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' chart_of_accounts <- zb_get_chart_of_accounts(
#'     organizations$organization_id
#' )
#' }
zb_get_chart_of_accounts <- function(
  organization_id,
  filter_by = NULL
) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        chartofaccounts <- zb_make_request(
                          endpoint        = 'chartofaccounts',
                          organization_id = x,
                          filter_by       = filter_by
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                        if (is.list(chartofaccounts$child_count)) chartofaccounts$child_count <- chartofaccounts$child_count %>% as.character()
                        chartofaccounts
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)
}
