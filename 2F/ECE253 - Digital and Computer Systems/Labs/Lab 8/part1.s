.global ONES

ONES: 
	MOV R0,#0		//reset counter
LOOP:
	CMP R1,#0
	BEQ ENDLOOP
	LSR R2,R1,#1 //logic shift right by 1
	AND R1,R1,R2 
	ADD R0,#1 //updating counter
	B LOOP
ENDLOOP:
	MOV PC,LR

