; Code segment - content of program memory
CSEG	AT	0
	MOV		R7,#10; Loading immediate data (a constant)	
	MOV		P1,#0
MY_LOOP:	
	INC		P1	
	DJNZ	R7,MY_LOOP; Decrement and jump
	
PROG_END:	
	SJMP	PROG_END	;This stops the processing

END ;End of asm file - required by the compiler
