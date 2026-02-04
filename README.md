
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
* `zb_get_bills_details()` - Справочник товаров и услуг (items), используемых в инвойсах, эстимейтах и других финансовых документах,  
  [документация API](https://www.zoho.com/books/api/v3/items/#list-items)
* `zb_get_items()` - Справочник товаров и услуг (items), используемых в инвойсах, эстимейтах и других финансовых документах, [документация API](https://www.zoho.com/books/api/v3/items/#list-items)
* `zb_get_projects()` - Список проектов организации с привязкой к клиентам, статусами и настройками биллинга, [документация API](https://www.zoho.com/books/api/v3/projects/#list-projects)
* `zb_get_expenses()` - Реестр расходов компании с детализацией по категориям, проектам, налогам и способам оплаты, [документация API](https://www.zoho.com/books/api/v3/expenses/#list-expenses)
* `zb_get_journals()` - Журнальные проводки (manual journals), включая дебетовые и кредитные операции по счетам, [документация API](https://www.zoho.com/books/api/v3/journals/#overview)
* `zb_get_chart_of_accounts()` - План счетов организации с типами счетов, иерархией и статусом активности, [документация API](https://www.zoho.com/books/api/v3/chart-of-accounts/#list-chart-of-accounts)
* `zb_get_payments_made()` - Реестр оплат поставщикам (vendor payments), включая связанные счета и способы оплаты, [документация API](https://www.zoho.com/books/api/v3/vendor-payments/#list-vendor-payments)
* `zb_get_vendor_credits()` - Список кредит-нот от поставщиков (vendor credits), используемых для уменьшения обязательств, [документация API](https://www.zoho.com/books/api/v3/vendor-credits/#list-vendor-credits)
* `zb_get_retainer_invoices()` - Реестр ретейнер-инвойсов (предоплат) от клиентов, [документация API](https://www.zoho.com/books/api/v3/retainer-invoices/#list-a-retainer-invoices)
* `zb_get_recurring_invoices()` - Список рекуррентных (повторяющихся) инвойсов с настройками периодичности и статусами, [документация API](https://www.zoho.com/books/api/v3/recurring-invoices/#list-all-recurring-invoice)
* `zb_get_credit_notes()` - Реестр кредит-нот (credit notes), выписанных клиентам, с базовой информацией по документу: идентификаторы, номера, даты, статусы, суммы и ссылки на связанные инвойсы (без детальной информации по аккаунтам и строкам), [документация API](https://www.zoho.com/books/api/v3/credit-notes/#list-all-credit-notes)
* `zb_get_credit_notes_details()` - Детализированная информация по кредит-нотам клиентов, включая строки корректировок, счета учёта (`account_id`), налоги и связи с инвойсами,  
  [документация API](https://www.zoho.com/books/api/v3/credit-notes/#get-a-credit-note)

## Author
Alexey Seleznev, Head of analytics dept. at [Netpeak](https://netpeak.us/)
<Br>Telegram Channel: [R4marketing](https://t.me/R4marketing)
<Br>email: selesnow@gmail.com
<Br>facebook: [facebook.com/selesnow](https://www.facebook.com/selesnow)
<Br>blog: [alexeyseleznev.wordpress.com](https://alexeyseleznev.wordpress.com/)

