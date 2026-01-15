#' Get List of All Items
#'
#' @param organization_id Organizations id, you can set only one id
#' @param filter_by Filter items by status, allowed values: `Status.All`, `Status.Active` and `Status.Inactive`
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' items <- zb_get_items(
#'     organizations$organization_id
#' )
#' }
zb_get_items <- function(
  organization_id,
  filter_by = NULL
) {

  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        items <- zb_make_request(
                          endpoint        = 'items',
                          organization_id = x,
                          filter_by       = filter_by
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                        if (is.list(items$weight)) items$weight <- unlist(items$weight)
                        items
                      }
    )
  })

}
