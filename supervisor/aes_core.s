
                PRESERVE8
                THUMB
                AREA    |.text|, CODE, READONLY

aes_core_asm   PROC
                EXPORT  aes_core_asm   
								IMPORT  Te

;32: void aes_core(unsigned int r,word32 s[4],const word32*rk){ 
   ;37:      
   ;38:         word32 t0, t1, t2, t3; 
;39:          
                PUSH     {r0-r2,r4-r7,lr}
                SUB      sp,sp,#0x08
;40:                 s[0] ^= rk[0]; 
                LDR      r4,[r1,#0x00]
                LDR      r5,[r2,#0x00]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x00]
;41:     s[1] ^= rk[1]; 
                LDR      r4,[r1,#0x04]
                LDR      r5,[r2,#0x04]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x04]
;42:     s[2] ^= rk[2]; 
                LDR      r4,[r1,#0x08]
                LDR      r5,[r2,#0x08]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x08]
;43:     s[3] ^= rk[3]; 
;44:          
                LDR      r4,[r1,#0x0C]
                LDR      r5,[r2,#0x0C]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x0C]
;45:     for (;;) { 
odd_round								

                NOP  
;46:         t0 = 
;47:             Te[0][GETBYTE(s[0], 3)]  ^ 
;48:             Te[1][GETBYTE(s[1], 2)]  ^ 
;49:             Te[2][GETBYTE(s[2], 1)]  ^ 
;50:             Te[3][GETBYTE(s[3], 0)]  ^ 
;51:             rk[4]; 
                LDR      r4,[r1,#0x00]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#704]  ; @0x000016B0//Te[0]
								LDR			 r5,=Te+0*256*4
								LDR      r4,[r5,r4]
                LDR      r5,[r1,#0x04]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#696]  ; @0x000016B4//Te[1]
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRH     r5,[r1,#0x08]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#688]  ; @0x000016B8//Te[2]
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRB     r5,[r1,#0x0C]
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#680]  ; @0x000016BC//Te[3]
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                MOV      r0,r4
                LDR      r5,[r2,#0x10]
                EORS     r0,r0,r5
;52:         t1 = 
;53:             Te[0][GETBYTE(s[1], 3)]  ^ 
;54:             Te[1][GETBYTE(s[2], 2)]  ^ 
;55:             Te[2][GETBYTE(s[3], 1)]  ^ 
;56:             Te[3][GETBYTE(s[0], 0)]  ^ 
;57:             rk[5]; 
                LDR      r4,[r1,#0x04]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#652]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[r1,#0x08]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#644]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRH     r5,[r1,#0x0C]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#632]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRB     r5,[r1,#0x00]
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#628]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                MOV      r3,r4
                LDR      r5,[r2,#0x14]
                EORS     r3,r3,r5
;58:         t2 = 
;59:             Te[0][GETBYTE(s[2], 3)] ^ 
;60:             Te[1][GETBYTE(s[3], 2)]  ^ 
;61:             Te[2][GETBYTE(s[0], 1)]  ^ 
;62:             Te[3][GETBYTE(s[1], 0)]  ^ 
;63:             rk[6]; 
                LDR      r4,[r1,#0x08]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#596]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[r1,#0x0C]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#588]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRH     r5,[r1,#0x00]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#580]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRB     r5,[r1,#0x04]
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#572]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x18]
                EORS     r4,r4,r5
                STR      r4,[sp,#0x04]
;64:         t3 = 
;65:             Te[0][GETBYTE(s[3], 3)] ^ 
;66:             Te[1][GETBYTE(s[0], 2)]  ^ 
;67:             Te[2][GETBYTE(s[1], 1)]  ^ 
;68:             Te[3][GETBYTE(s[2], 0)]  ^ 
;69:             rk[7]; 
;70:  
                LDR      r4,[r1,#0x0C]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#544]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[r1,#0x00]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#536]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRH     r5,[r1,#0x04]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#524]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRB     r5,[r1,#0x08]
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#520]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x1C]
                EORS     r4,r4,r5
                STR      r4,[sp,#0x00]
;71:         rk += 8; 
                ADDS     r2,r2,#0x20
;72:         if (--r == 0) { 
                LDR      r4,[sp,#0x08]
                SUBS     r4,r4,#1
                STR      r4,[sp,#0x08]
                CMP      r4,#0x00
                BNE      even_round
;73:             break; 
;74:         } 
;75:  
                B        final_round
even_round								
;76:         s[0] = 
;77:             Te[0][GETBYTE(t0, 3)] ^ 
;78:             Te[1][GETBYTE(t1, 2)] ^ 
;79:             Te[2][GETBYTE(t2, 1)] ^ 
;80:             Te[3][GETBYTE(t3, 0)] ^ 
;81:             rk[0]; 
                LSRS     r4,r0,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#476]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LSLS     r5,r3,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#472]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#460]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#452]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x00]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x00]
;82:         s[1] = 
;83:             Te[0][GETBYTE(t1, 3)] ^ 
;84:             Te[1][GETBYTE(t2, 2)] ^ 
;85:             Te[2][GETBYTE(t3, 1)] ^ 
;86:             Te[3][GETBYTE(t0, 0)] ^ 
;87:             rk[1]; 
                LSRS     r4,r3,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#424]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#416]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#408]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LSLS     r5,r0,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#400]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x04]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x04]
;88:         s[2] = 
;89:             Te[0][GETBYTE(t2, 3)] ^ 
;90:             Te[1][GETBYTE(t3, 2)] ^ 
;91:             Te[2][GETBYTE(t0, 1)] ^ 
;92:             Te[3][GETBYTE(t1, 0)] ^ 
;93:             rk[2]; 
                LDR      r4,[sp,#0x04]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#372]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#364]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LSLS     r5,r0,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#356]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LSLS     r5,r3,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#348]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x08]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x08]
;94:         s[3] = 
;95:             Te[0][GETBYTE(t3, 3)] ^ 
;96:             Te[1][GETBYTE(t0, 2)] ^ 
;97:             Te[2][GETBYTE(t1, 1)] ^ 
;98:             Te[3][GETBYTE(t2, 0)] ^ 
;99:             rk[3]; 
;00:     } 
;01:                  
;02:                     /* 
;03:      * apply last round and 
;04:      * map cipher state to byte array block: 
;05:      */ 
;06:  
                LDR      r4,[sp,#0x00]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#320]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LSLS     r5,r0,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#312]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LSLS     r5,r3,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#304]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#296]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x0C]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x0C]
                B        odd_round
                NOP 
final_round								
;07:     s[0] = 
;08:         (Te[4][GETBYTE(t0, 3)] & 0xff000000) ^ 
;09:         (Te[4][GETBYTE(t1, 2)] & 0x00ff0000) ^ 
;10:         (Te[4][GETBYTE(t2, 1)] & 0x0000ff00) ^ 
;11:         (Te[4][GETBYTE(t3, 0)] & 0x000000ff) ^ 
;12:         rk[0]; 
                LSRS     r4,r0,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#280]  ; @0x000016C0
								LDR			 r5,=Te+4*256*4
                LDR      r4,[r5,r4]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#24
                LSLS     r5,r3,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#268]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#16
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#248]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#8
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#228]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDRB     r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x00]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x00]
;13:     s[1] = 
;14:         (Te[4][GETBYTE(t1, 3)] & 0xff000000) ^ 
;15:         (Te[4][GETBYTE(t2, 2)] & 0x00ff0000) ^ 
;16:         (Te[4][GETBYTE(t3, 1)] & 0x0000ff00) ^ 
;17:         (Te[4][GETBYTE(t0, 0)] & 0x000000ff) ^ 
;18:         rk[1]; 
                LSRS     r4,r3,#24
                LSLS     r4,r4,#2
                MOV      r5,r6
                LDR      r4,[r5,r4]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#24
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#16
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#180]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#8
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LSLS     r5,r0,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#164]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDRB     r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x04]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x04]
;19:     s[2] = 
;20:         (Te[4][GETBYTE(t2, 3)] & 0xff000000) ^ 
;21:         (Te[4][GETBYTE(t3, 2)] & 0x00ff0000) ^ 
;22:         (Te[4][GETBYTE(t0, 1)] & 0x0000ff00) ^ 
;23:         (Te[4][GETBYTE(t1, 0)] & 0x000000ff) ^ 
;24:         rk[2]; 
                LDR      r4,[sp,#0x04]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
                MOV      r5,r6
                LDR      r4,[r5,r4]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#24
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#16
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LSLS     r5,r0,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#112]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#8
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LSLS     r5,r3,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#96]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDRB     r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x08]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x08]
;25:     s[3] = 
;26:         (Te[4][GETBYTE(t3, 3)] & 0xff000000) ^ 
;27:         (Te[4][GETBYTE(t0, 2)] & 0x00ff0000) ^ 
;28:         (Te[4][GETBYTE(t1, 1)] & 0x0000ff00) ^ 
;29:         (Te[4][GETBYTE(t2, 0)] & 0x000000ff) ^ 
;30:         rk[3]; 
;31:  
                LDR      r4,[sp,#0x00]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
                MOV      r5,r6
                LDR      r4,[r5,r4]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#24
                LSLS     r5,r0,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#16
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LSLS     r5,r3,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#48]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#8
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#32]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDRB     r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x0C]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x0C]
;32: } 
                ADD      sp,sp,#0x14
                POP      {r4-r7,pc}
                DCW      0x0000
                DCW      0x17CC
                DCW      0x0000
                DCW      0x1BCC
                DCW      0x0000
                DCW      0x1FCC
                DCW      0x0000
                DCW      0x23CC
                DCW      0x0000
                DCW      0x27CC
                DCW      0x0000
								ENDP

								LTORG

aes_core_asm_opt   PROC
                EXPORT  aes_core_asm_opt   
								IMPORT  Te

;32: void aes_core(unsigned int r,word32 s[4],const word32*rk){ 
   ;37:      
   ;38:         word32 t0, t1, t2, t3; 
;39:          
                PUSH     {r0-r2,r4-r7,lr}
                SUB      sp,sp,#0x08
;40:                 s[0] ^= rk[0]; 
                LDR      r4,[r1,#0x00]
                LDR      r5,[r2,#0x00]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x00]
;41:     s[1] ^= rk[1]; 
                LDR      r4,[r1,#0x04]
                LDR      r5,[r2,#0x04]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x04]
;42:     s[2] ^= rk[2]; 
                LDR      r4,[r1,#0x08]
                LDR      r5,[r2,#0x08]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x08]
;43:     s[3] ^= rk[3]; 
;44:          
                LDR      r4,[r1,#0x0C]
                LDR      r5,[r2,#0x0C]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x0C]
;45:     for (;;) { 
odd_round2								

                NOP  
;46:         t0 = 
;47:             Te[0][GETBYTE(s[0], 3)]  ^ 
;48:             Te[1][GETBYTE(s[1], 2)]  ^ 
;49:             Te[2][GETBYTE(s[2], 1)]  ^ 
;50:             Te[3][GETBYTE(s[3], 0)]  ^ 
;51:             rk[4]; 
                ;LDR      r4,[r1,#0x00]
                ;LSRS     r4,r4,#24
								LDRB     r4, [r1,#0x03]
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#704]  ; @0x000016B0//Te[0]
								LDR			 r5,=Te+0*256*4
								LDR      r4,[r5,r4]
                ;LDR      r5,[r1,#0x04]
                ;LSLS     r5,r5,#8
                ;LSRS     r5,r5,#24
								LDRB     r5,[r1,#0x06]
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#696]  ; @0x000016B4//Te[1]
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRH     r5,[r1,#0x08]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#688]  ; @0x000016B8//Te[2]
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRB     r5,[r1,#0x0C]
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#680]  ; @0x000016BC//Te[3]
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                MOV      r0,r4
                LDR      r5,[r2,#0x10]
                EORS     r0,r0,r5
;52:         t1 = 
;53:             Te[0][GETBYTE(s[1], 3)]  ^ 
;54:             Te[1][GETBYTE(s[2], 2)]  ^ 
;55:             Te[2][GETBYTE(s[3], 1)]  ^ 
;56:             Te[3][GETBYTE(s[0], 0)]  ^ 
;57:             rk[5]; 
                LDR      r4,[r1,#0x04]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#652]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[r1,#0x08]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#644]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRH     r5,[r1,#0x0C]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#632]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRB     r5,[r1,#0x00]
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#628]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                MOV      r3,r4
                LDR      r5,[r2,#0x14]
                EORS     r3,r3,r5
;58:         t2 = 
;59:             Te[0][GETBYTE(s[2], 3)] ^ 
;60:             Te[1][GETBYTE(s[3], 2)]  ^ 
;61:             Te[2][GETBYTE(s[0], 1)]  ^ 
;62:             Te[3][GETBYTE(s[1], 0)]  ^ 
;63:             rk[6]; 
                LDR      r4,[r1,#0x08]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#596]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[r1,#0x0C]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#588]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRH     r5,[r1,#0x00]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#580]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRB     r5,[r1,#0x04]
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#572]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x18]
                EORS     r4,r4,r5
                STR      r4,[sp,#0x04]
;64:         t3 = 
;65:             Te[0][GETBYTE(s[3], 3)] ^ 
;66:             Te[1][GETBYTE(s[0], 2)]  ^ 
;67:             Te[2][GETBYTE(s[1], 1)]  ^ 
;68:             Te[3][GETBYTE(s[2], 0)]  ^ 
;69:             rk[7]; 
;70:  
                LDR      r4,[r1,#0x0C]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#544]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[r1,#0x00]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#536]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRH     r5,[r1,#0x04]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#524]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDRB     r5,[r1,#0x08]
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#520]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x1C]
                EORS     r4,r4,r5
                STR      r4,[sp,#0x00]
;71:         rk += 8; 
                ADDS     r2,r2,#0x20
;72:         if (--r == 0) { 
                LDR      r4,[sp,#0x08]
                SUBS     r4,r4,#1
                STR      r4,[sp,#0x08]
                CMP      r4,#0x00
                BNE      even_round2
;73:             break; 
;74:         } 
;75:  
                B        final_round2
even_round2								
;76:         s[0] = 
;77:             Te[0][GETBYTE(t0, 3)] ^ 
;78:             Te[1][GETBYTE(t1, 2)] ^ 
;79:             Te[2][GETBYTE(t2, 1)] ^ 
;80:             Te[3][GETBYTE(t3, 0)] ^ 
;81:             rk[0]; 
                LSRS     r4,r0,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#476]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LSLS     r5,r3,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#472]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#460]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#452]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x00]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x00]
;82:         s[1] = 
;83:             Te[0][GETBYTE(t1, 3)] ^ 
;84:             Te[1][GETBYTE(t2, 2)] ^ 
;85:             Te[2][GETBYTE(t3, 1)] ^ 
;86:             Te[3][GETBYTE(t0, 0)] ^ 
;87:             rk[1]; 
                LSRS     r4,r3,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#424]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#416]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#408]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LSLS     r5,r0,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#400]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x04]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x04]
;88:         s[2] = 
;89:             Te[0][GETBYTE(t2, 3)] ^ 
;90:             Te[1][GETBYTE(t3, 2)] ^ 
;91:             Te[2][GETBYTE(t0, 1)] ^ 
;92:             Te[3][GETBYTE(t1, 0)] ^ 
;93:             rk[2]; 
                LDR      r4,[sp,#0x04]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#372]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#364]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LSLS     r5,r0,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#356]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LSLS     r5,r3,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#348]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x08]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x08]
;94:         s[3] = 
;95:             Te[0][GETBYTE(t3, 3)] ^ 
;96:             Te[1][GETBYTE(t0, 2)] ^ 
;97:             Te[2][GETBYTE(t1, 1)] ^ 
;98:             Te[3][GETBYTE(t2, 0)] ^ 
;99:             rk[3]; 
;00:     } 
;01:                  
;02:                     /* 
;03:      * apply last round and 
;04:      * map cipher state to byte array block: 
;05:      */ 
;06:  
                LDR      r4,[sp,#0x00]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#320]  ; @0x000016B0
								LDR			 r5,=Te+0*256*4
                LDR      r4,[r5,r4]
                LSLS     r5,r0,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#312]  ; @0x000016B4
								LDR			 r6,=Te+1*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LSLS     r5,r3,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#304]  ; @0x000016B8
								LDR			 r6,=Te+2*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#296]  ; @0x000016BC
								LDR			 r6,=Te+3*256*4
                LDR      r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x0C]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x0C]
                B        odd_round2
                NOP 
final_round2							
;07:     s[0] = 
;08:         (Te[4][GETBYTE(t0, 3)] & 0xff000000) ^ 
;09:         (Te[4][GETBYTE(t1, 2)] & 0x00ff0000) ^ 
;10:         (Te[4][GETBYTE(t2, 1)] & 0x0000ff00) ^ 
;11:         (Te[4][GETBYTE(t3, 0)] & 0x000000ff) ^ 
;12:         rk[0]; 
                LSRS     r4,r0,#24
                LSLS     r4,r4,#2
;                LDR      r5,[pc,#280]  ; @0x000016C0
								LDR			 r5,=Te+4*256*4
                LDR      r4,[r5,r4]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#24
                LSLS     r5,r3,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#268]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#16
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#248]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#8
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#228]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDRB     r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x00]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x00]
;13:     s[1] = 
;14:         (Te[4][GETBYTE(t1, 3)] & 0xff000000) ^ 
;15:         (Te[4][GETBYTE(t2, 2)] & 0x00ff0000) ^ 
;16:         (Te[4][GETBYTE(t3, 1)] & 0x0000ff00) ^ 
;17:         (Te[4][GETBYTE(t0, 0)] & 0x000000ff) ^ 
;18:         rk[1]; 
                LSRS     r4,r3,#24
                LSLS     r4,r4,#2
                MOV      r5,r6
                LDR      r4,[r5,r4]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#24
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#16
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#180]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#8
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LSLS     r5,r0,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#164]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDRB     r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x04]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x04]
;19:     s[2] = 
;20:         (Te[4][GETBYTE(t2, 3)] & 0xff000000) ^ 
;21:         (Te[4][GETBYTE(t3, 2)] & 0x00ff0000) ^ 
;22:         (Te[4][GETBYTE(t0, 1)] & 0x0000ff00) ^ 
;23:         (Te[4][GETBYTE(t1, 0)] & 0x000000ff) ^ 
;24:         rk[2]; 
                LDR      r4,[sp,#0x04]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
                MOV      r5,r6
                LDR      r4,[r5,r4]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#24
                LDR      r5,[sp,#0x00]
                LSLS     r5,r5,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#16
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LSLS     r5,r0,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#112]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#8
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LSLS     r5,r3,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#96]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDRB     r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x08]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x08]
;25:     s[3] = 
;26:         (Te[4][GETBYTE(t3, 3)] & 0xff000000) ^ 
;27:         (Te[4][GETBYTE(t0, 2)] & 0x00ff0000) ^ 
;28:         (Te[4][GETBYTE(t1, 1)] & 0x0000ff00) ^ 
;29:         (Te[4][GETBYTE(t2, 0)] & 0x000000ff) ^ 
;30:         rk[3]; 
;31:  
                LDR      r4,[sp,#0x00]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#2
                MOV      r5,r6
                LDR      r4,[r5,r4]
                LSRS     r4,r4,#24
                LSLS     r4,r4,#24
                LSLS     r5,r0,#8
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#16
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LSLS     r5,r3,#16
                LSRS     r5,r5,#24
                LSLS     r5,r5,#2
;                LDR      r6,[pc,#48]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDR      r5,[r6,r5]
                MOVS     r6,#0xFF
                LSLS     r6,r6,#8
                ANDS     r5,r5,r6
                EORS     r4,r4,r5
                LDR      r5,[sp,#0x04]
                LSLS     r5,r5,#24
                LSRS     r5,r5,#22
;                LDR      r6,[pc,#32]  ; @0x000016C0
								LDR			 r6,=Te+4*256*4
                LDRB     r5,[r6,r5]
                EORS     r4,r4,r5
                LDR      r5,[r2,#0x0C]
                EORS     r4,r4,r5
                STR      r4,[r1,#0x0C]
;32: } 
                ADD      sp,sp,#0x14
                POP      {r4-r7,pc}
                ENDP

								ALIGN


                END


