        .cpu "w65c02" ;;; Make sure we can use all goodies from WDC65C02
        .include "x16ed.inc"

        ;;; start address just after "10 sys 2064"
        * = $0801

        ;;; BASIC for 10 SYS (2064)
        .byte $0e, $08, $0a, $00, $9e, $20, $28, $32, $30, $36, $34, $29, $00, $00, $00
        * = $0810

        jsr set_mode
        jsr clear_screen
next:
        jsr getin
        jsr chrout
        inx
        bra next
done:
        rts
hello   .null "hello world"

set_mode: .proc
        lda #$0f            ;Bank 4
        sta vera_inc
        stz vera_hi
        lda #$41            ;H-scale
        sta vera_lo
        ldy text_mode
        lda modex,y
        sta vera_rw
        lda #$42            ;V-scale
        sta vera_lo
        lda modey,y
        sta vera_rw
        stz vera_inc        ;Bank 0
        lda sizex,y
        sta scr_size_x
        lda sizey,y
        sta scr_size_y
        rts
        .pend

clear_screen: .proc
        lda #%00010000      ;Set VERA increment to 1
        sta vera_inc
        stz vera_hi
        stz vera_lo
        ldy #60
clsc01:
        inc vera_hi
        ldx #80
clsc02:
        lda #32
        sta vera_rw
        lda #1
        sta vera_rw
        dex
        bne clsc02
        dey
        bne clsc01
        rts
        .pend

modex:  .byte 128,128,64,64,32,32
modey:  .byte 128,64,128,64,64,32
sizex:  .byte 80,80,40,40,20,20
sizey:  .byte 60,30,60,30,30,15
text_mode:
        .byte 0             ;Default 0=80x60
scr_size_x:
        .byte   80          ;Screen size X (20, 40, or 80)
scr_size_y;
        .byte   60          ;Screen size Y (15, 30, or 60)