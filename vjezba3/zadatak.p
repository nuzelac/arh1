                       VJ1DATA		`EQU	0FFFF1000 
                        
                       VJ2DATA		`EQU	0FFFF2000 
                       VJ2STAT		`EQU	0FFFF2004 
                       VJ2CLEAR	`EQU	0FFFF2004 
                        
                       VJ3DATA		`EQU	0FFFF3000 
                       VJ3IACK		`EQU	0FFFF3004 
                       VJ3STAT		`EQU	0FFFF3004 
                       VJ3IEND		`EQU	0FFFF3008 
                       VJ3STOP		`EQU	0FFFF300C 
                        
                        
                       			`ORG 0 
00000000  00 00 81 07  			MOVE 10000, SP 
00000004  04 00 00 D4  			JR GLAVNI 
                        
                       			`ORG 08 
00000008  00 10 00 00  			DW 1000 
                        
                       			 
0000000C  00 00 00 07  GLAVNI		MOVE 0, R6			; brojac poslanih podataka na vj2 
00000010  01 00 00 04  			MOVE 1, R0 
00000014  0C 30 0F B8  			STORE R0, (VJ3STOP) ; ukljucivanje prekida na vj3 
00000018  90 00 00 04  			MOVE %B 10010000, R0 
0000001C  00 00 10 00  			MOVE R0, SR 		; ukljucivanje GIE i dozvola prekida na 
                        
                       			; spremnost vj2 
00000020  04 20 0F B0  PETLJA		LOAD R0, (VJ2STAT) 
00000024  01 00 00 14  			AND R0, 1, R0 
00000028  F4 FF CF D5  			JR_Z PETLJA 
                        
                       			; posalji podatak sa mem. lokacije BROJ na vj2 
0000002C  44 10 00 B0  			LOAD R0, (BROJ)		 
00000030  00 20 0F B8  			STORE R0, (VJ2DATA) 
00000034  04 20 0F B8  			STORE R0, (VJ2CLEAR) 
00000038  01 00 60 27  			ADD R6, 1, R6 
0000003C  E0 FF 0F D4  			JR PETLJA		 
                        
00000040  00 00 10 04  KRAJ		MOVE %B 0, SR 		; zabrana daljnjih prekida 
00000044  00 00 00 F8  			HALT 
                        
00000048  00 00 80 88  OBRADI		PUSH R1 
                        
0000004C  08 00 F0 B4  			LOAD R1, (SP + 08)	; brojac za potenciju 
00000050  01 00 00 04  			MOVE 1, R0			; 2^0 = 1 
                        
00000054  00 00 10 6C  POTENCIRAJ	CMP R1, 0 
00000058  0C 00 C0 D5  			JR_Z VRATIREZ 
0000005C  01 00 00 54  			SHL R0, 1, R0			 
00000060  01 00 90 34  			SUB R1, 1, R1 
00000064  EC FF 0F D4  			JR POTENCIRAJ		 
                        
00000068  00 00 80 80  VRATIREZ	POP R1 
0000006C  00 00 00 D8  			RET 
                        
                       			`ORG 1000 
00001000  04 30 0F B8  PREKIDNI	STORE R0, (VJ3IACK) 
                        
00001004  00 00 00 88  			PUSH R0				; spremanje konteksta  
00001008  00 00 20 00  			MOVE SR, R0 
0000100C  00 00 00 88  			PUSH R0 
                        
00001010  00 10 0F B0  			LOAD R0, (VJ1DATA) 
00001014  00 00 00 6C  			CMP R0, 0 
00001018  24 F0 4F D4  			JR_N KRAJ 			; ako sa vj1 dobijemo negativan podatak, 
                        
0000101C  00 00 00 88  			PUSH R0 
00001020  48 00 00 CC  			CALL OBRADI 
00001024  04 00 F0 27  			ADD SP, 4, SP 
00001028  44 10 00 B8  			STORE R0, (BROJ) 
                       			 
0000102C  00 30 0F BB  			STORE R6, (VJ3DATA) 
                        
00001030  00 00 00 80  			POP R0 
00001034  00 00 10 00  			MOVE R0, SR 
00001038  00 00 00 80  			POP R0 
                        
0000103C  08 30 0F B8  			STORE R0, (VJ3IEND) 
00001040  01 00 00 D8  			RETI 
                        
00001044  00 00 00 00  BROJ		DW 0	 
