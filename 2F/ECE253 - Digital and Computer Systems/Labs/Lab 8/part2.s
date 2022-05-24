.text
.global _start
.global SWAP

// PSEUDO CODE
// load list
// bool swapped = 1
//
// LOOP: while swapped  = 1	
//		swapped = false
//		MOVETHROUGHLIST: for (i = 0,i < length(list),i++)
//			did_swap = swap(i)
//			swapped = swapped OR did_swap
//
// SWAP: function swap (address)
//		if list[i] > list[i+1]
//			temp = list[i]
//			list[i] = list[i+1]
//			list[i+1] = temp
//			swap_occur = 1
//		else:
//			swap_occur = 0
//		return(swap_occur)


_start:
	//acending order
	//first item: number of words, but also sort it
	LDR R7,=LIST 				//OG addr of list
	LDR R5,[R7]					//number of terms
	SUB R5,R5,#1
	ADD R7,R7,#4				//start of values to be swapped
	MOV R1, #1					//swapped bool

LOOP:
	MOV R1, #0					//set swapped to false
	MOV R6, #0					//initialize counter
	MOV R4,R7
	B MOVETHROUGHLIST			//for loop
NEXT:
	CMP R1,#1					//if R1 equals 1, a swap occured, so go back keep going
	BEQ LOOP
	B END						//if not, no swap occured so its done sorting
	
MOVETHROUGHLIST:
	MOV R0,R4
	BL SWAP						//check for swap
AFTER:
	ORR R1,R1,R0				//updating swapped
	ADD R6,R6,#1 				//increment counter
	CMP R6,R5					//go until end of list
	BEQ NEXT
	ADD R4,R4,#4				//update address of list
	B MOVETHROUGHLIST

SWAP: //return R0 1 if swapped, 0 if not
	LDR R2,[R0]
	LDR R3,[R0,#4]
	CMP R2,R3
	BGT SWAP_VALS
	MOV R0,#0
	MOV PC,LR					//go to after
SWAP_VALS:
	STR R3,[R0]
	STR R2,[R0,#4]
	MOV R0,#1
	MOV PC,LR					//after

END: B END

//LIST: .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
	.end

	