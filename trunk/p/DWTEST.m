DWTEST ;CLD/JOLLIS-FileMan Web Tools Testing Code ;8:01 AM  30 Aug 2011
 ;;0.9;FileMan Web Tools;****;Aug 30, 2011
 ;;$Id$

TREE(FILENUM,LEVEL)
 N NUMBERS,LINE,CNT,SUBFILE,I,J
 S CNT=$$FLDNUMS^DWDIQ(FILENUM,.NUMBERS)
 F I=1:1:CNT  D
 .F J=1:1:LEVEL W "-"
 .W "   "_$$FLDNAME^DWDIQ(FILENUM,NUMBERS(I))_" ("_$$FLDTYPE^DWDIQ(FILENUM,NUMBERS(I))_")",!
 .S SUBFILE=$$SUBFILE^DWDIQ(FILENUM,NUMBERS(I))
 .I SUBFILE'=0 D TREE(SUBFILE,LEVEL+1)
 Q