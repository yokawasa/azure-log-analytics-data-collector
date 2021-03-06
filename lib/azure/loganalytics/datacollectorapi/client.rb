require "azure/loganalytics/datacollectorapi/version"

module Azure
  module Loganalytics
    module Datacollectorapi

      API_VERSION = '2016-04-01'.freeze

      class Client

        DEFAUT_MAX_RETRIES = 3.freeze
        DEFAULT_RETRY_SLEEP_PERIOD = 5.freeze
        # API Data Limits
        # https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-collector-api#data-limits
        MAX_BODY_BYTE_SIZE = 31457280.freeze   # 30 MB

        def initialize (customer_id, shared_key, endpoint ='ods.opinsights.azure.com')
          require 'rest-client'
          require 'json'
          require 'openssl'
          require 'base64'
          require 'time'

          @customer_id = customer_id
          @shared_key = shared_key
          @endpoint = endpoint
          @default_azure_resource_id = ''

          @max_retries = DEFAUT_MAX_RETRIES
          @retry_sleep_period = DEFAULT_RETRY_SLEEP_PERIOD    
        end

        def post_data(log_type, json_records, record_timestamp ='', azure_resource_id ='' )
          raise ConfigError, 'no log_type' if log_type.empty?
          raise ConfigError, 'log_type must only contain alpha numeric and _, and not exceed 100 chars' if not is_valid_log_type(log_type)
          raise ConfigError, 'no json_records' if json_records.empty?

          body =  json_records.to_json
          body_size = body.bytesize
          raise "too large payload (#{body_size})! max post data size is #{MAX_BODY_BYTE_SIZE} bytes!" if body_size >= MAX_BODY_BYTE_SIZE

          uri = sprintf("https://%s.%s/api/logs?api-version=%s",
                        @customer_id, @endpoint, API_VERSION)
          date = rfc1123date()
          sig = signature(date, body.bytesize)

          headers = {
              'Content-Type' => 'application/json',
              'Authorization' => sig,
              'Log-Type' => log_type,
              'x-ms-date' => date,
              'x-ms-AzureResourceId' => azure_resource_id.empty? ? @default_azure_resource_id : azure_resource_id,
              'time-generated-field' => record_timestamp
          }

          retries = 0 
          begin
            res = RestClient.post( uri, body, headers)
            res
          rescue => e
            c = e.response.code.to_i
            if c == 429 || c == 500 || c==503
              if retries < @max_retries
                retries += 1
                sleep(@retry_sleep_period)
                retry 
              end
            end
            raise e
          end
        end

        def set_proxy(proxy='')
          RestClient.proxy = proxy.empty? ? ENV['http_proxy'] : proxy
        end
        
        def set_default_azure_resoruce_id(azure_resource_id)
          @default_azure_resource_id = azure_resource_id
        end
        
        def set_retres(max_retries, retry_sleep_period)
          @max_retries = max_retries
          @retry_sleep_period = retry_sleep_period
        end

        def self.is_success(res)
          return (res.code == 200) ? true : false
        end

        private

        def is_valid_log_type(s)
          return ( s.match(/^[a-zA-Z0-9_]+$/) && s.length <= 100 ) ? true : false
        end

        def rfc1123date()
          t = Time.now
          t.httpdate()
        end

        def signature(date, content_length)
          sigs = sprintf("POST\n%d\napplication/json\nx-ms-date:%s\n/api/logs",
                        content_length, date)
          utf8_sigs = sigs.encode('utf-8')
          decoded_shared_key = Base64.decode64(@shared_key)
          hmac_sha256_sigs = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), decoded_shared_key, utf8_sigs)
          encoded_hash = Base64.encode64(hmac_sha256_sigs)
          authorization = sprintf("SharedKey %s:%s", @customer_id,encoded_hash)
          authorization
        end

      end # end of class

    end
  end
end
