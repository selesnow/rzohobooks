#' Get vendor payments details
#'
#' @param organization_id Organization id
#' @param vendor_payment_id Vector of vendor payment ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/vendorpayments/#get-a-vendor-payment
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' vendor_payments <- zb_get_vendor_payments(organizations$organization_id)
#' details <- zb_get_vendor_payments_details(
#'   organization_id   = organizations$organization_id[1],
#'   vendor_payment_id = vendor_payments$vendor_payment_id
#' )
#' }
zb_get_vendor_payments_details <- function(
    organization_id,
    vendor_payment_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      vendor_payment_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("vendorpayments/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id   = organization_id,
            vendor_payment_id = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
