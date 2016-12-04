#!/usr/bin/env python
# -*- coding: utf-8 -*-

from datacollectorapi import client
from datacollectorapi import helper

def main():
    # Put your customer id and shared key below. For these info, see also
    # https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-data-collector-api#sample-requests
    customer_id = '<Customer ID aka WorkspaceID String>'
    shared_key =  '<Primary Key String>'
    log_type = 'ApacheAccessLog'

    json_records = []
    json_records.append(
        {
            "Log_ID": "5cdad72f-c848-4df0-8aaa-ffe033e75d57",
            "date":"2016-12-03 09:44:32 JST",
            "processing_time":"372",
            "remote":"101.202.74.59",
            "user":"-",
            "method":"GET / HTTP/1.1",
            "status":"304",
            "size":"-",
            "referer":"-",
            "agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:27.0) Gecko/20100101 Firefox/27.0"
        })

    json_records.append(
        {
            "Log_ID": "7260iswx-8034-4cc3-uirtx-f068dd4cd659",
            "date":"2016-12-03 09:45:14 JST",
            "processing_time":"105",
            "remote":"201.78.74.59",
            "user":"-",
            "method":"GET /manager/html HTTP/1.1",
            "status":"200",
            "size":"-",
            "referer":"-",
            "agent":"Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0"
        })

    api = client.DataCollectorAPIClient(customer_id,shared_key)   
    response = api.post_data(log_type, json_records)
    if (helper.is_success(response.status_code)):
        print 'Succeeded in posting data to Data Collector API!!'
    else:
        print "Failure: Error code:{}".format(response.status_code)

if __name__ == '__main__':
    main()
