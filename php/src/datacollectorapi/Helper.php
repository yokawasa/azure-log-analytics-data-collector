<?php
/**
 * Helper
 *
 * @author Yoichi Kawasaki
 */
namespace datacollectorapi;

function is_success($res)
{
    return (is_array($res) and $res['reponse_code'] == 202) ? true : false;
}

?>
