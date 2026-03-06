#' Get bills details
#'
#' @param organization_id Organization id
#' @param bill_id Vector of bill ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/bills/#get-a-bill
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' bills <- zb_get_bills(organizations$organization_id)
#' details <- zb_get_bills_details(
#'   organization_id = organizations$organization_id[1],
#'   bill_id         = bills$bill_id
#' )
#' }
zb_get_bills_details <- function(
    organization_id,
    bill_id
) {

  suppressMessages({

    result <- map_dfr(
      bill_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("bills/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          mutate(
            organization_id = organization_id,
            bill_id         = id,
            due_by_days = as.character(due_by_days),
            due_in_days = as.character(due_in_days)
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
