DSEG	AT 30H
ARG_0:	DS	1

CSEG	AT	0

RESET:
	
	MOV		P1,#1
	MOV		R7,#10 //R7 is a loop counter
LP_1:
	MOV		A,P1
	RL		A
	MOV		P1,A
	DJNZ	R7, LP_1
	
	MOV		A,#1
LP_2:
	RL		A
	MOV		P1, A
	JNB		ACC.7, LP_2
LP_3:	
	RR		A
	MOV		P1, A
	JNB		ACC.0, LP_3
	
	MOV		R0, #14
	MOV		R1, #10
	
LP_4:
	CLR		C
	MOV		A, R1
	SUBB	A, R0 //subtracting with borrow
	JZ		LP_4_MATCH
	INC		R1
	SJMP	LP_4
LP_4_MATCH:
	
	MOV		R7,#7
	MOV		A,#30	
	MOV		ARG_0, #27
	
LP_5:
	CJNE	A, ARG_0, VAL_NEQ
	MOV		P1,#0
	SJMP	LP_5_ITR
VAL_NEQ:
	JC		VAL_LT	
VAL_GT:
	MOV		P1, #1
	SJMP	LP_5_ITR	
VAL_LT:	
	MOV		P1, #0FFH
LP_5_ITR:	
	INC		ARG_0
	DJNZ	R7, LP_5	
	
STOP:	
	SJMP	STOP

END