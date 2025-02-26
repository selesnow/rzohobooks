#' Get list of taxes
#'
#' @param organization_id Organizations ids
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' taxes <- zb_get_taxes(organizations$organization_id)
#' }
zb_get_taxes <- function(
    organization_id
) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint = 'taxes',
                          add_path = 'settings',
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
