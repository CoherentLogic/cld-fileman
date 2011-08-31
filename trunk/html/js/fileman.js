/*
 * $Id$
 */


function LoadFieldList()
{
    var CurrentFile = $('#MasterFilesList').val();
    var URL = 'fieldlist.php?dd=' + escape(CurrentFile);
    $.get(URL, function(data) {
	$('[id="field_list"]').html(data);
    });
}

function LoadFile(file_number, field_number)
{
    //alert("dd: " + file_number + " field: " + field_number);

    var URL = 'file.php?dd=' + escape(file_number) + '&field=' + field_number;
    $.get(URL, function(data) {
	$('[id="ContentArea"]').html(data);
    });
}
