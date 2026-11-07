string binaryFile = "bin\\HelloWorldInColors.bin";
string outputFile = "HelloWorldInColorsData.bas";

// Read all bytes form the binary file

byte[] binaryData = File.ReadAllBytes(binaryFile);
int address = 32768; // Example memory address to load the binary data into
int binaryDataLength = binaryData.Length;

// BASIC code to load binary data into memory and execute it

List<string> lines = [
    $"10 CLEAR {address - 1}",
    $"20 FOR i=0 TO {binaryDataLength - 1}",
    $"30 READ b: POKE {address}+i,b",
    "40 NEXT i",
    $"50 LET r=USR {address}"
];

// DATA instruction line numebr

int dataLineNumber = 100;
int dataInstructionsPerLine = 8;

// Add data lines for the binary data

for (int i = 0; i < binaryDataLength; i += dataInstructionsPerLine)
{
    string line = dataLineNumber + " DATA ";
    for (int j = 0; j < dataInstructionsPerLine && i + j < binaryDataLength; j++)
    {
        line += binaryData[i + j];
        if (j < dataInstructionsPerLine - 1 && i + j + 1 < binaryDataLength)
            line += ",";
    }
    lines.Add(line);
    dataLineNumber += 10;
}

// Save the BASIC code to the output file

File.WriteAllLines(outputFile, lines);

// Show some information about the generated BASIC code

Console.WriteLine($"Generated BASIC code saved to {outputFile}");
Console.WriteLine($"Binary data length: {binaryDataLength} bytes");
Console.WriteLine($"Memory address: {address}");
Console.WriteLine($"Output file: {outputFile}");

// END