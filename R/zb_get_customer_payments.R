#' Get Payments Received
#'
#' @details
#' For more infomation see [api docs](https://www.zoho.com/books/api/v3/customer-payments/#list-customer-payments)
#'
#'
#' @param organization_id Organizations ids
#' @param date_start Search payments by estimate date.
#' @param date_end Search payments by estimate date.
#' @param date_before Search payments by estimate date.
#' @param date_after Search payments by estimate date.
#' @param search_text Search payments by reference number or customer name or payment description.
#' @param filter_by Filter payments by mode.Allowed Values: PaymentMode.All, PaymentMode.Check, PaymentMode.Cash, PaymentMode.BankTransfer, PaymentMode.Paypal, PaymentMode.CreditCard, PaymentMode.GoogleCheckout, PaymentMode.Credit, PaymentMode.Authorizenet, PaymentMode.BankRemittance, PaymentMode.Payflowpro, PaymentMode.Stripe, PaymentMode.TwoCheckout, PaymentMode.Braintree and PaymentMode.Others
#'
#' @returns tibble
#' @export
#'
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
