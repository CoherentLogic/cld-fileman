<?php
require 'settings.inc';
require 'fm/fileman.inc';
session_start();
include 'auth_check.inc';
?>
<html>
<head>
   <title>FileMan</title>
   <link rel="stylesheet" type="text/css" href="fm.css">
   <script type="text/javascript" src="js/jquery.js"></script>
   <script type="text/javascript" src="js/fileman.js"></script>
   <script type="text/javascript">
    $(document).ready(function() {
	
	$('[id="MasterFilesList"]').change(function() {
	    LoadFieldList();
	});
    });
   </script>
</head>
<body>

<div id="left_bar">
  <img src="images/fileman.png" style="padding:30px;">
  <?php include 'filelist.php'?>
  <div id="field_list">
  </div>
</div>

<div id="right_box">
    <div id="ContentArea">
    </div>
</div>

</body>
</html>
