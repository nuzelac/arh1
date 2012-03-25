                               `ORG    0 
                            
00000000  00 05 00 B0          LOAD    R0, (500)    ; brojac za petlju 
00000004  04 05 80 04          MOVE    504, R1      ; pozicija trenutnog podatka
00000008  00 10 00 05          MOVE    1000, R2     ; pozicija za unos 16-bitnog
                            
0000000C  00 00 00 10  PETLJA  AND     R0, R0, R0 
00000010  30 00 C0 D5          JR_Z    KRAJ 
                                
00000014  00 00 90 B5          LOAD    R3, (R1)     ; niza 32-bitna rijec 64-bit
00000018  04 00 10 B6          LOAD    R4, (R1 + 4) ; visa 32-bitna rijec 64-bit
                                
0000001C  01 00 C0 46          ROTL    R4, 1, R5 
00000020  01 00 D0 16          AND     R5, 1, R5    ; testiranje bita za predzna
00000024  08 00 C0 D5          JR_Z    POZ 
                                
00000028  FF FF BF 1D  NEG     XOR     R3, -1, R3   ; B-1 komplement 
0000002C  01 00 B0 25          ADD     R3,  1, R3   ; B komplement 
                        
00000030  00 00 A0 AD  POZ     STOREH  R3, (R2)     ; spremi 16-bitnu polurijec 
                            
00000034  01 00 00 34          SUB     R0, 1, R0    ; smanji brojac za petlju 
00000038  08 00 90 24          ADD     R1, 8, R1    ; pomakni adresu na sljedeci
0000003C  02 00 20 25          ADD     R2, 2, R2    ; pomakni adresu za spremanj
00000040  C8 FF 0F D4          JR      PETLJA 
                                
00000044  00 80 00 04  KRAJ    MOVE    8000, R0     ; oznaka za kraj novog bloka
00000048  00 00 20 AC          STOREH  R0, (R2) 
0000004C  00 00 00 F8          HALT 
                        
                               `ORG 500 ; TODO provjeriti jel ovo dobro zapisano
00000500  05 00 00 00          DW  5, 1, 80000000, 2, 0, 4, 80000000, 25, 0, 49,
          01 00 00 00  
          00 00 00 80  
          02 00 00 00  
          00 00 00 00  
          04 00 00 00  
          00 00 00 80  
          25 00 00 00  
          00 00 00 00  
          49 00 00 00  
          00 00 00 80  
