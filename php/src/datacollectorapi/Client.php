<?php
/**
 * DataCollectorApiClient
 *
 * @author Yoichi Kawasaki
 */
namespace datacollectorapi;

class Client
{
    private $customer_id = null;
    private $shared_key = null;
    private $api_version = null;

    public function __construct($customer_id, $shared_key, $api_version='2016-04-01' )
    {
        $this->customer_id=$customer_id; 
        $this->shared_key=$shared_key; 
        $this->api_version=$api_version; 
    }

    public function post_data($log_type, $json_records=array(), $record_timestamp ='')
    {
        if (!$log_type or !$json_records)
        {
            throw new Exception("log_type and json_records must not be emmpty!");
        }
        if (!$this->is_alpha($log_type))
        {
            throw new Exception("log_type must be only alpha characters!");
        }
         
        $body = json_encode($json_records);
        $uri = sprintf("https://%s.ods.opinsights.azure.com/api/logs?api-version=%s",
                        $this->customer_id, $this->api_version);
        $date = $this->rfc1123date();
        $sig = $this->signature($date, strlen($body));

        $opts = array(
            'http' =>
                array(
                    'method'=>"POST",
                    'header'=>"Content-Type: application/json\r\n" .
                              "Authorization: " . $sig . "\r\n" .
                              "Log-Type: " . $log_type . "\r\n" .
                              "x-ms-date: " . $date . "\r\n" .
                              "time-generated-field: " . $record_timestamp . "\r\n",
                    'content' => $body
                )
            );

        $context = stream_context_create($opts);
        file_get_contents($uri, false, $context);
        return $this->parase_headers($http_response_header);
    }

    private function is_alpha($s)
    {
        return ctype_alpha($s);
    }
    
    private function rfc1123date()
    {
        return gmdate('D, d M Y H:i:s T', time());
    }

    private function str_convert( $source, $target_encoding )
    {
        $encoding = mb_detect_encoding( $source, "auto" );
        $target = mb_convert_encoding( $source, $target_encoding, $encoding);
        return $target;
    }

    private function parase_headers ($headers)
    {
        //this part of parase_headers code comes from:
        //http://php.net/manual/en/reserved.variables.httpresponseheader.php
        $head = array();
        foreach( $headers as $k=>$v )
        {
            $t = explode( ':', $v, 2 );
            if( isset( $t[1] ) )
                $head[ trim($t[0]) ] = trim( $t[1] );
            else
            {
                $head[] = $v;
                if( preg_match( "#HTTP/[0-9\.]+\s+([0-9]+)#",$v, $out ) )
                    $head['reponse_code'] = intval($out[1]);
            }
        }
        return $head;
    }

    protected function signature($date, $content_length)
    {
        $sigs = sprintf("POST\n%d\napplication/json\nx-ms-date:%s\n/api/logs",
                    $content_length, $date);
        $utf8_sigs = $this->str_convert($sigs, 'UTF-8');
        $decoded_shared_key = base64_decode($this->shared_key);
        $hmac_sha256_sigs = hash_hmac('sha256', $utf8_sigs, $decoded_shared_key, true);
        $encoded_hash = base64_encode($hmac_sha256_sigs);
        return sprintf("SharedKey %s:%s", $this->customer_id,$encoded_hash);
    }

    static function is_success($res)
    {
        return (is_array($res) and $res['reponse_code'] == 200) ? true : false;
    }

}

?>
