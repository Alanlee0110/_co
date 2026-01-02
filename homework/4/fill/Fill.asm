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
    // 1. 初始化螢幕指標 (從 SCREEN 開始)
    @SCREEN
    D=A
    @addr
    M=D

    // 2. 初始化計數器 (倒數 8192 次)
    @8192
    D=A
    @counter
    M=D

(NEXT_PIXEL)
    // 檢查：如果計數器歸零，就跳出
    @counter
    D=M
    @LOOP
    D;JEQ    // 如果 counter == 0，畫完了，跳回主迴圈偵測鍵盤

    // 執行填色
    @fillval
    D=M      // 取出顏色 (-1 或 0)
    @addr
    A=M      // 取出目前要畫的螢幕位址
    M=D      // 塗色！

    // 更新變數
    @addr
    M=M+1    // 指標往下移一格
    @counter
    M=M-1    // 計數器扣 1

    // 繼續畫下一格
    @NEXT_PIXEL
    0;JMP

    (END)
    @END
    0;JMP