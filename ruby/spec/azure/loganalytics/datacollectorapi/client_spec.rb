require "spec_helper"

describe Azure::Loganalytics::Datacollectorapi::Client do
  it "has a version number" do
    expect(Azure::Loganalytics::Datacollectorapi::VERSION).not_to be nil
  end

  #it "does something useful" do
  #  expect(false).to eq(true)
  #end

  it "posting data to datacollector api" do
    customer_id = '<Customer ID aka WorkspaceID String>'
    shared_key =  '<Primary Key String>'
    log_type = "ApacheAccessLog"

    json_records = []
    record1= {
      :Log_ID => "5cdad72f-c848-4df0-8aaa-ffe033e75d57",
      :date => "2016-12-03 09:44:32 JST",
      :processing_time => "372",
      :remote => "101.202.74.59",
      :user => "-",
      :method => "GET / HTTP/1.1",
      :status => "304",
      :size => "-",
      :referer => "-",
      :agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:27.0) Gecko/20100101 Firefox/27.0"
    }
    record2 ={
      :Log_ID => "7260iswx-8034-4cc3-uirtx-f068dd4cd659",
      :date => "2016-12-03 09:45:14 JST",
      :processing_time => "105",
      :remote => "201.78.74.59",
      :user => "-",
      :method => "GET /manager/html HTTP/1.1",
      :status =>"200",
      :size => "-",
      :referer => "-",
      :agent => "Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0"
    }
    json_records.push(record1)
    json_records.push(record2)

    client=Azure::Loganalytics::Datacollectorapi::Client::new( customer_id, shared_key)
    res = client.post_data(log_type, json_records)
    expect(Azure::Loganalytics::Datacollectorapi::Client.is_success(res)).to eq(true)
  end

end
