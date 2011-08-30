<?php
require 'fm/fileman.inc';
include 'settings.inc';
session_start();
$_SESSION['connection'] = new FilemanConnection($_POST['access_code']);
$result = $_SESSION['connection']->Connect();
//print_r($_POST);
//print("result: ".$result);
if ($result == true) {
  $_SESSION['login'] = $result;
  header('Location: '.$base_url.'/');
 }
else {
  $_SESSION['login']=false;
  header('Location: '.$base_url.'/login.php?error=badcode');
 }
?>