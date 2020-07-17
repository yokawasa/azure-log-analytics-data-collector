# azure-log-analytics-data-collector Ruby Client

[Azure Log Analytics Data Collector API](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-collector-api) Client Libraries for Ruby. The repository was originally created for multiple programming languages, but it was refactored as a dedicated one for Ruby client. Python and PHP client libraries were moved to [azure-log-analytics-data-colloector-python](https://github.com/yokawasa/azure-log-analytics-data-collector-python) and [azure-log-analytics-data-colloector-php](https://github.com/yokawasa/azure-log-analytics-data-collector-php) respectively.


## Retry policy

The client internal leverage [rest-client] to send HTTP request to the API. The client library retries request using the rest-client on the following status code (which is [recommended action](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-collector-api)).
  * `429` - Too Many Requests
  * `500` - Internal Server Error
  * `503` -	Service Unavailable

By default, the client library retres for a total of `3` times, sleeping `5 sec` between retries. The number of retries and sleeping time between retries can be changed with `set_retries` in the client class.

```ruby
  def set_retries(max_retries, retry_sleep_period)
    @max_retries = max_retries
    @retry_sleep_period = retry_sleep_period
  end
```

## Installation
```bash
gem install azure-loganalytics-datacollector-api
```

## Sample code (Ruby Client)
### Sample1 - No time_generated_field option
```ruby
require "azure/loganalytics/datacollectorapi/client"

customer_id = '<Customer ID aka WorkspaceID String>'
shared_key = '<The primary or the secondary Connected Sources client authentication key>'
log_type = "MyCustomLog"

posting_records = []
record1= {
  :string => "MyText1",
  :boolean => true,
  :number => 100
}
record2= {
  :string => "MyText2",
  :boolean => false,
  :number => 200
}
posting_records.push(record1)
posting_records.push(record2)

client=Azure::Loganalytics::Datacollectorapi::Client::new( customer_id, shared_key)
res = client.post_data(log_type, posting_records)
puts res
puts "res code=#{res.code}"

if Azure::Loganalytics::Datacollectorapi::Client.is_success(res)
  puts "operation was succeeded!"
else
  puts "operation was failured!"
end
```

### Sample2 - With time_generated_field option
```ruby
require "azure/loganalytics/datacollectorapi/client"

customer_id = '<Customer ID aka WorkspaceID String>'
shared_key = '<The primary or the secondary Connected Sources client authentication key>'
log_type = "MyCustomLog"

posting_records = []
record1= {
  :string => "MyText1",
  :boolean => true,
  :number => 100,
  :timegen => "2017-11-23T11:13:35.576Z" # YYYY-MM-DDThh:mm:ssZ
}
record2= {
  :string => "MyText2",
  :boolean => false,
  :number => 200,
  :timegen => "2017-11-23T12:13:35.576Z" # YYYY-MM-DDThh:mm:ssZ
}
posting_records.push(record1)
posting_records.push(record2)

time_generated_field = "timegen"
client=Azure::Loganalytics::Datacollectorapi::Client::new( customer_id, shared_key)
res = client.post_data(log_type, posting_records, time_generated_field)
puts res
puts "res code=#{res.code}"

if Azure::Loganalytics::Datacollectorapi::Client.is_success(res)
  puts "operation was succeeded!"
else
  puts "operation was failured!"
end
```

### Sample3 - With time_generated_field and azure_resource_id option
Supported setting azure_resource_id option from version [0.2.0](https://github.com/yokawasa/azure-log-analytics-data-collector/releases/tag/v0.2.0)
```ruby
require "azure/loganalytics/datacollectorapi/client"

customer_id = '<Customer ID aka WorkspaceID String>'
shared_key = '<The primary or the secondary Connected Sources client authentication key>'
log_type = "MyCustomLog"

posting_records = []
record1= {
  :string => "MyText1",
  :boolean => true,
  :number => 100,
  :timegen => "2017-11-23T11:13:35.576Z" # YYYY-MM-DDThh:mm:ssZ
}
record2= {
  :string => "MyText2",
  :boolean => false,
  :number => 200,
  :timegen => "2017-11-23T12:13:35.576Z" # YYYY-MM-DDThh:mm:ssZ
}
posting_records.push(record1)
posting_records.push(record2)

time_generated_field = "timegen"

# Azure Resource ID
# [Azure Resource ID Format]
# /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
azure_resource_id ="/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/otherResourceGroup/providers/Microsoft.Storage/storageAccounts/examplestorage"

client=Azure::Loganalytics::Datacollectorapi::Client::new( customer_id, shared_key)
res = client.post_data(log_type, posting_records, time_generated_field, azure_resource_id)
puts res
puts "res code=#{res.code}"

if Azure::Loganalytics::Datacollectorapi::Client.is_success(res)
  puts "operation was succeeded!"
else
  puts "operation was failured!"
end
```

### Sample4 - use proxy to access the API
```ruby
require "azure/loganalytics/datacollectorapi/client"

...
client=Azure::Loganalytics::Datacollectorapi::Client::new( customer_id, shared_key)
# client.set_proxy() # ENV['http_proxy'] is set by default 
client.set_proxy(your_proxy)
res = client.post_data(log_type, posting_records, time_generated_field)
puts res
...
```


## Change log

* [Changelog](ChangeLog.md)

## Links

* https://rubygems.org/gems/azure-loganalytics-datacollector-api
* [Azure Log Analytics Data Collecotr API](https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-data-collector-api)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yokawasa/azure-log-analytics-data-collector. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
