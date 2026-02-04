#' Get credit notes
#'
#' @param organization_id Organizations ids
#' @param date_start Search credit notes by bill date.
#' @param date_end Search credit notes by bill date.
#' @param date_before Search credit notes by bill date.
#' @param date_after Search credit notes by bill date.
#' @param search_text Search credit notes using text search across multiple fields. Searches credit note number, customer name, and reference number. Max-length 100
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
    organization_id,
    date_start  = NULL,
    date_end    = NULL,
    date_before = NULL,
    date_after  = NULL,
    search_text = NULL
) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint = 'creditnotes',
                          organization_id = x,
                          date_start      = date_start,
                          date_end        = date_end,
                          date_before     = date_before,
                          date.after      = date_after,
                          search_text     = search_text
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)

}
