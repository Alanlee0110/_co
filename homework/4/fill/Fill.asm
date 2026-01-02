// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed,
// the screen should be cleared.

(LOOP)
    // 1. 監聽鍵盤
    @KBD
    D=M         // 讀取鍵盤輸入
    
    @ON
    D;JGT       // 如果 D > 0 (有按鍵)，跳去設定黑色
    
    @OFF
    0;JMP       // 否則跳去設定白色

(ON)
    // 設定填色值為 -1 (全黑 1111111111111111)
    @-1
    D=A
    @fillval
    M=D
    @DRAW       // 跳去繪圖
    0;JMP

(OFF)
    // 設定填色值為 0 (全白 0000000000000000)
    @0
    D=A
    @fillval
    M=D
    @DRAW       // 跳去繪圖
    0;JMP

(DRAW)
    // 2. 初始化繪圖迴圈
    // 設定螢幕起始位址
    @SCREEN
    D=A
    @addr
    M=D         // addr = 16384

    // 設定計數器 (倒數 8192 次)
    // 這樣可以確保絕對不會畫超過範圍 (解決 24577 錯誤)
    @8192
    D=A
    @counter
    M=D

(NEXT_PIXEL)
    // 3. 檢查是否畫完
    @counter
    D=M
    @LOOP
    D;JEQ       // 如果 counter == 0，畫完了，跳回主迴圈偵測鍵盤

    // 4. 執行填色
    @fillval
    D=M         // 取出剛剛決定的顏色 (-1 或 0)
    
    @addr
    A=M         // 取出目前螢幕指標指向的位址
    M=D         // 把顏色畫上去

    // 5. 更新變數
    @addr
    M=M+1       // 螢幕指標往下移一格
    @counter
    M=M-1       // 剩餘次數減 1

    // 6. 繼續下一個點
    @NEXT_PIXEL
    0;JMP

    (END)
    @END
    0;JMP