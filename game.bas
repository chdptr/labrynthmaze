1 PRINT CHR$(142)
2 POKE 52, 56: POKE 56, 56: CLR
3 POKE 56334, PEEK (56334) AND 254
4 POKE 1, PEEK(1) AND 251
5 FOR I = 0 TO 2047: POKE I + 14336, PEEK (I + 53248) : NEXT
6 POKE 1, PEEK(1) OR 4
7 POKE 56334, PEEK(56334) OR 1
8 POKE 53272, PEEK (53272) OR 14
9 FOR I=14336 TO 14336+7:READ V:POKE I,V:NEXT I
10 DATA 36,60,60,90,189,60,102,66
15 PRINT CHR$(147)
16 POKE 53280,11
17 POKE 53281,0
18 POKE 646,4
19 PRINT "****************************************"
20 PRINT "************welcome labrynth************"
22 PRINT "****************************************"
25 PRINT 
28 PRINT
30 PRINT "instructions:"
35 PRINT
40 PRINT "* use wasd to move"
42 PRINT 
45 PRINT "* collect hearts before time runs out"
50 PRINT
54 PRINT
55 PRINT "press any key to start..."
60 GET A$: IF A$ = "" THEN 60
65 PRINT CHR$(147)
75 POKE 53280,9
85 POKE 53281,0
92 POKE 646,4
100 CLR:MS=10:PRINT CHR$(147):REM MAZE SIZE
110 DIM S(MS+1,MS+1):REM SOUTH WALLS
120 DIM W(MS+1,MS+1):REM WEST WALLS
130 DIM V(MS+1,MS+1):REM VISITED CELLS
150 GOSUB 260:REM INITIALIZE MAZE
170 DIM PC(MS*MS+1):DIM PR(MS*MS+1):REM STACK
180 REM PICK RANDOM STARTING CELL
190 X = RND(-TI)
200 C=(INT(RND(1)*MS)+1)
210 R=(INT(RND(1)*MS)+1)
220 GOSUB 400:REM BUILD MAZE
230 GOSUB 540:REM DRAW MAZE
240 END
250 REM -----INITIALIZE MAZE-----
260 REM SET WALLS ON AND VISITED CELLS OFF
270 T=MS+1
280 FOR C=0 TO T:FOR R=0 TO T:
290 S(C,R)=1:W(C,R)=1:V(C,R)=0
300 NEXT R:NEXT C
310 REM SET BORDER CELLS TO VISITED
320 FOR C=0 TO T
330 V(C,0)=1:V(C,T)=1
340 NEXT C
350 FOR R=0 TO T
360 V(0,R)=1:V(T,R)=1
370 NEXT R
380 RETURN
390 REM -----BUILD MAZE-----
400 U=U+1:PC(U)=C:PR(U)=R:REM PUSH
410 V(C,R)=1
420 IF V(C,R+1)=1 AND V(C+1,R)=1 AND V(C,R-1)=1 AND V(C-1,R)=1 THEN GOTO 500
430 Z=INT(RND(1)*4)
440 IF Z=0 AND V(C,R+1)=0 THEN S(C,R)=0:R=R+1:GOTO 400
450 IF Z=1 AND V(C+1,R)=0 THEN W(C+1,R)=0:C=C+1:GOTO 400
460 IF Z=2 AND V(C,R-1)=0 THEN S(C,R-1)=0:R=R-1:GOTO 400
470 IF Z=3 AND V(C-1,R)=0 THEN W(C,R)=0:C=C-1:GOTO 400
480 GOTO 430
500 C=PC(U):R=PR(U):U=U-1:REM POP
510 IF U > 0 THEN GOTO 420
520 RETURN
530 REM -----DRAW MAZE-----
540 REM OPEN 4,4:CMD 4:REM SEND OUTPUT TO PRINTER
550 PRINT CHR$(166);CHR$(166);CHR$(166);CHR$(166);CHR$(166);CHR$(166);CHR$(166);CHR$(166);CHR$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166);chr$(166)
560 FOR R = 1 TO MS
570 FOR C = 1 TO MS+1
580 IF W(C,R)=0 THEN PRINT "   ";
590 IF W(C,R)=1 THEN PRINT CHR$(166);"  ";
600 NEXT C
610 PRINT
620 FOR C = 1 TO MS
630 IF S(C,R)=0 THEN PRINT CHR$(166);"  ";
640 IF S(C,R)=1 THEN PRINT CHR$(166);CHR$(166);CHR$(166);
650 NEXT C
660 PRINT CHR$(166)
670 NEXT R
675 POKE(1024+0+39*40),128
680 REM PRINT#4:CLOSE 4:REM CLOSE PRINTER DEVICE
684 PX=1:PY=2:PP=0:SC=0:MX=9
686 POKE(1024+33+4*40), 19
687 POKE(1024+34+4*40), 3
688 POKE(1024+35+4*40), 15
689 POKE(1024+36+4*40), 18
690 POKE(1024+37+4*40), 5
692 POKE(1024+35+6*40), 48
693 POKE 1024+PX+PY*40,PP:POKE 55296+PX+PY*40,7
700 POKE(1024+33+10*40), 20
710 POKE(1024+34+10*40), 9
720 POKE(1024+35+10*40), 13
730 POKE(1024+36+10*40), 5
740 POKE(1024+37+10*40), 18
1000 REM OBJECT GENERATION
1010 GG=0
1020 DX=INT(RND(1)*29)+1:DY=INT(RND(1)*19)+1
1030 IF PEEK(1024+DX+DY*40)=32 THEN GG=GG+1
1040 IF PEEK(1024+DX+DY*40)=32 THEN POKE(1024+DX+DY*40),83:POKE 55296+DX+DY*40,2
1050 IF GG<>MX THEN GOTO 1020  
1060 REM END GENERATION
1070 TG=TI:D=200
1080 GET A$
1085 GOTO 9000 
2010 OX=PX
2020 OY=PY
2030 IF A$="D" AND PEEK(1024+PX+1+PY*40)=32 OR PEEK(1024+PX+1+PY*40)=83 THEN PX=PX+1
2040 IF A$="A" AND PEEK(1024+PX-1+PY*40)=32 OR PEEK(1024+PX-1+PY*40)=83 THEN PX=PX-1 
2050 IF A$="S" AND PEEK(1024+PX+(PY+1)*40)=32 OR PEEK(1024+PX+(PY+1)*40)=83 THEN PY=PY+1
2060 IF A$="W" AND PEEK(1024+PX+(PY-1)*40)=32 OR PEEK(1024+PX+(PY-1)*40)=83 THEN PY=PY-1
2070 IF PEEK(1024+PX+PY*40)=83 THEN SC=SC+1
2080 POKE(1024+35+6*40), 48+SC
2090 IF OX <> PX OR OY <> PY THEN POKE1024+OX+OY*40, 32
2100 X=1024+PX+PY*40
2200 POKE X, PP:POKE 55296+PX+PY*40,7
2300 IF SC=MX THEN GOTO2500
2400 GOTO 1080
2410 REM -YOU WIN
2500 POKE(1024+34+14*40), 25
2600 POKE(1024+35+14*40), 15
2700 POKE(1024+36+14*40), 21
2800 POKE(1024+34+15*40), 23
2900 POKE(1024+35+15*40), 9
3000 POKE(1024+36+15*40), 14
3025 RETURN
3030 REM -YOU LOSE!
3040 POKE(1024+34+14*40), 25 
3050 POKE(1024+35+14*40), 15 
3060 POKE(1024+36+14*40), 21
3070 POKE(1024+33+15*40), 12
3080 POKE(1024+34+15*40), 15
3090 POKE(1024+35+15*40), 19
3100 POKE(1024+36+15*40), 5
3105 POKE(1024+37+15*40), 33
3110 GOSUB 100
3120 REM -TIMER LOGIC
9000 TD=TI
9010 IF TD-TG >= 50 THEN D=D-1:TG=TD
9020 IF D<0 THEN GOTO 3040
9030 SD$=STR$(D)
9040 DX$="0":DY$="0":DZ$=RIGHT$(SD$,1)
9050 IF LEN(SD$)>=4 THEN DX$=MID$(SD$,2,1)
9060 IF LEN(SD$)=4 THEN DY$=MID$(SD$,3,1)
9070 IF LEN(SD$)=3 THEN DY$=MID$(SD$,2,1)
9480 POKE(1024+34+12*40), VAL(DX$)+48
9490 POKE(1024+35+12*40), VAL(DY$)+48
9500 POKE(1024+36+12*40), VAL(DZ$)+48
10000 GOTO 2010

