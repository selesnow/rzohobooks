#' Get List Vendor Payments
#'
#' @param organization_id Organizations id, you can get list pf organization use `zb_get_organizations()`.
#' @param filter_by Filter payments by mode. Allowed Values: `PaymentMode.All`, `PaymentMode.Check`, `PaymentMode.Cash`, `PaymentMode.BankTransfer`, `PaymentMode.Paypal`, `PaymentMode.CreditCard`, `PaymentMode.GoogleCheckout`, `PaymentMode.Credit`, `PaymentMode.Authorizenet`, `PaymentMode.BankRemittance`, `PaymentMode.Payflowpro` and `PaymentMode.Others`.
#'
#' @returns tibble
#' @export
#'
#' @examples
#' \dontrun{
#' organizations <- zb_get_organizations()
#' chart_of_accounts <- zb_get_vendor_payments(
#'     organizations$organization_id
#' )
#' }
zb_get_vendor_payments <- function(
  organization_id,
  filter_by = NULL
) {
  suppressMessages({
    result <- map_dfr(organization_id,
                      \(x) {
                        zb_make_request(
                          endpoint        = 'vendorpayments',
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
