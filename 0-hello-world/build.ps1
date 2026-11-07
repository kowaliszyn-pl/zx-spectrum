# Build all the code in this directory

# Convert *.bas files to bin\*.bas.bin using txt2bas

txt2bas -i HelloWorld.bas -o bin\HelloWorld.bas.bin
txt2bas -i HelloWorldInColors.bas -o bin\HelloWorldInColors.bas.bin

# Compile asm using sjasmplus

#..\..\..\..\8bits\tools\sjasmplus\sjasmplus --outprefix=bin\ HelloWorldInColors.asm
..\..\..\..\8bits\tools\sjasmplus\sjasmplus --raw=bin\HelloWorldInColors.bin --outprefix=bin\ HelloWorldInColors.asm

# Generate BASIC CODE from the binary data using GenerateCode.cs

dotnet GenerateCode.cs
txt2bas -i HelloWorldInColorsData.bas -o bin\HelloWorldInColorsData.bas.bin

# Copy all output files to emulator using jNext

Read-Host "Press Enter to continue..."
..\..\..\..\8bits\tools\jNext\jNext --sdcard-file-add bin/HelloWorld.bas.bin --sdcard-file-dest APPS/MY/HelloWorld.bas --sdcard-file-force
..\..\..\..\8bits\tools\jNext\jNext --sdcard-file-add bin/HelloWorldInColors.bas.bin --sdcard-file-dest APPS/MY/HelloWorldInColors.bas --sdcard-file-force
..\..\..\..\8bits\tools\jNext\jNext --sdcard-file-add bin/HelloWorldInColorsData.bas.bin --sdcard-file-dest APPS/MY/HelloWorldInColorsData.bas --sdcard-file-force
..\..\..\..\8bits\tools\jNext\jNext --sdcard-file-add bin/HelloWorldInColors.nex --sdcard-file-dest APPS/MY/HelloWorldInColors.nex --sdcard-file-force

# End of build script - set output console colors to default for a given theme and print a message

$Host.UI.RawUI.ForegroundColor = "White"
$Host.UI.RawUI.BackgroundColor = "Black"

Write-Host "Build completed successfully."
