                       		`ORG 0 
00000000  2B 00 00 EA  		B GLAVNi 
                        
                       		`ORG 18 
00000018  09 40 2D E9  PREKID	STMFD R13!, {R0, R3, R14} 
                        
0000001C  E0 30 9F E5  		LDR R3, RTC 
                        
00000020  08 00 83 E5  		STR R0, [R3, #8] 
00000024  00 00 A0 E3  		MOV R0, #0 
00000028  0C 00 83 E5  		STR R0, [R3, #0C] 
0000002C  01 04 A0 E3  		MOV R0, #1<8 
00000030  04 00 83 E5  		STR R0, [R3, #4] 
                        
00000034  03 00 00 EB  		BL PISI 
                        
00000038  09 40 BD E8  		LDMFD R13!, {R0, R3, R14} 
0000003C  04 F0 5E E2  		SUBS PC, R14, #4 
                        
00000040  07 40 2D E9  PISI	STMFD R13!, {R0, R1, R2, R14} 
                       		 
00000044  BC 20 9F E5  		LDR R2, GPIO 
                        
00000048  0D 00 A0 E3  		MOV R0, #0D 
0000004C  22 00 00 EB  		BL LCDWR 
                        
                        
00000050  3E 00 A0 E3  		MOV R0, #3E ; >>> 
00000054  20 00 00 EB  		BL LCDWR 
00000058  1F 00 00 EB  		BL LCDWR 
0000005C  1E 00 00 EB  		BL LCDWR 
                        
00000060  04 04 A0 E3  POC		MOV R0, #4<8 
00000064  94 10 9F E5  		LDR R1, INDEX 
00000068  01 00 80 E0  		ADD R0, R0, R1 
0000006C  00 00 90 E5  		LDR R0, [R0] 
00000070  00 00 50 E3  		CMP R0, #0 
00000074  00 10 A0 03  		MOVEQ R1, #0 
00000078  80 10 8F 05  		STREQ R1, INDEX 
0000007C  F9 FF FF 0A  		BEQ POC			; ako smo ucitali \0, krecemo ispocetka 
                        
00000080  01 10 81 E2  		ADD R1, R1, #1 
00000084  74 10 8F E5  		STR R1, INDEX 
                        
00000088  13 00 00 EB  		BL LCDWR 
                        
0000008C  3C 00 A0 E3  		MOV R0, #3C ; <<< 
00000090  11 00 00 EB  		BL LCDWR 
00000094  10 00 00 EB  		BL LCDWR 
00000098  0F 00 00 EB  		BL LCDWR 
                        
0000009C  0A 00 A0 E3  		MOV R0, #0A 
000000A0  0D 00 00 EB  		BL LCDWR 
                        
000000A4  07 40 BD E8  KRAJ	LDMFD R13!, {R0, R1, R2, R14} 
000000A8  0E F0 A0 E1  		MOV PC, LR 
                       	 
                        
000000AC  01 D8 A0 E3  GLAVNI	MOV SP, #1<16 
                       		; inicijalizacija RTC 
000000B0  4C 30 9F E5  		LDR R3, RTC 
000000B4  01 44 A0 E3  		MOV R4, #1<8 
000000B8  04 40 83 E5  		STR R4, [R3, #4] ; napuni RTCMR 
000000BC  01 40 A0 E3  		MOV R4, #1 
000000C0  10 40 83 E5  		STR R4, [R3, #10] 
                        
000000C4  00 00 0F E1  		MRS R0, CPSR 
000000C8  80 00 C0 E3  		BIC R0, R0, #80 
000000CC  00 F0 21 E1  		MSR CPSR_c, R0 
                        
000000D0  00 00 00 EA  PETLJA	B PETLJA 
                        
000000D4  01 00 2D E9  LCDWR	STMFD R13!, {R0} 
                       	 
000000D8  7F 00 00 E2  		AND R0, R0, #7F 
000000DC  04 00 C2 E5  		STRB R0, [R2, #4] 
                        
000000E0  80 00 80 E3  		ORR R0, R0, #80 
000000E4  04 00 C2 E5  		STRB R0, [R2, #4] 
                        
000000E8  7F 00 00 E2  		AND R0, R0, #7F 
000000EC  04 00 C2 E5  		STRB R0, [R2, #4] 
                        
000000F0  01 00 BD E8  		LDMFD R13!, {R0} 
000000F4  0E F0 A0 E1  		MOV PC, LR 
                        
000000F8  00 00 00 00  INDEX	DW 0 
000000FC  00 FE FF FF  RTC		DW 0FFFFFE00 
00000100  00 FF FF FF  GPIO	DW 0FFFFFF00		 
                        
                       		`ORG 400 
00000400  49 6E 74 65  STRING	DB 49,6e,74,65,72,6e,61,74,69,6f,6e,61,6c,69,73,61
          72 6E 61 74  
          69 6F 6E 61  
          6C 69 73 61  
          74 69 6F 6E  
          00           
