DWDIQ.m: The extrinsic functions in this routine handle the lowest
level of communication with FileMan. They use a combination of calls
to the DBS API and direct accesses to <sup>DD and </sup>DIC to retrieve and
update FileMan data and metadata.

DWCGI.m: This routine implements the CGI protocol, parsing the
QUERY\_STRING environment variable and standard input to determine
what calls to make into DWDIQ. QUERY\_STRING is the environment
variable that Apache populates with the URL parameters (such as
?key=value&anotherkey=anothervalue). This routine also uses a
MUMPS global, ^DWSESS(php\_session\_id), and its lower level
subscripts, to attach a PHP session ID to a FileMan access code.

DWPHP.m: This routine marshals data (MUMPS to PHP) into PHP
array assignment statements, such as $this->files[ddnum](ddnum.md)='name';.

fileman.cgi: This is a shell script which sets up the GT.M
environment and calls mumps -dir "DWCGI" , allowing DWCGI to
process all the CGI requests.

fileman.inc: This PHP module defines a set of classes for accessing
FileMan data, such as File, FieldMetadata, and FieldData. The
constructors for each class, as well as some of their methods,
use the curl library to perform HTTP GETs against fileman.cgi,
which passes back a set of PHP array assignments, which are then
eval()'d into protected variables within the class, which represent
the data for the particular object.