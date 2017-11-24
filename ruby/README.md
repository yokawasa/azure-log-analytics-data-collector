# azure-log-analytics-data-collector Ruby Client
Azure Log Analytics Data Collector API Ruby Client

## Installation
```
gem install azure-loganalytics-datacollector-api
```

## Sample code (Ruby Client)
### Sample1 - No time_generated_field option
```
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
```
require "azure/loganalytics/datacollectorapi/client"

customer_id = '<Customer ID aka WorkspaceID String>'
shared_key = '<The primary or the secondary Connected Sources client authentication key>'
log_type = "MyCustomLogXY"

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

