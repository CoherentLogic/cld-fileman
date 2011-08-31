<div id="FilesBox">
<?php
echo '<strong>Files:</strong><br/>';
$filelist = new FileList($_SESSION['connection']);
$filelist->DropdownBox('MasterFilesList', 'MasterFilesList');
?>
<br/><br/>
<input type="button" value="Load Fields" onclick="LoadFieldsFromSelection();">
<input type="button" value="Load Entries" onclick="LoadEntriesFromSelection();">
</div>
