                               `ORG 0 
                        
00000000  48 00 80 04          MOVE    PODACI, R1          ; adresa pocetnog pod
00000004  0C 00 00 05          MOVE    %D 12, R2           ; brojac za petlju 
00000008  00 00 00 07          MOVE    0, R6               ; brojac promijenjeni
0000000C  00 00 81 07          MOVE    10000, SP           ; inicijalizacija sta
                        
00000010  00 00 24 11  PETLJA  AND     R2, R2, R2 
00000014  2C 00 C0 D5          JR_Z    KRAJ                ; kraj petlje 
00000018  00 00 90 95          LOADB   R3, (R1)            ; pocetni podatak 
                                
0000001C  00 00 80 89          PUSH    R3                  ; parametar potprogra
                                
00000020  54 00 00 CC          CALL    PAR 
                               ; nakon zavrsetka potprograma u R0 ce nam biti re
00000024  04 00 F0 27          ADD     SP, 4, SP           ; oslobadjamo stog 
                                
00000028  00 00 30 68          CMP     R3, R0              ; je li se promijenio
0000002C  04 00 C0 D5          JR_EQ    DALJE 
00000030  01 00 60 27          ADD     R6, 1, R6           ; povecaj brojac prom
                                
00000034  01 00 20 35  DALJE   SUB     R2, 1, R2           ; smanji brojac petlj
00000038  00 00 10 9C          STOREB  R0, (R1)            ; spremi (novi) rezul
0000003C  01 00 90 24          ADD     R1, 1, R1           ; pomakni se na sljed
00000040  CC FF 0F D4          JR      PETLJA 
                        
00000044  00 00 00 F8  KRAJ    HALT 
                                
00000048  00 01 FF 02  PODACI  DB 0, 1, 0FF, 2, 3, 0F3, 0F8, 0E, 0B, 36, 7E, 9F 
          03 F3 F8 0E  
          0B 36 7E 9F  
                        
00000054  00 00 00 89  PAR     PUSH    R2                  ; koristimo kao broja
00000058  00 00 80 89          PUSH    R3                  ; koristit cemo za us
0000005C  00 00 00 8A          PUSH    R4                  ; brojac jedinica 
                                
00000060  10 00 70 B4          LOAD    R0, (SP + 10)       ; parametar potprogra
                                
00000064  01 00 00 05          MOVE    1, R2               ; gledamo prvi bit na
00000068  00 00 00 06          MOVE    0, R4               ; pocetni broj jedini
                                
0000006C  80 00 20 6C  PETLJAPAR CMP     R2, 80            ; kada dodjemo do 8. 
00000070  14 00 C0 D5          JR_Z    IZRACUNAJ 
                                
00000074  00 00 84 11          AND     R0, R2, R3          ; je li trenutni bit 
00000078  04 00 C0 D5          JR_Z    DALJEPAR 
0000007C  01 00 40 26          ADD     R4, 1, R4           ; ako je, povecaj bro
                                
00000080  01 00 20 55  DALJEPAR    SHL R2, 1, R2           ; pomakni se ulijevo 
00000084  E4 FF 0F D4          JR      PETLJAPAR 
                        
00000088  01 00 40 16  IZRACUNAJ AND     R4, 1, R4         ; provjeri je li dobi
0000008C  08 00 C0 D5          JR_Z    POZPAR 
00000090  7F 00 00 14          AND     R0, 7F, R0          ; ako je neparan, pos
00000094  04 00 00 D4          JR      KRAJPAR 
00000098  80 00 00 0C  POZPAR  OR      R0, 80, R0          ; ako je paran, posta
                        
0000009C  00 00 00 82  KRAJPAR POP     R4 
000000A0  00 00 80 81          POP     R3 
000000A4  00 00 00 81          POP     R2                  ; vracamo registre 
                        
000000A8  00 00 00 D8          RET 
