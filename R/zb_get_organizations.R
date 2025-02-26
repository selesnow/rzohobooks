#' Get list of organizations
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' }
zb_get_organizations <- function() {

  result <- zb_make_request(endpoint = 'organizations') %>%
            zb_parse()

  return(result)

}
