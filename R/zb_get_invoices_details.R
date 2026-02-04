#' Get invoices details
#'
#' @param organization_id Organization id
#' @param invoice_id Vector of invoice ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/invoices/#get-an-invoice
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' invoices <- zb_get_invoices(organizations$organization_id)
#' details <- zb_get_invoices_details(
#'   organization_id = organizations$organization_id[1],
#'   invoice_id      = invoices$invoice_id
#' )
#' }
zb_get_invoices_details <- function(
    organization_id,
    invoice_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      invoice_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("invoices/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id = organization_id,
            invoice_id      = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
