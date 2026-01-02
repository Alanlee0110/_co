// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed,
// the screen should be cleared.

(LOOP)
    // 1. Get keyboard input
    @KBD
    D=M         // Read RAM[24576]

    // 2. Check if key pressed
    @ON
    D;JGT       // If D > 0 (key pressed), jump to ON
    @OFF
    0;JMP       // Else jump to OFF

(ON)
    @-1
    D=A         // D = -1 (all black)
    @fillval
    M=D         // fillval = -1
    @DRAW
    0;JMP

(OFF)
    @0
    D=A         // D = 0 (all white)
    @fillval
    M=D         // fillval = 0
    @DRAW
    0;JMP

(DRAW)
    // Initialize pointer
    @SCREEN     // SCREEN address 16384
    D=A
    @addr
    M=D

    // Initialize counter (8192 words)
    @8192
    D=A
    @counter
    M=D

(NEXT_PIXEL)
    @counter
    D=M
    @LOOP
    D;JEQ       // If counter == 0, go back to LOOP

    // Fill logic
    @fillval
    D=M         // Get color
    @addr
    A=M         // Get address of current pixel
    M=D         // Paint it

    // Increment pointer, Decrement counter
    @addr
    M=M+1
    @counter
    M=M-1

    @NEXT_PIXEL
    0;JMP