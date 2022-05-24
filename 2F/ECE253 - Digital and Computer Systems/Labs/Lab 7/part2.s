.data
TEST_NUM: .word 0x103fe00f
.text
.global _start
_start:
	//count largest string of 1s
	//LOOP until whole string is 0
	LDR R2,=TEST_NUM
	LDR R1,[R2]
	MOV R0,#0	//counter
LOOP: 
	CMP R1,#0
	BEQ END
	LSR R2,R1,#1 //logic shift right by 1
	AND R1,R1,R2 
	ADD R0,#1 //updating counter
	B LOOP
	
END: B END
	.end
	
