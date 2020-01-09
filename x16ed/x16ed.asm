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
        ; jsr chrin ; BASIC INPUT routine. Blinks cursor.
        jsr chrout
        bra next


;;;
;; ISR for blinking cursor.
;; TODO: when moving cursor restore original character so an inverted character is not displayed.
;; TODO: fix x-position, blinking only works in first column.
;;;
xed_irq:
        pha
        phx
        phy
        ;; Blink cursor
        inc cursor_blink_counter
        lda cursor_blink_counter
        cmp #FPS/2
        bne isr_l100
        stz cursor_blink_counter
        ; get x, y of cursor position
        sec
        jsr plot
        stx y_pos
        stz y_pos + 1
        sty x_pos

        ; calculate vera memory position of x, y (curs_vera_pos)
        ; curs_vera_pos = y_pos * 256 + x_pos * 2
        ldy #8
mul256:
        asl y_pos
        rol y_pos + 1
        dey
        bne mul256
        asl x_pos               ; x_pos * 2
        lda y_pos               ; Add y_pos
        clc
        adc x_pos
        sta curs_vera_pos       ; and store address
        lda y_pos + 1
        adc #0                  ; Add carry
        sta curs_vera_pos + 1

        ; get character at curs_vera_pos and invert bit 7
        ldy #0
        ldx curs_vera_pos + 1
        lda curs_vera_pos
        jsr set_vera_hml
        lda vera_rw
        eor #$80
        ; store new character at curs_vera_pos
        sta vera_rw
isr_l100:
        ply
        plx
        pla
        jmp (irq_v)


set_vera_hml: .proc
        sta vera_low
        stx vera_middle
        sty vera_high
        rts
        .pend

set_mode: .proc
        lda #$0f            ;Bank 4
        sta vera_low
        stz vera_middle
        lda #$41            ;H-scale
        sta vera_high
        ldy text_mode
        lda modex,y
        sta vera_rw
        lda #$42            ;V-scale
        sta vera_high
        lda modey,y
        sta vera_rw
        stz vera_low        ;Bank 0
        lda sizex,y
        sta scr_size_x
        lda sizey,y
        sta scr_size_y
        rts
        .pend

clear_screen: .proc
        lda #%00010000      ;Set VERA increment to 1
        sta vera_low
        ldy #0
clsc01:
        sty vera_middle
        stz vera_high
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
