<?php
$resp = http_get("http://localhost/cgi-bin/fileman.cgi?dd=200&ien=65&action=get-json-record&format=names", array("timeout"=>1), $info);
print(http_parse_message($resp)->body);
?>