#' Get Journal List
#'
#' @param organization_id Organizations id, you can get list pf organization use `zb_get_organizations()`.
#' @param filter_by Filter journals by journal date. Allowed Values: `JournalDate.All`, `JournalDate.Today`, `JournalDate.ThisWeek`, `JournalDate.ThisMonth`, `JournalDate.ThisQuarter` and `JournalDate.ThisYear`.
#' @param date_start Start date of period
#' @param date_end End date of period
#' @param date_before Date before
#' @param date_after Date after
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_journals()
#' projects <- zb_get_expenses(
#'     organizations$organization_id,
#'     date_end = '2025-12-01', date_end = '2025-12-15'
#' )
#' }
zb_get_journals <- function(
  organization_id,
  filter_by   = NULL,
  date_start  = NULL,
  date_end    = NULL,
  date_before = NULL,
  date_after  = NULL
) {

  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint        = 'journals',
                          organization_id = x,
                          filter_by       = filter_by,
                          date_start      = date_start,
                          date_end        = date_end,
                          date_before     = date_before,
                          date_after      = date_after
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)

}
