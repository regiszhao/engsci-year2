.text
.global _start
//.global ONES

_start:
	//count largest string of 1s
	//LOOP until whole string is 0
	LDR R3,=TEST_NUM
	MOV R5, #0
	B LOOP

//LOOP through each val in the list of words
LOOP:
	LDR R1,[R3]
	CMP R1,#-1
	BEQ END
	BL ONES
	CMP R0,R5 		//check if R0 greater than R5
	BGE THEN1		//If R0 GE R5, go to then
	//ELSE: keep current value of R5
	B AFTER1		//Skip THEN
THEN1: 
	MOV R5,R0		//THEN: store new largest counter in R5
AFTER1:
	ADD R3, R3, #4  //increment addr
	B LOOP

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
	
END: B END

//TEST_NUM: .word 1,2,3,4,5,6,7,8,9,10,100,0xFF,-1 //longest chain: 8
	.end
	
