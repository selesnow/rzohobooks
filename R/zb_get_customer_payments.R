zb_get_customer_payments <- function(
  organization_id,
  date_start  = NULL,
  date_end    = NULL,
  date_before = NULL,
  date_after  = NULL,
  search_text = NULL,
  filter_by   = NULL
) {

  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint = 'customerpayments',
                          organization_id = x,
                          date_start  = date_start,
                          date_end    = date_end,
                          date_before = date_before,
                          date_after  = date_after,
                          search_text = search_text,
                          filter_by   = filter_by
                        ) %>%
                          zb_parse() %>%
                          mutate(organization_id = x)
                      }
    )
  })

  cli::cli_alert_success('success')

  return(result)

}
