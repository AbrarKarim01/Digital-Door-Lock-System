ORG 0000H
S: MOV P3,#0FFH
   CLR P3.0
   CLR P3.1
   CLR P3.2
   CLR P3.3
   CLR P2.2
   MOV R0,#02FH		;Input Password is Stored at 030H in memory
   MOV R1,#040H		;Preset Password is Stored at 040H in memory
   MOV R4,#4
   MOV DPTR,#0550H
Z: MOV A,#0
   MOVC A,@A+DPTR
   MOV @R1,A
   INC R1
   INC DPTR
   DJNZ R4,Z

   MOV A,#38H  
   ACALL CMD
   MOV A,#0EH
   ACALL CMD																																				
   MOV A,#01H
   ACALL CMD
   MOV A,#080H
   ACALL CMD
   ACALL DEL
   SJMP PRT

CMD: MOV P1,A
	 CLR P2.0
	 SETB P2.1
	 ACALL DEL2
	 CLR P2.1
	 RET

DAT: MOV P1,A
     SETB P2.0			 
	 SETB P2.1
	 ACALL DEL2
	 CLR P2.1
	 RET


DEL: MOV R1,#250
D2: MOV R2,#250
D3: DJNZ R2,D3
	DJNZ R1,D2
	RET


DEL2: MOV R1,#10
D22: MOV R2,#20
D33: DJNZ R2,D33
	DJNZ R1,D22
	RET
	
PRT:MOV R4,#11 		
	MOV DPTR,#0500H
TH: MOV A,#0
	MOVC A,@A+DPTR
	ACALL DAT
	INC DPTR
	DJNZ R4,TH
	MOV A,#0C0H
   	ACALL CMD
	MOV R4,#4
	SJMP M

M:  ACALL DEL
    JNB P3.4,C1
    JNB P3.5,C2
    JNB P3.6,C3
    JNB P3.7,C4S
	CJNE R4,#0,M
	JMP CHE
C4S:JMP C4

C1: DEC R4
	INC R0
	SETB P3.0
	JB P3.4,SEVEN
	SETB P3.1
	JB P3.4,FOUR
	SETB P3.2
	JB P3.4,ONE
	SETB P3.3
	JB P3.4,STAR

C2: DEC R4
	INC R0
	SETB P3.0
	JB P3.5,EIGHT
	SETB P3.1
	JB P3.5,FIVE
	SETB P3.2
	JB P3.5,TWO
	SETB P3.3
	JB P3.5,ZERO

SEVEN: MOV A,#'7'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'7'
	   JMP H

FOUR:  MOV A,#'4'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'4'
	   JMP H

ONE:   MOV A,#'1'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'1'
	   JMP H

STAR:  MOV A,#'*'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'*'
	   JMP H
C3: DEC R4
	INC R0
	SETB P3.0
	JB P3.6,NINE
	SETB P3.1
	JB P3.6,SIX
	SETB P3.2
	JB P3.6,THREE
	SETB P3.3
	JB P3.6,HASH

EIGHT: MOV A,#'8'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'8'
	   JMP H

FIVE:  MOV A,#'5'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'5'
	   SJMP H

TWO:   MOV A,#'2'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'2'
	   SJMP H

ZERO:  MOV A,#'0'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'0'
	   SJMP H

C4: DEC R4
	INC R0
	SETB P3.0
	JB P3.7,AA
	SETB P3.1
	JB P3.7,BB
	SETB P3.2
	JB P3.7,CC
	SETB P3.3
	JB P3.7,DD

NINE:  MOV A,#'9'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'9'
	   SJMP H

SIX:   MOV A,#'6'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'6'
	   SJMP H

THREE: MOV A,#'3'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'3'
	   SJMP H

HASH:  MOV A,#'#'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'#'
	   SJMP H

AA:	   MOV A,#'A'
	   ACALL DAT
	   ACALL DEL
       MOV @R0,#'A'
	   SJMP H

BB:	   MOV A,#'B'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'B'
	   SJMP H

CC:	   MOV A,#'C'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'C'
	   SJMP H

DD:	   MOV A,#'D'
	   ACALL DAT
	   ACALL DEL
	   MOV @R0,#'D'
	   SJMP H


H: CLR P3.0
   CLR P3.1
   CLR P3.2
   CLR P3.3
   JMP M
 

CHE:MOV A,#01H
    ACALL CMD
    MOV A,#080H
    ACALL CMD
	ACALL DEL
	MOV R0,#02FH
	MOV R1,#03FH
	MOV R4,#4

CH: INC R0
	INC R1
	MOV A,@R0
	MOV B,@R1
	CJNE A,B,FA
	DJNZ R4,CH
    MOV R4,#7 
	MOV DPTR,#0600H
TH2:MOV A,#0
	MOVC A,@A+DPTR
	ACALL DAT
	INC DPTR
	DJNZ R4,TH2
	SETB P2.2
H2: SJMP H2

FA: MOV R4,#7 
	MOV DPTR,#0650H
TH3:MOV A,#0
	MOVC A,@A+DPTR
	ACALL DAT
	INC DPTR
	DJNZ R4,TH3
	MOV R4,#10
WA:	ACALL DEL
	DJNZ R4,WA
	JMP S 



ORG 0500H
DB "ENTER CODE:"

ORG 0550H
DB "1234"

ORG 0600H
DB "SUCCESS"

ORG 0650H
DB "FAILURE"

END 