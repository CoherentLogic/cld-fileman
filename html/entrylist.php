<?php 
require 'fm/fileman.inc';
session_start();

$fl = new EntryList($_SESSION['connection'], $_GET['dd']);

echo '<table width="265" cellspacing="2" cellpadding="2">';
foreach($fl->Entries() as $ien => $entryname)
{
  echo '<tr><td width="10%">';
  echo '<a href="##" onclick="LoadEntry(\'' . $_GET['dd'] . '\', \'' . $ien . '\');">[' . $ien . ']</a></td>';
  echo '<td width="90%"><a href="##" onclick="LoadEntry(\'' . $_GET['dd'] . '\', \'' . $ien . '\');">' . $entryname . '</a>';
  
  echo '</td></tr>';

}
echo "</table>";


?>