DWDIQ ;CLD/JOLLIS-FileMan Web Tools FM Query ;8:01 AM  30 Aug 2011
 ;;0.9;FileMan Web Tools;****;Aug 30, 2011
 ;;$Id$

;
; Retrieve the closed root of FILENUM
;
ROOT(FILENUM)
 N OPNGBL,OGLEN,CLSGBL
 S OPNGBL=$G(^DIC(FILENUM,0,"GL"))
 S OGLEN=$L(OPNGBL)
 I $E(OPNGBL,OGLEN)="," D
 .S OPNGBL=$E(OPNGBL,1,OGLEN-1)
 S CLSGBL=OPNGBL_")"
 Q CLSGBL

;
; Retrieve the closed root of FILENUM's header
;
HEADER(FILENUM)
 N OPNGBL
 S OPNGBL=$G(^DIC(FILENUM,0,"GL"))
 Q OPNGBL_"0)"

;
; Retrieve the total number of entries in FILENUM
;
ENTRIES(FILENUM)
 N REF
 S REF=$$HEADER(FILENUM)
 Q $P(@REF,"^",4)

;
; Retrieve the last IEN issued in FILENUM
;      
MOSTRCNT(FILENUM)
 N REF
 S REF=$$HEADER(FILENUM)
 Q $P(@REF,"^",3)

;
; Retrieve a sequentially-indexed array in TARGET
; containing all the IENs used in FILENUM;
; ALLIENS will return the total number of IENs
; retrieved.
;
ALLIENS(FILENUM,TARGET)
 N REF 
 N ENT
 N I
 S ENT=""
 S REF=$$ROOT(FILENUM)
 F I=0:1 S ENT=$O(@REF@(ENT)) Q:I>$$ENTRIES(FILENUM)  D
 .S TARGET(I)=ENT
 Q I 

;
; Retrieve the name of FLDNUM in FILENUM
;
FLDNAME(FILENUM,FLDNUM)
 Q $P($G(^DD(FILENUM,FLDNUM,0)),"^",1)

;
; Retrieve a sequentially-indexed array in TARGET
; containing all the field numbers used in FILENUM;
; FLDNUMS will return the total number of field numbers
; retrieved.
;
FLDNUMS(FILENUM,TARGET)
 N FLDNUM S FLDNUM=""
 N CNT S CNT=0
 N FNAM S FNAM=""
 F I=0:1 S FLDNUM=$O(^DD(FILENUM,FLDNUM)) Q:FLDNUM=""  D 
 .S FNAM=$$FLDNAME(FILENUM,FLDNUM)
 .I FNAM'="" D
 ..S CNT=CNT+1
 ..S TARGET(I)=FLDNUM
 Q CNT

;
; Retrieve a sequentially-indexed array in TARGET
; containing all the field names used in FILENUM;
; FLDNAMES will return the total number of field names
; retrieved.
;
FLDNAMES(FILENUM,TARGET)
 N FLDNUM S FLDNUM=""
 N FNAM S FNAM=""
 N CNT S CNT=0
 F I=0:1 S FLDNUM=$O(^DD(FILENUM,FLDNUM)) Q:FLDNUM=""  D
 .S FNAM=$$FLDNAME(FILENUM,FLDNUM)
 .I FNAM'="" D
 ..S CNT=CNT+1
 ..S TARGET(I,"NAME")=FNAM
 ..S TARGET(I,"NUM")=FNUM
 Q CNT

;
; FLDTYPE returns the type information of FILENUM,FLDNUM
;
FLDTYPE(FILENUM,FLDNUM)
 Q $P($G(^DD(FILENUM,FLDNUM,0)),"^",2)

;
; SUBFILE returns the DD number of a multiple, if FLDNUM in FILENUM
; is a multiple. Otherwise, returns 0.
;
SUBFILE(FILENUM,FLDNUM)
 Q $$FLDTYPE(FILENUM,FLDNUM)+0

;
; FILELIST returns a sequentially-indexed array containing
; NAME and DDNUM subscripts for all files in this installation
; in TARGET. TARGET must be passed by reference; not by value.
; FILELIST itself returns the number of files.
;
FILELIST(TARGET)
 N FNAM,FNUM
 S FNUM=0
 N COUNT S COUNT=""
 N CNT S CNT=0
 F COUNT=0:1 S FNUM=$O(^DIC(FNUM)) Q:FNUM=""  D
 .I $G(FNUM,0) D
 ..S CNT=CNT+1
 ..S TARGET(CNT,"NAME")=$P(^DIC(FNUM,0),"^",1)
 ..S TARGET(CNT,"DDNUM")=$P(^DIC(FNUM,0),"^",2)+0
 Q CNT
