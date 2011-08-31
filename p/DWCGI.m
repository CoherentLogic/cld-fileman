DWCGI ;CLD/JOLLIS-FileMan Web Tools CGI support ;8:01 AM  30 Aug 2011
 ;;0.9;FileMan Web Tools;****;Aug 30, 2011
 ;;$Id$
 N DWQS,IEN,TP
 S QS=$ZTRNLNM("QUERY_STRING")
 F I=1:1:$L(QS,"&")  D
 .S TP=$P(QS,"&",I)
 .S DWQS($P(TP,"=",1))=$P(TP,"=",2)
 I DWQS("action")="get-json-record" D JSON
 I DWQS("action")="get-field" D GETFIELD
 I DWQS("action")="set-field" D SETFIELD
 I DWQS("action")="field-list" D FLDLIST(DWQS("dd"),DWQS("instance"))
 I DWQS("action")="field-metadata" D FLDMETA(DWQS("dd"),DWQS("field-number"),DWQS("instance"))
 I DWQS("action")="file-numbers" D FILENUMS(DWQS("instance"))
 I DWQS("action")="authenticate" D AUTH(DWQS("session_id"),DWQS("access_code"))
 Q

AUTH(SESSID,ACCODE)
 N OK S OK=0
 N X S X=ACCODE
 I X'="" D
 .D ^XUSHSH S DUZ=$O(^VA(200,"A",X,0))
 .I DUZ'="" S OK=1
 I OK=1 D
 .S ^DWSESS(SESSID,"ACCESS CODE")=ACCODE
 D HEADER("text/plain")
 W OK
 Q

FLDLIST(DDNUM,INSTANCE)
 ; output a list of fields
 N FN S FN=INSTANCE_"->fields"
 N FL,CNT
 S CNT=$$FLDNUMS^DWDIQ(DDNUM,.FN)
 D HEADER("text/plain")
 F I=1:1:CNT D
 .D ARRELEM^DWPHP(FN,FN(I),$$FLDNAME^DWDIQ(DDNUM,FN(I)))
 Q

GETFIELD
 W !
 Q

SETFIELD
 W !
 Q

FLDMETA(DDNUM,FLDNUM,INSTANCE)
 ; output general metadata 
 N GEN S GEN=INSTANCE_"->general"
 N SEC S SEC=INSTANCE_"->security_access"
 N SUB S SUB=INSTANCE_"->subfile"
 N PTR S PTR=INSTANCE_"->pointer"
 N SOC S SOC=INSTANCE_"->set_of_codes"
 N WP S WP=INSTANCE_"->word_processing"
 N SARR S SARR=""
 N CODESET,CODECNT,CURKEY S CURKEY=""
 D HEADER("text/plain")
 D ARRELEM^DWPHP(GEN,"file-number",DDNUM)
 D ARRELEM^DWPHP(GEN,"file-name",$$FILENAME^DWDIQ(DDNUM))
 D ARRELEM^DWPHP(GEN,"number",FLDNUM)
 D ARRELEM^DWPHP(GEN,"name",$$FLDNAME^DWDIQ(DDNUM,FLDNUM))
 D ARRELEM^DWPHP(GEN,"datatype",$$DATATYPE^DWDIQ(DDNUM,FLDNUM))
 D ARRELEM^DWPHP(GEN,"auditing",$$FLDAUDIT^DWDIQ(DDNUM,FLDNUM))
 D ARRELEM^DWPHP(GEN,"required",$$FLDREQD^DWDIQ(DDNUM,FLDNUM))
 D ARRELEM^DWPHP(GEN,"immutable",$$IMUTABLE^DWDIQ(DDNUM,FLDNUM))
 D ARRELEM^DWPHP(GEN,"computed",$$COMPUTED^DWDIQ(DDNUM,FLDNUM))
 D ARRELEM^DWPHP(GEN,"helptext",$$HELPMSG^DWDIQ(DDNUM,FLDNUM))
 D ARRELEM^DWPHP(GEN,"printlength",$$PRTLEN^DWDIQ(DDNUM,FLDNUM))
 ; output security metadata
 D FLDSEC^DWDIQ(DDNUM,FLDNUM,.SARR)
 D ARRELEM^DWPHP(SEC,"read",SARR("READ"))
 D ARRELEM^DWPHP(SEC,"write",SARR("WRITE"))
 D ARRELEM^DWPHP(SEC,"delete",SARR("DELETE"))
 ; output subfile metadata
 I $$SUBFILE^DWDIQ(DDNUM,FLDNUM)'=0 D
 .N VER,ASK,TMP S ASK="No" S VER="Yes"
 .S TMP=$$FLDTYPE^DWDIQ(DDNUM,FLDNUM)
 .I TMP["A" S VER="No" E  S VER="Yes"
 .D ARRELEM^DWPHP(SUB,"number",$$SUBFILE^DWDIQ(DDNUM,FLDNUM))
 .D ARRELEM^DWPHP(SUB,"name",$$FILENAME^DWDIQ($$SUBFILE^DWDIQ(DDNUM,FLDNUM)))
 .D ARRELEM^DWPHP(SUB,"verify-new-subentry",VER)
 .I TMP["M" S ASK="Yes" E  S ASK="No"
 .D ARRELEM^DWPHP(SUB,"ask-for-another",ASK)
 ; TODO: output pointer metadata
 ; output set-of-codes metadata
 I $$FLDTYPE^DWDIQ(DDNUM,FLDNUM)["S" D
 .S CODECNT=$$CODES^DWDIQ(DDNUM,FLDNUM,.CODESET)
 .F I=0:1 S CURKEY=$O(CODESET(CURKEY)) Q:CURKEY=""  D
 ..D ARRELEM^DWPHP(SOC,CURKEY,CODESET(CURKEY))
 Q

FILENUMS(INSTANCE) 
 N FILES S FILES=""
 N CNT S CNT=$$FILELIST^DWDIQ(.FILES)
 D HEADER("text/plain")
 F I=1:1:CNT D
 .D ARRELEM^DWPHP(INSTANCE_"->files",FILES(I,"DDNUM"),FILES(I,"NAME"))
 Q
 

JSON
 D HEADER("application/json")
 D GET^DWFMJSON(^DWQS("dd"),^DWQS("ien"))
 Q

HEADER(CTYPE)
 W "Content-type: ",CTYPE,!,!
 Q

 