/*
 * $Id$
 */


function LoadFieldsFromSelection()
{
    var CurrentFile = $('#MasterFilesList').val();
    var URL = 'fieldlist.php?dd=' + escape(CurrentFile);
    $.get(URL, function(data) {
	$('[id="field_list"]').html(data);
    });
}

function LoadEntriesFromSelection()
{
    var CurrentFile = $('#MasterFilesList').val();
    var URL = 'entrylist.php?dd=' + escape(CurrentFile);
    $.get(URL, function(data) {
	$('[id="field_list"]').html(data);
    });
}

function LoadFieldList(file_number)
{
    var URL = 'fieldlist.php?dd=' + escape(file_number);
    $.get(URL, function(data) {
	$('[id="field_list"]').html(data);
    });

    $("#MasterFilesList").val(file_number);

}

function LoadFile(file_number, field_number)
{
    //alert("dd: " + file_number + " field: " + field_number);

    var URL = 'field.php?dd=' + escape(file_number) + '&field=' + field_number;
    $.get(URL, function(data) {
	$('[id="ContentArea"]').html(data);
    });
}

function LoadEntry(file_number, ien)
{
    //alert("file_number = " + file_number + " ien = " + ien);

    var URL = 'entry.php?dd=' + escape(file_number) + '&ien=' + ien;
    $.get(URL, function(data) {
	$('[id="ContentArea"]').html(data);
    });
}
