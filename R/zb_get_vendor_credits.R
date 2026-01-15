#' Get List of Vendor Credits
#'
#' @param organization_id Organizations id, you can get list pf organization use `zb_get_organizations()`.
#' @param filter_by Filter vendor credits by status using predefined status values. Allowed values: `Status.All`, `Status.Open`, `Status.Draft`, `Status.Closed`, and `Status.Void`.
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' vendor_credits <- zb_get_vendor_credits(
#'     organizations$organization_id
#' )
#' }
zb_get_vendor_credits <- function(
  organization_id,
  filter_by = NULL
  ) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint        = 'vendorcredits',
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
