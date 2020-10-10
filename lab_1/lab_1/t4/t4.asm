
DSEG	AT 30H

ARG_0:	DS	1
ARG_1:	DS	1
RES_0:	DS	1
RES_1:	DS	1

BSEG	AT 0

RQ_0:	DBIT	1
RQ_1:	DBIT	1

XSEG	AT	0
ARR_1:	DS	64
ARR_2:	DS	64

CSEG	AT	0
RESET:
	MOV		ARG_0, #10; Direct addressing + immediate addressing
	MOV		R0, #ARG_1; Register addressing + immediate addressing
	MOV		@R0, #23;
	
	DEC		R0
	DEC		@R0; What has happend now?

	MOV		DPTR, #MY_DATA
	CLR		A
	MOVC	A, @A + DPTR
	MOV		P1, A; There should be 1
	
	MOV		A, #5
	MOVC	A, @A + DPTR
	MOV		P1, A; There should be ?
	
	MOV		A, #3
	MOVC	A, @A + DPTR
	MOV		DPTR, #ARR_2
	MOVX	@DPTR, A
	
TCK_DIAG:	
	MOV		R7,#3
TCK_LP:	
	JNB		P3.0,$
	JB		P3.0,$
	DJNZ	R7,TCK_LP	
	
STOP:
	SJMP	STOP

MY_DATA:	DB	1,2,3,4,5,6,0
MY_STR:		DB	"Hello from MCS-51", 0

