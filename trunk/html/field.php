<?php
require 'fm/fileman.inc';
session_start();

// get the FieldMetadata object for file number 'dd', field number 'field'
$fm = new FieldMetadata($_SESSION['connection'], $_GET['dd'], $_GET['field']);

// get the various property sets for this field
$general = $fm->General();
$security = $fm->SecurityAccess();
$subfile = $fm->Subfile();
$codes = $fm->SetOfCodes();
$pointer = $fm->Pointer();

if($general['datatype'] == '') {
  $general['datatype'] = 'No Datatype';
 }
?>
<html>
<head><title>Field Information</title></head>
<body>

<div class="BodyWrapper">
<span id="FieldHeader">
  <?php 
  if ($general['file-name'] != '') {
    echo $general['file-name'];
  }
  else {
    echo $general['file-number'];
  }
  echo ' -> ';
 if ($general['name'] != '') {
  echo  $general['name'];
 }
 else {
   echo $general['number'];
 }
?>

</span>

<div id="FieldInformation">
  <div class="PropBox">
  <h3>General Properties</h3>
  <blockquote>
  <table>
  <tr>
  <td width="200px">Field number:</td>
  <td><?php echo $general['number']; ?></td>
  </tr>
  <tr>
  <td>Data type:</td>
  <td>
  <?php echo $general['datatype']; ?>
  <?php
  if ($general['datatype'] == 'Set of Codes') {
    echo ': <select size="1">';
    foreach ($codes as $key => $value) {
      echo '<option>' . $value . '</option>';
    }
    echo '</select>';
  }
  if ($general['datatype'] == 'Multiple') {
    echo '<input type="button" onclick="LoadFieldList(' . $subfile['number'] . ');" value="Open Subfile ' . $subfile['number'] . '">';
  }
  if ($general['datatype'] == 'Pointer') {
    echo ' to ' . $pointer['file-name'] . '&nbsp;';
    echo '<input type="button" onclick="LoadFieldList(' . $pointer['file-number'] . ');" value="Open ' . $pointer['file-name'] . '">';
  }
  ?>
  </td>
  </tr>
  <tr>
  <td>Auditing:</td>
  <td><?php echo $general['auditing']; ?></td>
  </tr>
  <tr>
  <td>Required Field:</td>
  <td><?php echo $general['required']; ?></td>
  </tr>
  <tr>
  <td>Immutable:</td>
  <td><?php echo $general['immutable']; ?></td>
  </tr>
  <tr>
  <td>Computed field:</td>
  <td><?php echo $general['computed']; ?></td>
  </tr>
  <tr>
  <td>Help text:</td>
  <td><?php echo urldecode($general['helptext']); ?></td>
  </tr>
  <tr>
  <td>Print length:</td>
  <td><?php echo $general['printlength']; ?></td>
  </tr>
  </table>
  </blockquote> 
  </div>


  <div class="PropBox">
  <h3>Security Access:</h3>
  <blockquote>
  <table>
  <tr>
  <td width="200px;">Read:</td>
  <td><?php echo $security['read']; ?></td>
  </tr>
  <tr>
  <td>Write:</td>
  <td><?php echo $security['write']; ?></td>
  </tr>
  <tr>
  <td>Delete:</td>
  <td><?php echo $security['delete']; ?></td>
  </tr>
  </table>
  </blockquote>
  </div>

  <div class="PropBox" <?php if($general['datatype']!='Multiple') { echo ' style="display:none;"'; } ?>>
  <h3>Subfile Properties</h3>
  <blockquote>
  <table>
  <tr>
  <td width="200px">Subfile number:</td>
  <td><?php echo $subfile['number']; ?></td>
  </tr>
  <tr>
  <td>Subfile name:</td>
  <td><?php echo $subfile['name']; ?></td>
  </tr>
  <tr>
  <td>Verify new subentry:</td>
  <td><?php echo $subfile['verify-new-subentry']; ?></td>
  </tr>
  <tr>
  <td>Ask for another:</td>
  <td><?php echo $subfile['ask-for-another']; ?></td>
  </tr>
  </table>
  </blockquote> 
  </div>

  <div class="PropBox" <?php if($general['datatype']!='Pointer') { echo ' style="display:none;"'; } ?>>
  <h3>Pointer Properties</h3>
  <blockquote>
  <table>
  <tr>
  <td width="200px">Points to file:</td>
  <td><?php echo $pointer['file-number'] . ' (' . $pointer['file-name'] . ')'; ?></td>
  </tr>
  <tr>
  <td>LAYGO allowed:</td>
  <td><?php echo $pointer['laygo-allowed']; ?></td>
  </tr>
  </table>
  </blockquote>
  </div>
</div>
</div>

</body>
</html>
