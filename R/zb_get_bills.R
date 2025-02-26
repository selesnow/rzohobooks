#' Get list of bills
#'
#' @details
#' For more detail see [api docs](https://www.zoho.com/books/api/v3/bills/#list-bills)
#'
#'
#' @param organization_id Organizations id, you can set only one id
#' @param date_start Search bills by bill date.
#' @param date_end Search bills by bill date.
#' @param date_before Search bills by bill date.
#' @param date_after Search bills by bill date.
#' @param search_text Search bills by bill number or reference number or vendor name.
#' @param status Search bills by bill status. Allowed Values: paid, open, overdue, void and partially_paid. NULL if you need all bills.
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' bills <- zb_get_bills(
#'     organizations$organization_id,
#'     date_start = '2025-02-01',
#'     date_end = '2025-02-10'
#' )
#' }
zb_get_bills <- function(
    organization_id,
    date_start  = NULL,
    date_end    = NULL,
    date_before = NULL,
    date_after  = NULL,
    search_text = NULL,
    status      = c('paid', 'open', 'overdue', 'void and partially_paid')
) {

  status <- match.arg(status)

  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint        = 'bills',
                          organization_id = x,
                          date_start      = date_start,
                          date_end        = date_end,
                          date_before     = date_before,
                          date.after      = date_after,
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
