;;;
;; Struct line_lnk_s
;; line_lnk_s is a linked list which holds the address to
;; previous, current and next line in the editor. As the editor data lives in banked RAM
;; we have to keep track of the bank as well as the address.
;;;
line_lnk_s: .struct
        bank_previous_line:     .byte 0         ;Bank number to previous line
        offset_previous_line:   .word 0         ;Offset to previous line, 0 if first line

        bank_next_line:         .byte 0         ;Bank number to next line
        offset_next_line:       .word 0         ;Offset to next line, 0 if last line

        line_data:              .byte 0         ;Max 80 bytes of line data.
        .ends

;;;
;; ASCII -> PETSCII
;;;
        .enc "petscii"  ;define an ascii->petscii encoding
        .cdef " @", 32  ;characters
        .cdef "AZ", $c1
        .cdef "az", $41
        .cdef "[[", $5b
        .cdef "££", $5c
        .cdef "]]", $5d
        .cdef "€€", $5e
        .cdef $2190, $2190, $1f;left arrow

        .edef "\n", 13  ;one byte control codes
        .edef "{clr}", 147
        .edef "{crlf}", [13, 10];two byte control code
        .edef "<nothing>", [];replace with no bytes

;;;
;; VERA constants
;;;
        vera_high  = $9f20
        vera_middle  = $9f21
        vera_low = $9f22
        vera_rw  = $9f23

;;;
;;  C-64 colours
;;;
        black = 0
        white = 1
        red = 2
        cyan = 3
        purple = 4
        green = 5
        blue = 6
        yellow = 7
        orange = 8
        brown = 9
        light_red = $a
        gray1 = $b
        gray2 = $c
        light_green = $d
        light_blue = $e
        gray3 = $f


;;;
;; Constants
;;;
        FPS = 50 ;; 60 on NTSC

;;;
;; Zero page variables
;;;
        zero_page               = $20
        irq_v                   = $21
        irq_v_low               = $21
        irq_v_high              = $22
        cursor_blink_counter    = $23
        cursor_lit              = $24
        cursor_pointer          = $25 ;; check rom for the cursor pointer
        y_pos                   = $26
        x_pos                   = $28
        curs_vera_pos           = $29
