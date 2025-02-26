#' Get list of invoices
#'
#' @param organization_id Organizations ids
#' @param date_start Search invoices by invoice date. Default date format is yyyy-mm-dd.
#' @param date_end Search invoices by invoice date. Default date format is yyyy-mm-dd.
#' @param date_before Search invoices by invoice date. Default date format is yyyy-mm-dd.
#' @param date_after Search invoices by invoice date. Default date format is yyyy-mm-dd.
#' @param due_date_start Search invoices by due date. Default date format is yyyy-mm-dd.
#' @param due_date_end Search invoices by due date. Default date format is yyyy-mm-dd.
#' @param due_date_before Search invoices by due date. Default date format is yyyy-mm-dd.
#' @param due_date_after Search invoices by due date. Default date format is yyyy-mm-dd.
#' @param status Search invoices by invoice status.Allowed Values: sent, draft, overdue, paid, void, unpaid, partially_paid and viewed
#' @param search_text Search invoices by invoice number or purchase order or customer name. Max-length [100]
#' @param filter_by Filter invoices by any status or payment expected date.Allowed Values: `Status.All`, `Status.Sent`, `Status.Draft`, `Status.OverDue`, `Status.Paid`, `Status.Void`, `Status.Unpaid`, `Status.PartiallyPaid`, `Status.Viewed` and `Date.PaymentExpectedDate`
#'
#' @details
#' For more details see [API docs](https://www.zoho.com/books/api/v3/invoices/#list-invoices)
#'
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' invoices <- zb_get_invoices(organizations$organization_id, date_start = '2025-02-01', date_end  = '2025-02-10')
#' }
zb_get_invoices <- function(
    organization_id,
    date_start      = NULL,
    date_end        = NULL,
    date_before     = NULL,
    date_after      = NULL,
    due_date_start  = NULL,
    due_date_end    = NULL,
    due_date_before = NULL,
    due_date_after  = NULL,
    status          = NULL,
    search_text     = NULL,
    filter_by       = NULL
) {

  if (!is.null(status)) {
    status <- match.arg(status, choices = c('sent', 'draft', 'overdue', 'paid', 'void', 'unpaid', 'partially_paid', 'viewed'))
  }

  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint = 'invoices',
                          organization_id = x,
                          date_start      = date_start,
                          date_end        = date_end,
                          date_before     = date_before,
                          date_after      = date_after,
                          due_date_start  = due_date_start,
                          due_date_end    = due_date_end,
                          due_date_before = due_date_before,
                          due_date_after  = due_date_after,
                          status          = status,
                          search_text     = search_text,
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
