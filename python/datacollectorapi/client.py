# -*- coding: utf-8 -*-
import requests
import datetime
import hashlib
import hmac
import base64
import simplejson as json

"""
This is Azure Log Analytics Data Collector API Client libraries

Data Collector API can be refered in the following document:
https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-data-collector-api
"""

__author__ = 'Yoichi Kawasaki'

### Global Defines
_LOG_ANALYTICS_DATA_COLLECTOR_API_VERSION = '2016-04-01'


class DataCollectorAPIClient:

    """
    Azure Log Analytics Data Collector API Client Class
    """

    def __init__(self, customer_id, shared_key): 
        self.customer_id = customer_id
        self.shared_key = shared_key

    # Build the API signature
    def __signature(self, date, content_length):
        sigs= "POST\n{}\napplication/json\nx-ms-date:{}\n/api/logs".format(
                            str(content_length),date)
        utf8_sigs = bytes(sigs).encode('utf-8')  
        decoded_shared_key = base64.b64decode(self.shared_key)
        hmac_sha256_sigs = hmac.new(
                decoded_shared_key, utf8_sigs,digestmod=hashlib.sha256).digest()
        encoded_hash = base64.b64encode(hmac_sha256_sigs)
        authorization = "SharedKey {}:{}".format(self.customer_id,encoded_hash)
        return authorization

    def __rfc1123date(self):
        return datetime.datetime.utcnow().strftime('%a, %d %b %Y %H:%M:%S GMT')

    # Build and send a request to the POST API
    def post_data(self, log_type, json_records, record_timestamp=''):
        # Check if string contains other than alpha characters
        if not log_type.isalpha():
            raise Exception(
                "ERROR: log_type supports only alpha characters: {}".format(log_type))

        body = json.dumps(json_records)
        rfc1123date = self.__rfc1123date()
        content_length = len(body)
        signature = self.__signature(rfc1123date, content_length)
        uri = "https://{}.ods.opinsights.azure.com/api/logs?api-version={}".format(
                    self.customer_id, _LOG_ANALYTICS_DATA_COLLECTOR_API_VERSION)

        """
        time-generated-field
        The name of a field in the data that contains the timestamp of the data item.
        If this isn’t specified, the default is the time that the message is ingested.
        The field format is ISO 8601 format YYYY-MM-DDThh:mm:ssZ
        """
        headers = {
            'content-type': 'application/json',
            'Authorization': signature,
            'Log-Type': log_type,
            'x-ms-date': rfc1123date,
            'time-generated-field': record_timestamp
        }
        return requests.post(uri,data=body, headers=headers)
