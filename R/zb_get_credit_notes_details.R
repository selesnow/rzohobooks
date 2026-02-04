#' Get credit notes details
#'
#' @param organization_id Organization id
#' @param creditnote_id Vector of credit note ids
#'
#' @details
#' Uses detail endpoint:
#' https://www.zoho.com/books/api/v3/credit-notes/#get-a-credit-note
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' notes <- zb_get_credit_notes(organizations$organization_id)
#' details <- zb_get_credit_notes_details(
#'   organization_id = organizations$organization_id[1],
#'   creditnote_id   = notes$creditnote_id
#' )
#' }
zb_get_credit_notes_details <- function(
    organization_id,
    creditnote_id
) {

  suppressMessages({

    result <- map_dfr(
      creditnote_id,
      \(id) {

        zb_make_request(
          endpoint = glue::glue("creditnotes/{id}"),
          organization_id = organization_id
        ) %>%
          list() %>%
          zb_parse() %>%
          mutate(
            organization_id = organization_id,
            creditnote_id   = id
          )
      }
    )

  })

  cli::cli_alert_success("success")

  result
}
