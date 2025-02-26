#' Get users list
#'
#' @details
#' See [api docs](https://www.zoho.com/books/api/v3/users/#list-users)
#'
#'
#' @param organization_id Organizations ids
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' users <- zb_get_users(organizations$organization_id)
#' }
zb_get_users <- function(
    organization_id
) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint = 'users',
                          organization_id = x
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)

}

