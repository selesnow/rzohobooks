#' Get vendor credits details
#'
#' @param organization_id Organization id
#' @param vendor_credit_id Vector of vendor credit ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/vendorcredits/#get-a-vendor-credit
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' vendor_credits <- zb_get_vendor_credits(organizations$organization_id)
#' details <- zb_get_vendor_credits_details(
#'   organization_id = organizations$organization_id[1],
#'   vendor_credit_id = vendor_credits$vendor_credit_id
#' )
#' }
zb_get_vendor_credits_details <- function(
    organization_id,
    vendor_credit_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      vendor_credit_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("vendorcredits/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id  = organization_id,
            vendor_credit_id = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
