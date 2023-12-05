*=$6000
.import binary "6000.dat"
*=$7000
.import binary "7000.dat"
*=$8000
.import binary "8000.dat"
*=$9000
//  foreground & background black
        lda #$00 //.c:6700  a9 00       
        sta $d020 //.c:6702  8d 20 d0    
        sta $d021 //.c:6705  8d 21 d0    
// char colors=0e
        lda #$0e //.c:6708  a9 0e       
        sta $0286 //.c:670a  8d 86 02    
//  clear the screen
       jsr $e544 //.c:670d  20 44 e5    
// Extended Background Color Mode
        lda #$d8 //.c:6710  a9 d8       
        sta $d016 // .c:6712  8d 16 d0    
// Extra Background Color #1
        lda #$03 //.c:6715  a9 03       
        sta $d022 // .c:6717  8d 22 d0    
// Extra Background Color #2
        lda #$0e // .c:671a  a9 0e       
        sta $d023 //.c:671c  8d 23 d0    
//screen memory = 24*1024 = $6000
        lda #$18 //.c:671f  a9 18       
        sta $d018 //.c:6721  8d 18 d0    
//         
        lda #$ff // .c:6724  a9 ff       
        sta $fa //.c:6726  85 fa       
        lda #$68 //.c:6728  a9 68       
        sta aaa+2 //.c:672a  8d 36 67    
        lda #$20 //.c:672d  a9 20       
        sta bbb+2 //.c:672f  8d 39 67    
 ccc:   ldx #$00 // .c:6732  a2 00       
 aaa:   lda zzz,x // .c:6734  bd 00 70    
 bbb:   sta $2800,x // .c:6737  9d 00 28    
        inx //.c:673a  e8          
        bne aaa // .c:673b  d0 f7       
        inc aaa+2 //.c:673d  ee 36 67    
        inc bbb+2 // .c:6740  ee 39 67    
        lda aaa+2 // .c:6743  ad 36 67    
        cmp #$70 // .c:6746  c9 70       
        bne ccc // .c:6748  d0 e8       
 hhh:   inc $fa // .c:674a  e6 fa       
        lda #$0b // .c:674c  a9 0b       
        sta $d011 //.c:674e  8d 11 d0    
        lda $fa //.c:6751  a5 fa       
        cmp #$16 // .c:6753  c9 16       
        beq ddd //.c:6755  f0 22       
        sta $3000 // .c:6757  8d 00 30    
        jsr jjj // .c:675a  20 a8 70    
        lda #$1b // .c:675d  a9 1b       
        sta $d011 // .c:675f  8d 11 d0    
        jsr iii // .c:6762  20 68 67    
        jmp hhh // .c:6765  4c 4a 67    
 iii:   ldx #$00 // .c:6768  a2 00       
 ggg:   ldy #$00 // .c:676a  a0 00       
 fff:   iny // .c:676c  c8          
 eee:   inc $fb // .c:676d  e6 fb       
        lda $fb //.c:676f  a5 fb       
        bne eee // .c:6771  d0 fa       
        bne fff // .c:6773  d0 f7       
        inx //.c:6775  e8          
        bne ggg //.c:6776  d0 f2       
        rts // .c:6778  60          
     ddd:   lda #$ff //.c:6779  a9 ff       
        sta $fa // .c:677b  85 fa       
        jmp hhh //.c:677d  4c 4a 67    

//----------------------
zzz:    sta nnn // .c:7000  8d 47 70    
        txa // .c:7003  8a          
        pha // .c:7004  48          
        tya // .c:7005  98          
        pha // .c:7006  48          
        lda #$ff // .c:7007  a9 ff       
        sta ooo+2 // .c:7009  8d 3d 70    
        sty ppp // .c:700c  8c 46 70    
        stx qqq+1 // .c:700f  8e 26 70    
        lda #$d8 // .c:7012  a9 d8       
        ldx #$ff // .c:7014  a2 ff       
sss:    inx // .c:7016  e8          
        clc // .c:7017  18          
        adc #$28 // .c:7018  69 28       
        bcc rrr // .c:701a  90 03       
        inc ooo+2 // .c:701c  ee 3d 70    
rrr:    cpx ppp // .c:701f  ec 46 70    
        bne sss // .c:7022  d0 f2       
        clc // .c:7024  18          
qqq:    adc #$27 // .c:7025  69 27       
        bcc ttt // .c:7027  90 03       
        inc ooo+2 // .c:7029  ee 3d 70    
