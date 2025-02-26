#' Get list of bank transactions
#'
#' @param organization_id Organizations ids
#' @param date_start Start date, to provide a range within which the transaction date exist
#' @param date_end End date, to provide a range within which the transaction date exist
#' @param search_text Search Transactions by contact name or description
#' @param status Transaction status wise list view - All, uncategorized, manually_added, matched, excluded, categorized
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' bank_transactions <- zb_get_bank_transactions(
#'     organizations$organization_id,
#'     date_start = '2025-02-01',
#'     date_end = '2025-02-10'
#' )
#' }
zb_get_bank_transactions <- function(
    organization_id,
    date_start  = NULL,
    date_end    = NULL,
    search_text = NULL,
    status      = c('All', 'uncategorized', 'manually_added', 'matched', 'excluded', 'categorized')
) {

  status <- match.arg(status)

  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint        = 'banktransactions',
                          organization_id = x,
                          date_start      = date_start,
                          date_end        = date_end,
                          search_text     = search_text,
                          status          = status
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)

}
