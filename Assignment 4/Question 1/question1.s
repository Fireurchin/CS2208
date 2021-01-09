		AREA question1, CODE, READONLY
		ENTRY	;The Dragon

Main 	ADR sp,Stack ;set up r13 as the stack pointer
		MOV r0,#124 ;set up a dummy parameter in r0
		MOV fp,#123 ;set up dummy frame pointer
		STR r0,[sp,#-4]! ;push the parameter
		
		STMFD sp!,{fp} ;push frame-pointer and link-register
		MOV fp,sp ;frame pointer at the bottom of the frame
		SUB sp,sp,#4 ;create the stack frame (one word)
		LDR r2,[fp,#8] ;get the pushed parameter
		ADD r2,r2,#120 ;do a dummy operation on the parameter
		STR r2,[fp,#-4] ;store it in the stack frame
		ADD sp,sp,#4 ;clean up the stack frame
		LDMFD sp!,{fp}
		
		LDR r1,[sp],#4 ;pop the parameter
Loop 	B Loop

Crack	DCD 0x0000
		DCD 0x0000
		DCD 0x0000
Stack 	DCD 0x111
ACKLE	DCD 0x333
POT		DCD 0x555
	
		END