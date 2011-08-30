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
 I DWQS("action")="field-list" D FLDLIST
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

FLDLIST
 N FL,CNT
 Q

GETFIELD
 W !
 Q

SETFIELD
 W !
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

 