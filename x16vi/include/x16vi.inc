;;;
;; Ascii -> PETSCII
;;;
        .enc "petscii"  ;define an ascii->petscii encoding
        .cdef " @", 32  ;characters
        .cdef "AZ", $c1
        .cdef "az", $41
        .cdef "[[", $5b
        .cdef "££", $5c
        .cdef "]]", $5d
        .cdef "ππ", $5e
        .cdef $2190, $2190, $1f;left arrow

        .edef "\n", 13  ;one byte control codes
        .edef "{clr}", 147
        .edef "{crlf}", [13, 10];two byte control code
        .edef "<nothing>", [];replace with no bytes

;;;
;; Kernel subroutines
;;;

        BSOUT   = $ffd2         ; Print a character stored in A on screen
        BSIN    = $ffff         ; Read a character from .. and store it in A

;;;
;; Zero page variables
;;;
        zero_page = $20
