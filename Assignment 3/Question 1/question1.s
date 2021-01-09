	    AREA question1, CODE, READONLY
		ENTRY	;the dragon
		
		MOV r5, #6	;Sets counter for for loop of 5 iterations (Capacity of each half)
		ADR r8, UPC ;Register 8 points to UPC barcode, allows for LDRB and loop operations
		
Barcode	LDRB r7, [r8], #1	;Increments the value of register 6 to store the first even digit
		SUB r7, #0x30	;Coverts char value at UPC position to be stored as an integer
		LDRB r6, [r8], #1	;Register 6 is assigned to store the current odd barcode digit
		SUB r6, #0x30	;Coverts char value at UPC position to be stored as an integer
		ADD r1, r6	;Performs add operation on odd barcode digits (second sum) and stores in register 1
		ADD r2, r7	;Performs add operation on even barcode digits (first sum) and stores in register 2
		SUBS r5, #1	;Decreases loop counter by 1
		BNE Barcode	;Loops operation until counter reaches 0
		
		ADD r2, r2, LSL #1	;Multiplies value of register 1 by three
		ADD r3, r2, r1	;Adds the tripled first sum to the second sum and stores final sum in register 3
Divide	SUBS r3, #10	;Division loop to test whether checksum is a multiple of 10
		BEQ FalPos	;If checksum is a multiple of 10, branch to Falpos
		BPL Divide	;Re-enter loop until true

Pos		MOV r0, #1	;Value at register 0 will retroactively be 2 if barcode is invalid (not multiple of 10)
FalPos	ADD r0, #1	;Set value at register 0 to 1 if barcode is valid

Loop	B	Loop	;Infinite Loop to help with memory mapping

UPC		DCB "013800150738"	;UPC string

		END