# Before work you have to create next system variables:
# - ZB_CLIENT_ID
# - ZB_CLIENT_SECRET
# - ZB_REDIRECT_URI

zb_client_id <- function() {
  Sys.getenv('ZB_CLIENT_ID')
}

zb_client_secret <- function() {
  Sys.getenv('ZB_CLIENT_SECRET')
}

zb_redirect_uri <- function() {
  Sys.getenv('ZB_REDIRECT_URI')
}

zb_token_path <- function(
  client_id     = zb_client_id()
) {

  if (! dir.exists(tools::R_user_dir('rzohobooks', 'cache'))) {
    dir.create(tools::R_user_dir('rzohobooks', 'cache'))
  }

  str_glue('{tools::R_user_dir("rzohobooks", "cache")}/zb-token-{client_id}.rds')

}

zb_save_access_token <- function(token) {
  saveRDS(object = token, file = zb_token_path())
}

zb_access_token <- function(
  client_id     = zb_client_id()
) {

  token <- readRDS(zb_token_path())

  if (token$expires_at  - 600 <= Sys.time()) {
    token <- zb_update_access_token(zb_token = token)
  }

  return(token)

  invisible()
}

zb_update_access_token <- function(
    client_id     = zb_client_id(),
    client_secret = zb_client_secret(),
    redirect_uri  = zb_redirect_uri(),
    zb_token      = zb_access_token()
) {

  create_time <- Sys.time()

  token <- request(str_glue('https://accounts.zoho.{urltools::suffix_extract(zb_token$api_domain)$suffix}/oauth/v2/token')) %>%
    req_method('POST') %>%
    req_url_query(
      refresh_token = zb_token$refresh_token,
      client_id     = client_id,
      client_secret = client_secret,
      redirect_uri  = redirect_uri,
      grant_type    = 'refresh_token'
    ) %>%
    req_perform() %>%
    resp_body_json() %>%
    append(list(
      create_at     = create_time,
      expires_at    = create_time + .$expires_in,
      refresh_token = zb_token$refresh_token
    ))

  class(token)        <- 'ZohoBooksOAuthToken'

  zb_save_access_token(token)

  cli::cli_alert_success('Zoho books access token was update successful!')

  return(token)

  invisible()

}
