# azure-log-analytics-data-collector Ruby Client
Azure Log Analytics Data Collector API Ruby Client

## Installation
```
gem install azure-loganalytics-datacollector-api
```

## Sample code (Ruby Client)

```
require "azure/loganalytics/datacollectorapi/client"

posting_records = []
record1= {
  :Log_ID => "aaaa4-c848-4df0-8aaa-ffe033e75d57",
  :date => "2017-04-21 09:44:32 JST",
  :processing_time => "372",
  :remote => "101.202.74.59",
  :method => "GET / HTTP/1.1",
  :status => "304",
  :referer => "-",
  :agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:27.0) Gecko/20100101 Firefox/27.0",
  :timegen => "2017-04-21T11:46:43Z" # YYYY-MM-DDThh:mm:ssZ ->  OK
}
record2 ={
  :Log_ID => "bbbb4-8034-4cc3-uirtx-f068dd4cd659",
  :date => "2017-04-21 09:45:14 JST",
  :processing_time => "105",
  :remote => "201.78.74.59",
  :user => "-",
  :method => "GET /manager/html HTTP/1.1",
  :status =>"200",
  :size => "-",
  :referer => "-",
  :agent => "Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0",
  :timegen => "2017-04-21T12:13:35.576Z" # YYYY-MM-DDThh:mm:ssZ  -> OK
}

posting_records.push(record1)
posting_records.push(record2)

time_generated_field = "timegen"
client=DataCollectionAPIClient::new( customer_id, shared_key)
res = client.post_data(log_type, posting_records,time_generated_field)
puts res
puts "res code=#{res.code}"

if DataCollectionAPIClient::is_success(res)
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

