#' Get items details
#'
#' @param organization_id Organization id
#' @param item_id Vector of item ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/items/#get-an-item
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' items <- zb_get_items(organizations$organization_id)
#' details <- zb_get_items_details(
#'   organization_id = organizations$organization_id[1],
#'   item_id         = items$item_id
#' )
#' }
zb_get_items_details <- function(
    organization_id,
    item_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      item_id,
      \(id) {

        items_details <- zb_make_request(
          endpoint = glue::glue("items/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id    = organization_id,
            item_id            = id,
            sales_rate         = as.character(sales_rate),
            initial_stock_rate = as.character(initial_stock_rate)
          ) %>%
          tidyr::unnest_wider(tax_information, names_sep = '_') %>%
          tidyr::unnest_wider(purchase_tax_information, names_sep = '_')

        if ('initial_stock' %in% names(items_details)) {
          items_details <- dplyr::mutate(items_details, initial_stock = as.character(initial_stock))
        }

        items_details

      }
    )

  })

  cli::cli_alert_success("success")

  result
}
