require "spec_helper"

describe Azure::Loganalytics::Datacollectorapi::Client do
  it "has a version number" do
    expect(Azure::Loganalytics::Datacollectorapi::VERSION).not_to be nil
  end

  customer_id = '<Customer ID aka WorkspaceID String>'
  shared_key =  '<Primary Key String>'
  log_type = "MyCustomLog"

  it "log type validation" do
    json_records = []
    dummy= {
      :string => "dummy title",
      :number => 10
    }
    valid_log_type = "abcedefghijklmnopqrstuvwxyz1234567890_"
    invalid_log_type1 = "*-|[]//"
    invalid_log_type2 = "abcde__xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    json_records.push(dummy)
    client=Azure::Loganalytics::Datacollectorapi::Client::new( customer_id, shared_key)

    res = client.post_data(valid_log_type, json_records)
    expect(Azure::Loganalytics::Datacollectorapi::Client.is_success(res)).to eq(true)

    expect{
      client.post_data(invalid_log_type1, json_records)
    }.to raise_error(Exception)

    expect{
      client.post_data(invalid_log_type2, json_records)
    }.to raise_error(Exception)

  end

  it "posting data to datacollector api" do
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

  it "posting data to datacollector api with time-generated-field" do
    json_records = []
    record1= {
      :string => "MyText1",
      :boolean => true,
      :number => 100,
      :timegen => "2020-05-05T11:13:35.576Z" # YYYY-MM-DDThh:mm:ssZ
    }
    record2= {
      :string => "MyText2",
      :boolean => false,
      :number => 200,
      :timegen => "2020-05-05T12:13:35.576Z" # YYYY-MM-DDThh:mm:ssZ
    }
    json_records.push(record1)
    json_records.push(record2)

    time_generated_field = "timegen"
    client=Azure::Loganalytics::Datacollectorapi::Client::new( customer_id, shared_key)
    res = client.post_data(log_type, json_records, time_generated_field)
    expect(Azure::Loganalytics::Datacollectorapi::Client.is_success(res)).to eq(true)
  end

  it "posting data to datacollector api with azure-resource-id" do
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

    time_generated_field = ""
    # Azure Resource ID
    # https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-functions-resource#resourceid
    # /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
    azure_resource_id ="/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/otherResourceGroup/providers/Microsoft.Storage/storageAccounts/examplestorage"

    client=Azure::Loganalytics::Datacollectorapi::Client::new( customer_id, shared_key)
    res = client.post_data(log_type, json_records, time_generated_field, azure_resource_id)
    expect(Azure::Loganalytics::Datacollectorapi::Client.is_success(res)).to eq(true)
  end

end
