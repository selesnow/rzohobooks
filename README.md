
# rzohobooks

<!-- badges: start -->
<!-- badges: end -->

`rzohobooks` предназначен для загрузки данных из [Zoho Books API](https://www.zoho.com/books/api/v3/introduction/#organization-id).

## Установка

Установить пакет можно из [GitHub](https://github.com/):

``` r
# install.packages("pak")
pak::pak("selesnow/rzohobooks")
```

## Авторизация

Поскольку в пакете на данный момент нет функции для прохождения OAuth авторизации, для авторизации изначально необходимо создать 3 переменные среды:

* ZB_CLIENT_ID
* ZB_CLIENT_SECRET
* ZB_REDIRECT_URI

Далее вы можете получить access_token и закешировать его с помощью функции `zb_update_access_token()`.

Более подробно об авторизации можно почитать в [справке](https://www.zoho.com/books/api/v3/oauth/#overview).

### Хранение кеша учётных данных Zoho Books API необходимо обновлять каждый час, в связи с чем 

access_token необходимый для работы с Zoho Books API необходимо обновлять раз в час, поэтому авторизационный данные локально кешируются. У вас есть возможно управлять режимом кеширования с помощью переменной среды `ZB_AUTH_CACHE_MODE`.

Если передать в `ZB_AUTH_CACHE_MODE` значение `global`, то учётные данные для работы с API будут закешированы в общей для всех полльзователей локальной папке, это удобно при работе на сервере.

Если оставить переменную `ZB_AUTH_CACHE_MODE` пустой, или передать значенеи `user`, то данные будут кешироваться в папке конкретного пользователя, и другим пользователям машины будут недоступны.

## Фукции запроса данных

* `zb_get_organizations()` - Справочник организаций, [документация API](https://www.zoho.com/books/api/v3/introduction/#organization-id)
* `zb_get_contacts()` - Справочник контактов, [документация API](https://www.zoho.com/books/api/v3/contacts/#list-contacts)
* `zb_get_bank_accounts()` - Справочник банковских аккаунтов [документация API](https://www.zoho.com/books/api/v3/bank-accounts/#list-view-of-accounts)
* `zb_get_currencies()` - Список валют [документация API](https://www.zoho.com/books/api/v3/currency/#list-currencies)
* `zb_get_exchange_rates()` - Список валют [документация API](https://www.zoho.com/books/api/v3/currency/#list-exchange-rates)
* `zb_get_users()` - Список пользователей [документация API](https://www.zoho.com/books/api/v3/users/#list-users)
* `zb_get_taxes()` - Список налогов [документация API](https://www.zoho.com/books/api/v3/taxes/#list-taxes)
* `zb_get_zb_get_estimates()` - [документация API](https://www.zoho.com/books/api/v3/estimates/#list-estimates)
* `zb_get_invoices()` - Список инвойсов [документация API](https://www.zoho.com/books/api/v3/invoices/#list-invoices)
* `zb_get_customer_payments()` - Реестр клиентских оплат [документация API](https://www.zoho.com/books/api/v3/customer-payments/#list-customer-payments)
* `zb_get_bank_transactions()` - Банковские транзакции [документация API](https://www.zoho.com/books/api/v3/customer-payments/#list-customer-payments)
* `zb_get_bills()` - Реестр счетов [документация API](https://www.zoho.com/books/api/v3/bills/#list-bills)

## Author
Alexey Seleznev, Head of analytics dept. at [Netpeak](https://netpeak.us/)
<Br>Telegram Channel: [R4marketing](https://t.me/R4marketing)
<Br>email: selesnow@gmail.com
<Br>facebook: [facebook.com/selesnow](https://www.facebook.com/selesnow)
<Br>blog: [alexeyseleznev.wordpress.com](https://alexeyseleznev.wordpress.com/)

