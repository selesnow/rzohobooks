#' Get retainer invoices details
#'
#' @param organization_id Organization id
#' @param retainer_invoice_id Vector of retainer invoice ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/retainerinvoices/#get-a-retainer-invoice
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' retainer_invoices <- zb_get_retainer_invoices(organizations$organization_id)
#' details <- zb_get_retainer_invoices_details(
#'   organization_id     = organizations$organization_id[1],
#'   retainer_invoice_id = retainer_invoices$retainer_invoice_id
#' )
#' }
zb_get_retainer_invoices_details <- function(
    organization_id,
    retainer_invoice_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      retainer_invoice_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("retainerinvoices/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id     = organization_id,
            retainer_invoice_id = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
