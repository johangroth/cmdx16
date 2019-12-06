;;;
;; Kernel subroutines
;;;

        acptr = $ffa5           ;Input byte from serial port
        chkin = $ffc6           ;Open channel for input
        chkout= $ffc9           ;Open channel for output
        chrin = $ffcf           ;Input character from channel
        chrout= $ffd2           ;Output character to channel
        ciout = $ffa8           ;Output byte to serial port
        cint  = $ff81           ;Initialise the VERA chip and upload the PETSCII graphics character set
        clall = $ffe7           ;Close all channels and files
        close = $ffc3           ;Close a specified logical file
        clrchn= $ffcc           ;Close input and output channels
        getin = $ffe4           ;Get character from keyboard queue (keyboard buffer)

        iobase= $fff3           ;Returns base address of I/O devices (returns $9f60, first VIA)
        ioinit= $ff84           ;Initialise input/output
        jsrfar= $ff6e           ;Jump to subroutines in other banks than current one
        listen= $ffb1           ;Command devices on the serial bus to LISTEN

        load  = $ffd5           ;Load RAM from a device
        membot= $ff9c           ;Read/set the bottom of memory
        memtop= $ff99           ;Read/set the top of memory
        open  = $ffc0           ;Open a logical file
        plot  = $fff0           ;Read (SEC)/set (CLC) X .Y, Y .X cursor position
        ramtas= $ff87           ;Initialise RAM, allocate tape buffer, set screen $0400

        rdtim = $ffde           ;Read real time clock
        readst= $ffb7           ;Read I/O status word
        restor= $ff8a           ;Restore default I/O vectors
        save  = $ffd8           ;Save RAM to device
        scnkey= $ff9f           ;Scan keyboard
        screen= $ffed           ;Return X,Y organization of screen
        second= $ff93           ;Send secondary address after LISTEN
        setlfs= $ffba           ;Set logical, first and secondary addresses
        setmsg= $ff90           ;Control KERNAL messages
        setnam= $ffbd           ;Set file name
        settim= $ffdb           ;Set real time clock
        settmo= $ffa2           ;Set timeout on serial bus (no-op since VIC-20)
        stop  = $ffe1           ;Scan stop key
        talk  = $ffb4           ;Command serial bus device to TALK
        tksa  = $ff96           ;Send secondary address after TALK
        udtim = $ffea           ;Increment real time clock
        unlsn = $ffae           ;Command serial bus to UNLISTEN
        untlk = $ffab           ;Command serial bus to UNTALK
        vector= $ff8d           ;Read/set vectored I/O