ttt:    sta ooo+1 // .c:702c  8d 3c 70    
        lda ooo+2 // .c:702f  ad 3d 70    
        clc // .c:7032  18          
        adc #$04 // .c:7033  69 04       
        sta ooo+2 // .c:7035  8d 3d 70    
        lda nnn // .c:7038  ad 47 70    
ooo:    sta $07e7 //.c:703b  8d e7 07    
        pla // .c:703e  68          
        tay // .c:703f  a8          
        pla // .c:7040  68          
        tax // .c:7041  aa              
        lda nnn //.c:7042  ad 47 70    
        rts // .c:7045  60          
ppp:    clc //.c:7046  18          
nnn:    bmi uuu // .c:7047  30 00       
uuu:    brk // .c:7049  00          
        brk // .c:704a  00          
        brk // .c:704b  00          
        brk // .c:704c  00          
        brk // .c:704d  00          
        brk // .c:704e  00          
jj1:    brk // .c:704f  00          
        bvs vvv+1 // .c:7050  70 20       
        .byte $6a // ror a // .c:7052  6a          
        clv // .c:7053  b8          
        jsr $708d // .c:7054  20 8d 70    
        jsr $bc0c // .c:7057  20 0c bc    
        jsr yyy // .c:705a  20 92 70    
        ldy $fc // .c:705d  a4 fc       
        lda #$00 // .c:705f  a9 00       
        sty $63 // .c:7061  84 63       
        sta $62 // .c:7063  85 62       
        ldx #$90 // .c:7065  a2 90       
        sec // .c:7067  38          
        jsr $bc49 // .c:7068  20 49 bc    
        jsr www // .c:706b  20 8d 70    
        jsr $b86a // .c:706e  20 6a b8    
vvv:    jsr www // .c:7071  20 8d 70    
        jsr $b7f7 // .c:7074  20 f7 b7    
        lda $14 // .c:7077  a5 14       
        sta xxx+1 //.c:7079  8d 84 70    
        lda $15 // .c:707c  a5 15       
        sta xxx+2 // .c:707e  8d 85 70    
        lda $fb // .c:7081  a5 fb       
 xxx:   sta $07e7 // .c:7083  8d e7 07    
        lda $fb // .c:7086  a5 fb       
        ldx $fc // .c:7088  a6 fc       
        ldy $fd // .c:708a  a4 fd       
        rts // .c:708c  60          
www:    lda #$01 // .c:708d  a9 01       
        sta $66 // .c:708f  85 66       
        rts // .c:7091  60          
yyy:    lda #$01 // .c:7092  a9 01       
        sta $6e // .c:7094  85 6e       
        rts // .c:7096  60          
        ldx #$00 // .c:7097  a2 00       
        ldy #$00 // .c:7099  a0 00       
        lda #$20 // .c:709b  a9 20       
        jsr zzz // .c:709d  20 00 70    
        rts // .c:70a0  60          

mmm:    jsr $0230 // .c:70a1  20 30 02    
ii1:    slo ($1e),y //.c:70a4  13 1e       
        bit $11 //.c:70a6  24 11       

jjj:    pha //.c:70a8  48          
        jsr $e544 //.c:70a9  20 44 e5    
        nop //.c:70ac  ea          
        nop //.c:70ad  ea          
        nop // .c:70ae  ea          
        pla //.c:70af  68          
        jsr kkk //.c:70b0  20 1c 71    
        jsr lll // .c:70b3  20 42 71    
        rts // .c:70b6  60          
pp1:    lda #$00 // .c:70b7  a9 00       
        sta mmm // .c:70b9  8d a1 70    
ff1:    ldy #$11 // .c:70bc  a0 11       
bb1:    ldx #$24 // .c:70be  a2 24       
aa1:    txa // .c:70c0  8a          
        pha // .c:70c1  48          
        ldx mmm // .c:70c2  ae a1 70    
cc1:    lda $7340,x // .c:70c5  bd 40 73    
        sta mmm+1 // .c:70c8  8d a2 70    
        inc mmm // .c:70cb  ee a1 70    
        pla // .c:70ce  68          
        tax // .c:70cf  aa          
        lda mmm+2 // .c:70d0  ad a2 70    
        jsr zzz // .c:70d3  20 00 70    
        inx // .c:70d6  e8          
