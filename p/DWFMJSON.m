DWFMJSON ;CLD/JOLLIS-FileMan Web Tools JSON support ;8:04 AM  30 Aug 2011
 ;;0.9;FileMan Web Tools;****;Aug 30, 2011
 ;;$Id$

GET(FILENUM,IEN)
 N FIELDS
 N CNT
 N VAL
 N IENS
 S IENS=IEN_","
 S CNT=$$FLDNAMES^DWDIQ(FILENUM,.FIELDS)
 D OPEN
 D HEADER(FILENUM,IEN)
 F I=1:1:CNT  D
 .S VAL=$$GET1^DIQ(FILENUM,IENS,FIELDS(I))
 .D PAIR(FIELDS(I),VAL)
 D ENDPAIR(FILENUM,IEN)
 D CLOSE
 Q  

OPEN
 W "{",!
 Q

CLOSE
 W "}"
 Q

HEADER(FILENUM,IEN)
 D PAIR("dd-num",FILENUM)
 D PAIR("ien",IEN)
 Q

PAIR(KEY,VALUE)
 N ST
 S ST=""""_KEY_""""_": "_""""_VALUE_""""_","
 W ST,!
 Q

ENDPAIR(FILENUM,IEN)
 N ST
 S ST="""end-record"""_": "_""""_FILENUM_"-"_IEN_""""
 W ST,!
 Q

