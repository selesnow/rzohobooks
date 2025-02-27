#' List all estimates (Quotes)
#'
#' @details
#' For more details see [API docs](https://www.zoho.com/books/api/v3/estimates/#list-estimates)
#'
#'
#' @param organization_id Organizations ids
#' @param date_start Search estimates by estimate date.
#' @param date_end Search estimates by estimate date.
#' @param date_before Search estimates by estimate date.
#' @param date_after Search estimates by estimate date.
#' @param status Search estimates by status.Allowed Values `draft`, `sent`, `invoiced` , `accepted`, `declined` and `expired`.
#' @param search_text Search estimates by estimate number or reference or customer name.
#' @param filter_by Filter estimates by status.Allowed Values `Status.All`, `Status.Sent`, `Status.Draft`, `Status.Invoiced`, `Status.Accepted`, `Status.Declined` and `Status.Expired`.
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' estimates <- zb_get_estimates(
#'     organizations$organization_id,
#'     date_start = '2025-02-01',
#'     date_end  = '2025-02-10'
#' )
#' }
zb_get_estimates <- function(
    organization_id,
    date_start  = NULL,
    date_end    = NULL,
    date_before = NULL,
    date_after  = NULL,
    status      = NULL,
    search_text = NULL,
    filter_by   = NULL
) {

  if (!is.null(status)) {
    status <- match.arg(status, choices = c('sent', 'draft', 'invoiced', 'accepted', 'declined', 'expired'))
  }

  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint = 'estimates',
                          organization_id = x,
                          date_start  = date_start,
                          date_end    = date_end,
                          date_before = date_before,
                          date_after  = date_after,
                          status      = status,
                          search_text = search_text,
                          filter_by   = filter_by
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)

}
