<?php
  /*
   * redirect if login hasn't occured
   *
   */
if(!isset($_SESSION['login']))
  {
    header('Location: '.$base_url.'/login.php');
  }
 else 
  { 
    if(isset($_SESSION['connection'])) {
      
      if($_SESSION['connection']->Authenticated() == false) {
	header('Location: '.$base_url.'/login.php?error=badcode');
      }
    }
    else {
      header('Location: '.$base_url.'/login.php?error=badcode');
    }
  }

?>