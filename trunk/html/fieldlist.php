<?php 
require 'fm/fileman.inc';
session_start();

$fl = new Fields($_SESSION['connection'], $_GET['dd']);

echo '<table width="265" cellspacing="2" cellpadding="2">';
foreach($fl->Fields() as $fieldnumber => $fieldname)
{
  echo '<tr><td width="10%">';
  echo '<a href="##" onclick="LoadFile(\'' . $_GET['dd'] . '\', \'' . $fieldnumber . '\');">[' . $fieldnumber . ']</a></td>';
  echo '<td width="90%"><a href="##" onclick="LoadFile(\'' . $_GET['dd'] . '\', \'' . $fieldnumber . '\');">' . $fieldname . '</a>';
  
  echo '</td></tr>';

}
echo "</table>";


?>