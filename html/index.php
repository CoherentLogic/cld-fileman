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
   <script type="text/javascript">
    $(document).ready(function() {
	
	$('[id="MasterFilesList"]').change(function() {
	    var CurrentFile = $('#MasterFilesList').val();
	    var URL = 'file.php?dd=' + escape(CurrentFile);
	    $.get(URL, function(data) {
		$('[id="ContentArea"]').html(data);
	    });
	});
    });
   </script>
</head>
<body>

<div id="left_bar">
  <img src="images/fileman.png" style="padding:30px;">
  <?php include 'filelist.php'?>
</div>

<div id="right_box">
    <div id="ContentArea">
    </div>
</div>

</body>
</html>
