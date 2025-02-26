# A matching list, used only in cases where the endpoint name
# does not match the name of the desired element in the response.
endpoints <- list(
  'exchangerates'  = 'exchange_rates'
)

# Main function to send request
zb_make_request <- function(
    endpoint,
    add_path = '',
    ...
  ) {

  token <- zb_access_token()

  result <- list()

  resp <- request(token$api_domain) %>%
            req_url_path_append('books/v3/') %>%
            req_url_path_append(add_path) %>%
            req_url_path_append(endpoint) %>%
            req_url_query(organization_id=organizations$organization_id[3], per_page = 500, .multi = 'comma') %>%
            req_headers(
              Authorization = str_glue('Zoho-oauthtoken {token$access_token}')
            ) %>%
            req_error(body = zb_error) %>%
            req_retry(is_transient = \(resp) resp_status(resp) %in% c(429, 500)) %>%
            req_perform() %>%
            resp_body_json()

  result <- append(result, resp[[coalesce(endpoints[[endpoint]], endpoint)]])

  if ('page_context' %in% names(resp) & isTRUE(resp$page_context$has_more_page)) {

    page_number <- 2

    while (resp$page_context$has_more_page) {

      resp <- request(token$api_domain) %>%
              req_url_path_append('books/v3/') %>%
              req_url_path_append(add_path) %>%
              req_url_path_append(endpoint) %>%
              req_url_query(..., page = page_number, per_page = 500, .multi = 'comma') %>%
              req_headers(
                Authorization = str_glue('Zoho-oauthtoken {token$access_token}')
              ) %>%
              req_error(body = zb_error) %>%
              req_retry(is_transient = \(resp) resp_status(resp) %in% c(429, 500)) %>%
              req_perform() %>%
              resp_body_json()

      result <- append(result, resp[[coalesce(endpoints[[endpoint]], endpoint)]])

      page_number <- page_number + 1

    }

  }

  cli::cli_alert_success(resp$message)
  return(result)

}

# Get error message
zb_error <- function(resp) {
  resp <- resp_body_json(resp)
  cli::cli_alert_danger('Error!\nCode: {resp$code}\nMessage: {resp$message}')
  invisible()
}

# Main function for parsing response
zb_parse <- function(result) {
  result <- tibble(result = result) %>%
            unnest_wider(result)
  return(result)
}
