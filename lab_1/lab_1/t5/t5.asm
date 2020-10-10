DSEG	AT	30H
CNT:	DS	1
RES_0:	DS	1

CSEG	AT	0

RESET:
	MOV		SP,#7FH
	MOV		CNT,#0	
	MOV		R7, #10
	MOV		DPTR, #MY_DATA
LP_1:	
	MOV		A,CNT
	MOVC	A,@A+DPTR
	LCALL	MY_SUB
	DJNZ	R7, LP_1
	
	MOV		A,#23; 
	
	;Saving registers on the stack
	PUSH	ACC
	PUSH	PSW	
	;Do some calculations
	MOV		R7,#5
	ACALL	DO_CALC
	MOV		RES_0, A
	;Restoring data - stack must be balanced
	POP		PSW
	POP		ACC	
	
STOP:
	SJMP	STOP
	
	
MY_SUB:
	INC		CNT
	MOV		P1,A
	CLR		P3.0
	NOP
	SETB	P3.0
	RET
	
DO_CALC:
	CLR		A
DO_CALC_LP:
	ADD		A,R7
	DJNZ	R7,DO_CALC_LP
	RET
	
	
MY_DATA:
		DB	0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225
	
	END
	
	