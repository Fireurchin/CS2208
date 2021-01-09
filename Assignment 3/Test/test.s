	    AREA test, CODE, READONLY
		ENTRY	;the dragon
		
		ADR r8, STRING
		ADR r9, EoS
		LDRB r2, [r9], #-1
		LDRB r12, EoS
		
Loop1	LDRB r1, [r8], #1	;Loads Big endian digit to be tested
		LDRB r2, [r9], #-1
		ORR	r1, r1, #2_100000
		TEQ r1, r12	;Tests if end of string has been reached
		BNE	Loop1	;Repeats loop until null terminator is reached and string is fully processed
		
Loop	B	Loop

STRING 	DCB "He lived as a devil, eh?" ;string
EoS		DCB 0x00 ;end of string
		
		END