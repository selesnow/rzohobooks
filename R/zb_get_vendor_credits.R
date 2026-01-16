#' Get List of Vendor Credits
#'
#' @param organization_id Organizations id, you can get list pf organization use `zb_get_organizations()`.
#' @param filter_by Filter vendor credits by status using predefined status values. Allowed values: `Status.All`, `Status.Open`, `Status.Draft`, `Status.Closed`, and `Status.Void`.
#' @param date_start Start date of period
#' @param date_end End date of period
#' @param date_before Date before
#' @param date_after Date after
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
  filter_by = NULL,
  date_start  = NULL,
  date_end    = NULL,
  date_before = NULL,
  date_after  = NULL
  ) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint        = 'vendorcredits',
                          organization_id = x,
                          filter_by       = filter_by,
                          date_start      = date_start,
                          date_end        = date_end,
                          date_before     = date_before,
                          date_after      = date_after
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)
}
