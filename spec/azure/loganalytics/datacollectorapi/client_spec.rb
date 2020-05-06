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
    log_type = "MyCustomLog"

    json_records = []
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
    json_records.push(record1)
    json_records.push(record2)

    client=Azure::Loganalytics::Datacollectorapi::Client::new( customer_id, shared_key)
    res = client.post_data(log_type, json_records)
    expect(Azure::Loganalytics::Datacollectorapi::Client.is_success(res)).to eq(true)
  end

end
