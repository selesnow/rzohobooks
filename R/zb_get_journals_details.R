#' Get journals details
#'
#' @param organization_id Organization id
#' @param journal_id Vector of journal ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/journals/#get-a-journal
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' journals <- zb_get_journals(organizations$organization_id)
#' details <- zb_get_journals_details(
#'   organization_id = organizations$organization_id[1],
#'   journal_id      = journals$journal_id
#' )
#' }
zb_get_journals_details <- function(
    organization_id,
    journal_id
) {

  suppressMessages({

    result <- purrr::map_dfr(
      journal_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("journals/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          dplyr::mutate(
            organization_id = organization_id,
            journal_id      = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