gg1:    cpx #$28 // .c:70d7  e0 28       
        bne aa1 // .c:70d9  d0 e5       
        iny // .c:70db  c8          
hh1:    cpy #$19 // .c:70dc  c0 19       
        bne bb1 // .c:70de  d0 de       
        rts // .c:70e0  60          
nn1:    sta mmm+2 // .c:70e1  8d a3 70    
        lda #$e0 // .c:70e4  a9 e0       
        sta cc1+1 // .c:70e6  8d c6 70    
        lda #$72 // .c:70e9  a9 72       
        sta cc1+2 // .c:70eb  8d c7 70    
        ldx #$ff // .c:70ee  a2 ff       
ee1:        inx // .c:70f0  e8          
        clc // .c:70f1  18          
        lda cc1+1 // .c:70f2  ad c6 70    
        adc #$20 // .c:70f5  69 20       
        sta cc1+1 // .c:70f7  8d c6 70    
        cmp #$00 // .c:70fa  c9 00       
        bne dd1 // .c:70fc  d0 03       
        inc cc1+2 // .c:70fe  ee c7 70    
dd1:    cpx mmm+2 // .c:7101  ec a3 70    
        bne ee1 // .c:7104  d0 ea       
        rts // .c:7106  60          
oo1:    stx bb1+1 // .c:7107  8e bf 70    
        sty ff1+1 // .c:710a  8c bd 70    
        clc // .c:710d  18          
        txa // .c:710e  8a          
        adc #$04 // .c:710f  69 04       
        sta gg1+1 // .c:7111  8d d8 70    
        clc // .c:7114  18          
        tya // .c:7115  98          
        adc #$08 // .c:7116  69 08       
        sta hh1+1 // .c:7118  8d dd 70    
        rts // .c:711b  60          
kkk:    sta ii1 // .c:711c  8d a4 70    
        lda #$e0 // .c:711f  a9 e0       
        sta jj1 // .c:7121  8d 4f 71    
        lda #$7f // .c:7124  a9 7f       
        sta jj1+1 // .c:7126  8d 50 71    
        ldx #$ff // .c:7129  a2 ff       
mm1:    inx // .c:712b  e8          
        clc // .c:712c  18          
        lda jj1 // .c:712d  ad 4f 71    
        adc #$20 // .c:7130  69 20       
        sta jj1 // .c:7132  8d 4f 71    
        cmp #$00 // .c:7135  c9 00       
        bne kk1 // .c:7137  d0 03       
        inc ll1+2 // .c:7139  ee 50 71    
kk1:    cpx ii1 // .c:713c  ec a4 70    
        bne mm1 // .c:713f  d0 ea       
        rts // .c:7141  60          
lll:    ldx #$00 // .c:7142  a2 00       
        ldy #$01 // .c:7144  a0 01       
        stx $70a5 // .c:7146  8e a5 70    
ss1:    txa // .c:7149  8a          
        pha // .c:714a  48          
        ldx ii1+1 // .c:714b  ae a5 70    
ll1:    lda $8260,x // .c:714e  bd 60 82    
        jsr nn1 // .c:7151  20 e1 70    
        pla // .c:7154  68          
        tax // .c:7155  aa          
        stx ii1+2 // .c:7156  8e a6 70    
        sty ii1+3 // .c:7159  8c a7 70    
        jsr oo1 // .c:715c  20 07 71    
        jsr pp1 // .c:715f  20 b7 70    
        ldx ii1+2 // .c:7162  ae a6 70    
        ldy ii1+3 // .c:7165  ac a7 70    
        inc ii1+1 // .c:7168  ee a5 70    
        inx // .c:716b  e8          
        inx // .c:716c  e8          
        inx // .c:716d  e8          
        inx // .c:716e  e8          
        cpx #$28 // .c:716f  e0 28       
        bne qq1 // .c:7171  d0 0a       
        iny // .c:7173  c8          
        iny // .c:7174  c8          
        iny // .c:7175  c8          
        iny // .c:7176  c8          
        iny // .c:7177  c8          
        iny // .c:7178  c8          
        iny // .c:7179  c8          
        iny // .c:717a  c8          
        ldx #$00 // .c:717b  a2 00       
qq1:    cpy #$19 // .c:717d  c0 19       
        bne rr1 // .c:717f  d0 01       
        rts // .c:7181  60          
rr1:    jmp ss1 // .c:7182  4c 49 71    



