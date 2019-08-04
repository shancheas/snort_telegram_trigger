<?php
$chat_id="chat_id";
$token="token_anda";

$signature = $argv[1];
$timestamp = $argv[2];
$ip_src = baseLong2IP($argv[3]);
$ip_dst = baseLong2IP($argv[4]);
$ip_proto = get_protocol($argv[5]);

$caption = "[$signature] Serangan dari $ip_src pada $ip_dst menggunakan protocol $ip_proto pada $timestamp";
exec("curl -s -F chat_id=$chat_id -F text=\"$caption\" https://api.telegram.org/bot$token/sendMessage");

function get_protocol($proto) 
{
    switch($proto) {
        case 1:
            return "ICMP";
        case 6:
            return "TCP";
        case 17:
            return "UDP";
        case 255:
            return "RawIP";
        default:
            return "";        
    }
}

function baseLong2IP($long_IP)
{
   $tmp_IP = $long_IP;
   if ( $long_IP > 2147483647 )
   {
      $tmp_IP = 4294967296 -  $tmp_IP;
      $tmp_IP = $tmp_IP * (-1); 
   }

   $tmp_IP = long2ip($tmp_IP);
   return $tmp_IP;
}