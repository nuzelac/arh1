                       CTLR		`EQU		0FFFF0000 
                       CTCR		`EQU		0FFFF0004 
                       CTCLEAR		`EQU		0FFFF0008 
                       CTIEND		`EQU		0FFFF000C 
                        
                       DMASRC		`EQU		0FFFF1000 
                       DMADEST		`EQU		0FFFF1004 
                       DMACNT		`EQU		0FFFF1008 
                       DMACTRL		`EQU		0FFFF100C 
                       DMASTART	`EQU		0FFFF1010 
                       DMACLEAR	`EQU		0FFFF1014 
                        
                       BVJ			`EQU		0FFFFFFFC 
                        
                        
                       			`ORG 0 
00000000  F0 01 80 04  			MOVE 1F0, R1	; pocetak bloka 
00000004  00 00 80 05  			MOVE 0, R3		; brojac ukupno poslanih 
                        
00000008  E8 03 00 04  			MOVE %D 1000, R0 
0000000C  00 00 0F B8  			STORE R0, (CTLR) 
00000010  02 00 00 04  			MOVE %B 10, R0 
00000014  04 00 0F B8  			STORE R0, (CTCR) 
                        
00000018  04 00 0F B0  PETLJA		LOAD R0, (CTCR) 
0000001C  00 00 00 6C  			CMP R0, 0 
00000020  F4 FF CF D5  			JR_Z PETLJA 
00000024  08 00 0F B8  			STORE R0, (CTCLEAR) 
                        
00000028  FC FF 0F 05  			MOVE BVJ, R2 
0000002C  00 10 0F B9  			STORE R2, (DMASRC) 
00000030  04 10 8F B8  			STORE R1, (DMADEST) 
00000034  0A 00 00 05  			MOVE %D 10, R2 
00000038  08 10 0F B9  			STORE R2, (DMACNT) 
0000003C  06 00 00 05  			MOVE %B 0110, R2 
00000040  0C 10 0F B9  			STORE R2, (DMACTRL) 
                        
00000044  10 10 0F B9  			STORE R2, (DMASTART) 
                        
00000048  0C 10 0F B1  PETLJA2		LOAD R2, (DMACTRL) 
0000004C  00 00 20 6C  			CMP R2, 0 
00000050  F4 FF CF D5  			JR_Z PETLJA2					 
                        
00000054  14 10 0F B9  			STORE R2, (DMACLEAR) 
00000058  28 00 90 24  			ADD R1, %D 40, R1 
0000005C  01 00 B0 25  			ADD R3, 1, R3 
                        
00000060  0A 00 30 6C  			CMP R3, %D 10 
00000064  0C 00 0F B8  			STORE R0, (CTIEND) 
00000068  AC FF 0F D6  			JR_NZ PETLJA 
                        
0000006C  00 00 00 F8  			HALT 
                        
00000070  F0 01 00 00  POCETAK		DW 1F0 
