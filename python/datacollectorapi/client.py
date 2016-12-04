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
        sigstr= "POST\n{}\napplication/json\nx-ms-date:{}\n/api/logs".format(
                            str(content_length),date)
        byte_seq_utf8_signstr = bytes(sigstr).encode('utf-8')  
        decoded_shared_key = base64.b64decode(self.shared_key)
        hmac_sha256_sigstr = hmac.new(
                decoded_shared_key, byte_seq_utf8_signstr,digestmod=hashlib.sha256).digest()
        encoded_hash = base64.b64encode(hmac_sha256_sigstr)
        authorization = "SharedKey {}:{}".format(self.customer_id,encoded_hash)
        return authorization

    # Build and send a request to the POST API
    def post_data(self, log_type, json_records):
        body = json.dumps(json_records)
        rfc1123date = datetime.datetime.utcnow().strftime('%a, %d %b %Y %H:%M:%S GMT')
        content_length = len(body)
        signature = self.__signature(rfc1123date, content_length)
        uri = "https://{}.ods.opinsights.azure.com/api/logs?api-version={}".format(
                    self.customer_id, _LOG_ANALYTICS_DATA_COLLECTOR_API_VERSION)
        headers = {
            'content-type': 'application/json',
            'Authorization': signature,
            'Log-Type': log_type,
            'x-ms-date': rfc1123date
        }
        return requests.post(uri,data=body, headers=headers)
