DWPHP ;CLD/JOLLIS-FileMan Web Tools PHP support ;8:03 AM  30 Aug 2011
 ;;0.9;FileMan Web Tools;****;Aug 30, 2011
 ;;$Id$

;
; ARRELEM will output an array element assignment
; assigning $VARNAME['KEY']='VALUE'.
;
ARRELEM(VARNAME,KEY,VALUE)
 N STR S STR=""
 S DIRULE(1,"'")="%27"
 S VALUE=$$TRANSL8^DILF(VALUE,.DIRULE)
 S STR="$"_VARNAME_"['"_KEY_"']='"_VALUE_"';"
 W STR,!
 Q

;
; VARASGN will output a variable assignment statement
; assigning $VARNAME='VALUE'
;
VARASGN(VARNAME,VALUE)
 N STR S STR=""
 S DIRULE(1,"'")="%27"
 S VALUE=$$TRANSL8^DILF(VALUE,.DIRULE)
 S STR="$"_VARNAME_"='"_VALUE_"';"
 W STR,!
 Q