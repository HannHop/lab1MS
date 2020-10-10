;Example 2: Simple arithmetic and logic operations

BSEG	AT	0
FLAG_A:	DBIT	1	;Reserve 1 bit in bit space, refer to it as FLAG_A
RQ:		DBIT	1	;Reserve 1 bit in bit space, refer to it as FLAG_B

DSEG	AT	30h; Place data segment
ARG_0:	DS	1	;Reserve 1 byte of memory
ARG_1:	DS	1	;Reserve 1 byte of memory
RES:	DS	1	;Low order result memory cell
RES_HI:	DS	1	;High order result memory cell

CSEG	AT	0
RESET:
	MOV		ARG_0, #10
	MOV		ARG_1, #31
	
	;Addition ACC = ACC + (ARG)
	MOV		A, ARG_0
	ADD		A, ARG_1
	MOV		RES, A
	
	;Where is an additional result bit of addition?
	MOV		ARG_0, #123
	MOV		ARG_1, #136
	
	; ARG_0 + ARG_1 = 259 > 255 -> ACC = 3 (?)	
	; {CY, RES} = ARG_0 + ARG_1
	MOV		A, ARG_0
	ADD		A, ARG_1
	MOV		RES, A
	MOV		A, #0
	ADDC	A, #0
	MOV		RES_HI, A
	
	;Multiplication (ARG_1 * ARG_2 < 256)
	MOV		ARG_0, #9
	MOV		ARG_1, #18
	
	;Operation {B,A} = A * B
	MOV		A, ARG_0
	MOV		B, ARG_1
	MUL		AB
	MOV		RES, A
	
	;Multiplication (ARG_1 * ARG_2 >= 256)
	; {B,A} = A * B
	MOV		ARG_0, #25
	MOV		ARG_1, #17
	
	;Operation
	MOV		A, ARG_0
	MOV		B, ARG_1
	MUL		AB
	MOV		RES, A
	MOV		RES + 1, B
	
	;Division and moduls
	MOV		ARG_0, #190
	MOV		ARG_1, #17
	
	;Operation
	; A = A / B
	; B = A % B
	MOV 	A, ARG_0
	MOV		B, ARG_1
	DIV		AB
	MOV		RES, A
	MOV		RES + 1, B
	
	;Logic AND
	MOV		ARG_0,#01011111B
	MOV		ARG_1,#10000010B
	
	MOV		A, ARG_0
	ANL		A, ARG_1
	MOV		RES, A
	
	;Logic OR
	MOV		ARG_0,#01010000B
	MOV		ARG_1,#10000010B
	
	MOV		A, ARG_0
	ORL		A, ARG_1
	MOV		RES, A
	
STOP:	
	SJMP	STOP	
	
	END
	
	
	