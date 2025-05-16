;color copy v0.1
;copy a screen of color to screen
;show the frames in a ping-pong loop
;

dir=$02

                        ;Enable RUN from BASIC
*=$0801                 ;2025 sys2061
        byte $0b,$08,$e9,$07            ;line number (year)
        byte $9e, "2","0","6","1",0,0,0 ;sys 2061


*=$080D                 ;this is address 2061 (not rly needed)
        sei             ;kill interrupts
        lda #$35        ;show memory under rom
        sta $01
        ldx #0
        ldy #0
        lda #160

lop0                    ;setup screen, fill with #160

        sta $0400,x
        sta $0500,x
        sta $0600,x
        sta $0700,x
        inx
        bne lop0
        lda #0  
        sta dir         ;direction

        ;show a frame
start
        ;inc $d020
lop1
m1      lda $1000,x
        sta $d800,x
m2      lda $1100,x
        sta $d900,x
m3      lda $1200,x
        sta $da00,x
m4      lda $1300,x
        sta $db00,x
        inx
        bne lop1

        ;determine diretion
        lda dir
        ;cmp #1
        bne nxm0

        ;add source address
        ;$d800
        ;go plus
        clc
        lda m1+2
        adc #4
        sta m1+2
        bcc nx1


nx1
        ;$d900
        clc
        lda m2+2
        adc #4
        sta m2+2


nx2     
        ;$da00
        clc
        lda m3+2
        adc #4
        sta m3+2

nx3       
        ;$db00
        clc
        lda m4+2
        adc #4
        sta m4+2

nx4    
        lda m1+2
        cmp #$cc        ;did we spend all memory?
        bne raststartwait
        inc dir         ;if so, change direction
        jmp raststartwait



nxm0    
        ;go minus
        clc
        lda m1+2
        sbc #3
        sta m1+2
        bcc nxm1


nxm1
        ;$d900
        clc
        lda m2+2
        sbc #3
        sta m2+2


nxm2     
        ;$da00
        clc
        lda m3+2
        sbc #3
        sta m3+2

nxm3       
        ;$db00
        clc
        lda m4+2
        sbc #3
        sta m4+2

nxm4    
        lda m1+2
        cmp #$10
        bne raststartwait
        dec dir
        ;jmp raststartwait


raststartwait
        ldy #16     ; wait 16 frames for each update
                    ; too fast, and it looks chaotic

strast

        lda #250
rastwait
        cmp $d012
        bne rastwait
        dey
        bne rastwait
        jmp start
        rts

*=$1000

incbin "coldata.seq"