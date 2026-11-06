; System ROM routines
ROM_PRINT_A   EQU $0010
ROM_BEEPER    EQU $03B5
ROM_CLS       EQU $0D6B
ROM_CHAN_OPEN EQU $1601
ROM_PAUSE     EQU $1F3D

; System variables
SYS_BORDCR   EQU 23624
SYS_ATTR_P   EQU 23693

; System ports
PORT_FE      EQU $FE

    DEVICE ZXSPECTRUMNEXT
    ORG $8000

START:
    ; Set the colors: yellow (6) text on blue (1) background
    ; 10 PAPER 1: INK 6
    LD A, %00001110
    LD (SYS_ATTR_P), A

    ; BORDER 1 (and lower screen) + output to port $FE
    LD (SYS_BORDCR), A
    LD A, 1
    OUT (PORT_FE), A

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

    ; 70 PRINT "Press any key..."
    LD HL, PROMPT_DB

PRINT_PROMPT:
    LD A, (HL)
    CP 255
    JR Z, PAUSE_0

    RST ROM_PRINT_A
    INC HL
    JR PRINT_PROMPT

PAUSE_0:
    ; 80 PAUSE 0 - wait for a key press
    EI ; enable interrupts
    LD BC, 0 ; no timeout for pause
    CALL ROM_PAUSE

    ; 90 BEEP 0.1,0 - sound a beep
BEEP:
    ; Middle C - 261.63 Hz
    ; DE = duration = frequency * seconds; 1 sec of middle C is = 261.63 * 1 ≈ 262
    ; HL = pitch = 437500 / frequency - 30.125 = 437500 / 261.63 - 30.125 ≈ 1642
    LD HL, 1642
    LD DE, 262
    CALL ROM_BEEPER

    ; Wait for one second before exiting
    LD BC, 50
    CALL ROM_PAUSE

    RET

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