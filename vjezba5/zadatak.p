                       		`ORG 0 
00000000  01 D8 A0 E3  		MOV SP, #1<16 
00000004  01 64 A0 E3  		MOV R6, #1<8 ; izvoriste 
00000008  04 74 A0 E3  		MOV R7, #4<8 ; odrediste 
                        
0000000C  04 30 96 E4  PETLJA  LDR R3, [R6], #4 
00000010  08 0E 53 E3  		CMP R3, #8<28 
00000014  0A 00 00 0A  		BEQ IZLAZ 
                        
00000018  08 00 2D E9  		STMFD SP!, {R3} 
0000001C  09 00 00 EB  		BL KUB 
                       	 
00000020  01 00 40 E2  		SUB R0, R0, #1 		; R0 = x^3 - 1 
                        
00000024  03 10 83 E0  		ADD R1, R3, R3 		; R1 = 2*x 
                        
00000028  03 00 2D E9  		STMFD SP!, {R0, R1} 
0000002C  0C 00 00 EB  		BL DIV 
00000030  08 D0 8D E2  		ADD SP, SP, #8 
                        
00000034  04 00 87 E4  		STR R0, [R7], #4 
                        
00000038  F5 FF FF EA  		B PETLJA 
0000003C  FF FF FF FF  IZLAZ	HALT 
                        
                        
00000040  01 00 BD E8  KUB		LDMFD SP!, {R0}		; parametar 
00000044  02 00 2D E9  		STMFD SP!, {R1}		; spremanje konteksta 
00000048  00 10 A0 E1  		MOV R1, R0 
                        
0000004C  91 00 00 E0  		MUL R0, R1, R0		; u R0 = x^2 
00000050  91 00 00 E0  		MUL R0, R1, R0		; u R0 = x^3 
                        
00000054  02 00 BD E8  		LDMFD SP!, {R1} 
00000058  0E F0 A0 E1  		MOV PC, LR 
                        
0000005C  06 00 2D E9  DIV		STMFD SP!, {R1, R2} 
00000060  08 00 8D E2  		ADD R0, SP, #8 
00000064  06 00 90 E8  		LDMFD R0, {R1, R2} 
                        
00000068  00 00 A0 E3  		MOV R0, #0 
0000006C  00 00 52 E3  		CMP R2, #0 
00000070  06 00 00 BA  		BLT NEG 
                        
00000074  02 00 51 E1  POZ		CMP R1, R2 
00000078  02 10 41 A0  		SUBGE R1, R1, R2 
0000007C  01 00 80 A2  		ADDGE R0, R0, #1 
00000080  FD FF FF AA  		BGE POZ 
                        
00000084  05 00 00 EA  		B KRAJ 
                        
00000088  02 00 51 E1  NEG		CMP R1, R2 
0000008C  02 10 41 D0  		SUBLE R1, R1, R2 
00000090  01 00 80 D2  		ADDLE R0, R0, #1 
00000094  FD FF FF DA  		BLE NEG 
                        
00000098  06 00 BD E8  KRAJ	LDMFD SP!, {R1, R2} 
0000009C  0E F0 A0 E1  		MOV PC, LR 
                        
                       		`ORG 100 
00000100  00 00 00 00  		DW 0, 3, 6, -1, -6, 80000000 
          03 00 00 00  
          06 00 00 00  
          FF FF FF FF  
          FA FF FF FF  
          00 00 00 80  
