# Build all the code in this directory

# Convert *.bas files to bin\*.bas.bin using txt2bas

txt2bas -i HelloWorld.bas -o bin\HelloWorld.bas.bin
txt2bas -i HelloWorldInColors.bas -o bin\HelloWorldInColors.bas.bin

# Compile asm using sjasmplus
..\..\..\..\8bits\tools\sjasmplus\sjasmplus --outprefix=bin\ HelloWorldInColors.asm

# Copy all output files to emulator using jNext
..\..\..\..\8bits\tools\jNext\jNext --sdcard-file-add bin/HelloWorld.bas.bin --sdcard-file-dest APPS/MY/HelloWorld.bas --sdcard-file-force
..\..\..\..\8bits\tools\jNext\jNext --sdcard-file-add bin/HelloWorldInColors.bas.bin --sdcard-file-dest APPS/MY/HelloWorldInColors.bas --sdcard-file-force
..\..\..\..\8bits\tools\jNext\jNext --sdcard-file-add bin/HelloWorldInColors.nex --sdcard-file-dest APPS/MY/ --sdcard-file-force

# End of build script - print the message
Write-Host "Build completed successfully."