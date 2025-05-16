# c64-plasma
Precalculate "plasma" data from C64 basic, to display in fast ASM

This was made for CBM studio.
Open the BASIC program "josippplasma2.bas" to create plasma data.
Change values as you see fit. Run the program to create 48 frames of colorful
"plasma" screens.

Include the data created in the "colcopy2.asm" assembler file.
Should fill to $d000.

Compressing this with exomizer gets the program down to 8k.

Todo:
compress 2*48 frames in the same space and display.
0..15 for color uses a byte for now, wastes a nibble.
