.data
	//TEST_NUM: .word 1,2,3,5,0xA,-1
.text
.global _start
_start:
	//deposit sum into R7
	//deposit count into R8
	//LOOP thorugh list
	LDR R0,=TEST_NUM
	MOV R7,#0
	MOV R8,#0
LOOP: 
	LDR R1,[R0]
	CMP R1,#-1
	BEQ END
	ADD R7,R7,R1 //adding to the sum in R7
	ADD R8,R8,#1 //adding the counter
	ADD R0,R0,#4 //updating address to go to next item in list
	B LOOP
	
END: B END
	.end
	
	