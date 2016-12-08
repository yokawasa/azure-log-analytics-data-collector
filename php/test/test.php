<?php

require_once __DIR__ . "/../vendor/autoload.php";

use datacollectorapi\Client;

$customer_id = '<Customer ID aka WorkspaceID String>';
$shared_key =  '<Primary Key String>';

$client = new datacollectorapi\Client($customer_id, $shared_key);

$log_type = "ApacheAccessLogYY";

$json_records = array();
$record1= array( 
  "Log_ID" => "5cdad72f-c848-4df0-8aaa-ffe033e75d57",
  "date" => "2016-12-03 09:44:32 JST",
  "processing_time" => "372",
  "remote" => "101.202.74.59",
  "user" => "-",
  "method" => "GET / HTTP/1.1",
  "status" => "304",
  "size" => "-",
  "referer" => "-",
  "agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:27.0) Gecko/20100101 Firefox/27.0"
);
$record2 = array(
  "Log_ID" => "7260iswx-8034-4cc3-uirtx-f068dd4cd659",
  "date" => "2016-12-03 09:45:14 JST",
  "processing_time" => "105",
  "remote" => "201.78.74.59",
  "user" => "-",
  "method" => "GET /manager/html HTTP/1.1",
  "status" =>"200",
  "size" => "-",
  "referer" => "-",
  "agent" => "Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0"
);
array_push($json_records, $record1);
array_push($json_records, $record2);

$response =  $client->post_data($log_type, $json_records);
var_dump($response);

if (!datacollectorapi\Client::is_success($response)) 
{
    echo "Problem reading data\n";
} else {
    echo "Success!!\n";
}

?>
