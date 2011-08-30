<?php
include 'settings.inc';
session_start();
$_SESSION['login'] = false;
header('Location: '.$base_url.'/login.php');
