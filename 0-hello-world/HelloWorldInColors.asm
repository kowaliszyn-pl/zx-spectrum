        DEVICE ZXSPECTRUMNEXT

; System ROM routines
ROM_PRINT_A  EQU $0010
ROM_CLS      EQU $0D6B
ROM_CHAN_OPEN EQU $1601
ROM_SET_BORDER EQU $22A3

; System variables
SYS_BORDCR   EQU 23624
SYS_ATTR_P   EQU 23693

        ORG $8000

START:
        ; Set colors: yellow (6) text on blue (1) background
        ; 10 PAPER 1: INK 6
        LD A, %00001110
        LD (SYS_ATTR_P), A

        ; BORDER 1 (and lower screen)
        ;LD A, %00111011
        LD (SYS_BORDCR), A
        ;LD A, 1
        ;CALL ROM_SET_BORDER

        LD A, 1
        OUT ($FE),A

        ; Clear the screen
        ; 20 CLS
        CALL ROM_CLS

        ; Open screen channel
        LD A, 2
        CALL ROM_CHAN_OPEN

        ; Display text
        ; 40 PRINT "Hello, world!"
        LD HL, TEXT_DB

PRINT_HELLO_WORD:
        LD A, (HL)
        CP 255
        JR Z, PRINT_NEW_LINE

        RST ROM_PRINT_A
        INC HL
        JR PRINT_HELLO_WORD

PRINT_NEW_LINE:
        ; 50 PRINT - newline
        LD A, 13  ; ASCII code for carriage return (newline)
        RST ROM_PRINT_A
        ;RST ROM_PRINT_A
        ;RST ROM_PRINT_A

        ; 70 PRINT "Press any key to end the program"
        LD HL, PROMPT_DB

PRINT_PROMPT:
        LD A, (HL)
        CP 255
        JR Z, PAUSE_0

        RST ROM_PRINT_A
        INC HL
        JR PRINT_PROMPT

PAUSE_0:
        ; Wait for a key press

WAIT:
        JR WAIT

TEXT_DB:
        DB "Hello, world!", 13, 255

PROMPT_DB:
        DB "Press any key...", 13, 255

; NEX file configuration
        SAVENEX OPEN "HelloWorldInColors.nex", START, $FF40
        SAVENEX CORE 3, 0, 0
        SAVENEX CFG 7, 0, 1, 0
        SAVENEX AUTO
        SAVENEX CLOSE