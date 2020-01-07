        .cpu "w65c02" ;;; Make sure we can use all goodies from WDC65C02
        .include "kernel.inc"
        .include "x16ed.inc"

        ;;; start address just after "10 sys 2064"
        * = $0801

        ;;; BASIC for 10 SYS (2064)
        .byte $0e, $08, $0a, $00, $9e, $20, $28, $32, $30, $36, $34, $29, $00, $00, $00
        * = $0810

        jsr set_mode
        jsr clear_screen
        sei
        lda kernal_irq_v
        sta irq_v_low
        lda kernal_irq_v + 1
        sta irq_v_high
        lda #<xed_irq
        sta kernal_irq_v
        lda #>xed_irq
        sta kernal_irq_v + 1
        cli
        ldx #0
        ldy #0
        clc
        jsr plot
next:
        jsr getin
        jsr chrin
        jsr chrout
        bra next

xed_irq:
        FPS = 50 ;; 60 on NTSC

        CursorBlinkCounter = $ee
        CursorLit = $ef
        CursorPointer = $ea ;; check rom for the cursor pointer

        ;; Blink cursor
        inc CursorBlinkCounter
        lda CursorBlinkCounter
        cmp #FPS/2
        bne isr_l100
        stz CursorBlinkCounter ;; you can use stz ;)
        lda CursorLit
        eor #$80
        sta CursorLit
        lda (CursorPointer)
        eor #$80
        sta (CursorPointer)
isr_l100:
        jmp (irq_v)


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
        ldy #0
clsc01:
        sty vera_hi
        stz vera_lo
        ldx #80
clsc02:
        lda #32
        sta vera_rw
        lda #blue << 4 | white
        sta vera_rw
        dex
        bne clsc02
        iny
        cpy #60
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
