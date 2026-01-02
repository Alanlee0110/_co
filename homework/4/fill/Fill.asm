// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(LOOP)
    // 1. 取得鍵盤輸入
    @KBD
    D=M         // 讀取鍵盤 RAM[24576] 的值放入 D 暫存器

    // 2. 判斷是否按下按鍵
    @ON
    D;JGT       // 如果 D > 0 (有按鍵)，跳轉到 (ON)標籤
    @OFF
    0;JMP       // 否則跳轉到 (OFF)標籤

(ON)
    @-1
    D=A         // D = -1 (二進位 1111...1111，全黑)
    @fillval
    M=D         // 將 -1 存入變數 fillval
    @DRAW
    0;JMP       // 跳去執行繪圖

(OFF)
    @0
    D=A         // D = 0 (全白)
    @fillval
    M=D         // 將 0 存入變數 fillval
    @DRAW
    0;JMP       // 跳去執行繪圖

(DRAW)
    // 初始化螢幕指標
    @SCREEN     // SCREEN 的位址是 16384
    D=A
    @addr       // addr 變數用來記錄目前畫到哪個記憶體位址
    M=D

    // 初始化計數器 (螢幕共有 256列 * 32個word = 8192 個暫存器)
    @8192
    D=A
    @counter
    M=D

(NEXT_PIXEL)
    @counter
    D=M
    @LOOP
    D;JEQ       // 如果 counter == 0，代表畫完整個螢幕，跳回主迴圈 (LOOP) 重新檢查鍵盤

    // 執行填色
    @fillval
    D=M         // 取出決定好的顏色 (-1 或 0)
    @addr
    A=M         // A = 目前的螢幕記憶體位址
    M=D         // 將顏色寫入 RAM[addr]

    // 更新指標與計數器
    @addr
    M=M+1       // addr 指向下一個位址
    @counter
    M=M-1       // counter 減 1

    @NEXT_PIXEL
    0;JMP       // 繼續畫下一個像素區塊