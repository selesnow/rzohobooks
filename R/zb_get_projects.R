#' Get List of All Projects
#'
#' @param organization_id Organizations id, you can set only one id
#' @param filter_by Filter projects by status, allowed values: `Status.All`, `Status.Active` and `Status.Inactive`
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' projects <- zb_get_projects(
#'     organizations$organization_id
#' )
#' }
zb_get_projects <- function(
  organization_id,
  filter_by = NULL
) {

  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        items <- zb_make_request(
                          endpoint        = 'projects',
                          organization_id = x,
                          filter_by       = filter_by
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)

}
