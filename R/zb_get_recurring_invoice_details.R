#' Get recurring invoice details
#'
#' @param organization_id Organization id
#' @param recurring_invoice_id Vector of recurring invoice ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/recurringinvoices/#get-a-recurring-invoice
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' recurring_invoices <- zb_get_recurring_invoice(organizations$organization_id)
#' details <- zb_get_recurring_invoice_details(
#'   organization_id      = organizations$organization_id[1],
#'   recurring_invoice_id = recurring_invoices$recurring_invoice_id
#' )
#' }
zb_get_recurring_invoice_details <- function(
    organization_id,
    recurring_invoice_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      recurring_invoice_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("recurringinvoices/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id      = organization_id,
            recurring_invoice_id = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
