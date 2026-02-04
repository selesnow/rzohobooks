#' Get customer payments details
#'
#' @param organization_id Organization id
#' @param payment_id Vector of customer payment ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/customerpayments/#get-a-customer-payment
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' payments <- zb_get_customer_payments(organizations$organization_id)
#' details <- zb_get_customer_payments_details(
#'   organization_id = organizations$organization_id[1],
#'   payment_id      = payments$payment_id
#' )
#' }
zb_get_customer_payments_details <- function(
    organization_id,
    payment_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      payment_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("customerpayments/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id = organization_id,
            payment_id      = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
