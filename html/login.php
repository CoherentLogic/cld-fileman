<?php session_start(); ?>
<html>
<head>
<title>FileMan Login</title>
<link rel="stylesheet" type="text/css" href="fm.css">
</head>
<body style="background-color:#c0c0c0;">

<div id="upper_wrapper">
  <div class="right_stuff">
    <img src="images/fileman.png" style="margin-top:80px; margin-bottom:60px;">
    <div style="padding-left:30px;">
    <form name="login" method="POST" action="login_submit.php">
      <label>Access Code: <br/><input type="password" name="access_code"></label>    
      <input type="submit" name="submit" value="Log In">
      <?php
    if (isset($_GET['error']))
      {
	echo '<br/><br/><span style="color:black;">Invalid access code. Please try again.</span>';
      }
      ?>
    </form>
    </div>
  </div>
</div>
<div id="lower_wrapper">
  <img src="images/folder.png" style="margin-top:-250px; margin-left:60px;">
  <div class="right_stuff" style="font-size:10px; font-weight:light; color:#999999;">
    Copyright &copy; 2011 Coherent Logic Development<br/>
    All rights reserved.
  </div>
</div>

</body>
</html>
