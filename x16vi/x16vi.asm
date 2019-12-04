        .cpu "w65c02" ;;; Make sure we can use all goodies from WDC65C02
        .include "x16vi.inc"

        ;;; start address just after "10 sys 2064"
        * = $0801

        ;;; BASIC for 10 SYS (2064)
        .byte $0e, $08, $0a, $00, $9e, $20, $28, $32, $30, $36, $34, $29, $00, $00, $00
        * = $0810

        ldx #0
next:
        lda hello,x
        beq done
        jsr $ffd2
        inx
        bra next
done:
        rts
hello   .null "hello world"
