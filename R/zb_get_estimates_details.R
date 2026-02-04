#' Get estimates details
#'
#' @param organization_id Organization id
#' @param estimate_id Vector of estimate ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/estimates/#get-an-estimate
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' estimates <- zb_get_estimates(organizations$organization_id)
#' details <- zb_get_estimates_details(
#'   organization_id = organizations$organization_id[1],
#'   estimate_id     = estimates$estimate_id
#' )
#' }
zb_get_estimates_details <- function(
    organization_id,
    estimate_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      estimate_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("estimates/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id = organization_id,
            estimate_id     = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
