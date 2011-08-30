<?php

function Web($url)
{  
  return http_parse_message(http_get($url))->body;
}

class FilemanConnection 
{
  protected $access_code;
  protected $gtm_bridge = '';
  protected $valid = false;

  function __construct($access_code)
  {
    $this->access_code = $access_code;
    $this->gtm_bridge = 'http://localhost/cgi-bin/fileman.cgi';
  }

  function Connect()
  {
    $sid = session_id();
    $url = $this->gtm_bridge . '?session_id=' . $sid;
    $url = $url . '&access_code=' . $this->access_code;
    $url = $url . '&action=authenticate';
    
    $response = http_get($url, array('timeout'=>1), $httpinfo);
    $success = http_parse_message($response)->body;
    
    if ($success == 1) {
      $this->valid = true;
      return true;
    }
    else {
      $this->valid = false;
      return false;
    }
  }

  function Bridge()
  {
    return $this->gtm_bridge;
  }
  

  function Authenticated()
  {
    return $this->valid;
  }
 
}

class FileList 
{
  protected $connection;
  protected $files;

  function __construct($connection)
    {
      $this->connection = $connection;
      $this->connection->Connect();
      $url = $connection->Bridge() . '?action=file-numbers';
      $url = $url . '&instance=this';
      $code = Web($url);
      eval($code);
    }

  function DropdownBox($name, $id)
  {
    echo '<select name="' . $name . '" id="' . $id . '">';

    foreach($this->files as $key => $filename)
      {
	echo '<option value="' . $key . '">' . urldecode($filename) . '</option>';
      }

    echo '</select>';
  }
}

?>