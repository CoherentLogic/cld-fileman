DWPHP

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
