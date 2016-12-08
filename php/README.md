# azure-log-analytics-data-collector PHP Client
Azure Log Analytics Data Collector API Client for PHP


## Test
Download composer.phar and install client libraries autoload file:
```
curl -s https://getcomposer.org/installer | php
php composer.phar install
```
Then move to test dir and configure the following variables in test.php
```
$customer_id = '<Customer ID aka WorkspaceID String>';
$shared_key =  '<Primary Key String>';
```
Finally run test.php
```
php test.php
```


## Change log

* [Changelog](ChangeLog.md)

## Links

* https://pypi.python.org/pypi/azure-log-analytics-data-collector-api
* [Azure Log Analytics Data Collecotr API](https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-data-collector-api)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yokawasa/azure-log-analytics-data-collector.
