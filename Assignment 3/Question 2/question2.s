	    AREA question2, CODE, READONLY
		ENTRY	;the dragon
		
		ADR r8, STRING	;Loads address of STRING into r8
		ADR r9, EoS	;Loads address of EoS into r9
		
Loop1	LDRB r3, [r8], #1	;Loads char value from string
		TEQ r3, #0x00	;If string != null (null terminator at end of string reached)
		BEQ True	;Then exit from run (palindrome == true)
					;Else:
		CMP r3, #'A'	;Check if value is within capital range (if string[i].isUpper)
		RSBGES r4, r3, #'Z'	;If >= 'A', check 'Z' then update the flags
		ORRGE r3, r3, #2_100000	;Offset by 5 bits to change from capital to lowercase if between values 'A' and 'Z'
		CMP r3, #'a'	;Check if value is within lowercase range (if reverseString[i].isUpper)
		RSBGES r4, r3, #'z'	;If >= 'a', check 'z' then update the flags
		BLT Loop1	;If value is not lowercase, load new value

Loop2	LDRB r2, [r9], #-1	;Loads char value from reverseString

		CMP r2, #'A'	;Check if value is within capital range (if reverseString[i].isUpper)
		RSBGES r4, r2, #'Z'	;If >= 'A', check 'Z' then update the flags
		ORRGE r2, r2, #2_100000		;Offset by 5 bits to change from capital to lowercase if between values 'A' and 'Z'
		CMP r2, #'a'	;Check if value is within lowercase range	(if reverseString[i].isLower)
		RSBGES r4, r2, #'z'	;If >= 'a', check 'z' then update the flags
		BLT Loop2	;If value is not lowercase, load new value

		CMP r3, r2	;If [r3] string[i] != reverseString[i]
		BNE	False	;Then exit from run (palindrome == false)
		B	Loop1	;Else re-enter run
		
True	MOV r0, #-1	;Value at register 0 will retroactively be 1 if palindrome == true
False	ADD r0, r0, #2	;Sets r0 to 2 if palindrome == false
		
Loop	B	Loop	;Infinite Loop to help with memory mapping

TBL		

STRING 	DCB "He lived as a devil, eh?" ;string
EoS 	DCB 0x00 ;end of string
		
		END