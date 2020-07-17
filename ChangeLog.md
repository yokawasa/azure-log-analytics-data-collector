## 0.4.0
* restclient retries request on the following status code - [issue #10](https://github.com/yokawasa/azure-log-analytics-data-collector/issues/10)
  * 429 - Too Many Requests
  * 500 - Internal Server Error
  * 503 -	Service Unavailable

## 0.3.0
* Enhance log type validation: check not only alpha but also numeric, underscore, and character length (may not exceed 100) - [issue #11](https://github.com/yokawasa/azure-log-analytics-data-collector/issues/11)

## 0.2.0
* Support setting the x-ms-AzureResourceId Header - [issue #8](https://github.com/yokawasa/azure-log-analytics-data-collector/issues/8)

## 0.1.6
* fix CVE-2020-8130 - [issue #7](https://github.com/yokawasa/azure-log-analytics-data-collector/issues/7)

## 0.1.5
* Add endpoint parameter with the default value for Azure public - [PR#5](https://github.com/yokawasa/azure-log-analytics-data-collector/pull/5)

## 0.1.4
* Add `set_proxy` method to client - [issue#3](https://github.com/yokawasa/azure-log-analytics-data-collector/issues/3)

## 0.1.2
* fixedup bug - [issue #1](https://github.com/yokawasa/azure-log-analytics-data-collector/issues/1)

## 0.1.1

* rm helper.rb and include helper functions in client.rb

## 0.1.0

* Inital Release
