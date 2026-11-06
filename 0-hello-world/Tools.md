# Tools

## Visual Code Extensions

Install the following Visual Studio Code extensions:

1. NextBASIC
https://marketplace.visualstudio.com/items?itemName=remysharp.nextbasic

2. Z80 Macro-Assembler
https://marketplace.visualstudio.com/items?itemName=mborik.z80-macroasm

## Compiler

To compile Z80 assembly code, use the following compiler (download and extract files):

1. sjasmplus - Z80 Assembler
https://github.com/z00m128/sjasmplus

## Emulator

Install to run ZX Spectrum Next software on your computer (download and extract files):

1. jNext - ZX Spectrum Next Emulator
https://www.jnext.es/

## Run your first program

1. Convert the `HelloWorld.bas` file to `HelloWorld.bas.bin` using the NextBASIC command "export to binary BAS".
2. Export the .bas.bin file to the emulator using the following command:

`..\..\..\..\8bits\Tools\jNext\jnext.exe --sdcard-file-add HelloWorld.bas.bin --sdcard-file-dest /APPS/MY/HelloWorld.bas`

