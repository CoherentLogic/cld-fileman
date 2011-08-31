<?php
require 'fm/fileman.inc';
session_start();

$fm = new FieldMetadata($_SESSION['connection'], $_GET['dd'], $_GET['field']);

echo "<pre>";
print_r($fm->General());
print_r($fm->SecurityAccess());
print_r($fm->Subfile());
print_r($fm->SetOfCodes());

echo "</pre>";
?>