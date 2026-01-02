// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

// 邏輯說明 (Logic):
// R2 = 0
// i = R1
// while (i > 0) {
//    R2 = R2 + R0
//    i = i - 1
// }

    // 1. 初始化 (Initialization)
    @R2     // 選擇暫存器 R2 (存放結果)
    M=0     // 將 R2 歸零 (R2 = 0)

    @R1     // 讀取 R1 (乘數)
    D=M
    @i      // 定義一個變數 i 作為計數器
    M=D     // i = R1

(LOOP)
    // 2. 檢查迴圈條件 (Check Condition)
    @i
    D=M     // 讀取計數器 i
    @END
    D;JLE   // 如果 i <= 0，跳轉到 END (結束運算)

    // 3. 執行加法 (Addition)
    @R0     // 讀取 R0 (被乘數)
    D=M
    @R2     // 讀取目前的累積結果 R2
    M=D+M   // R2 = R2 + R0

    // 4. 更新計數器 (Update Counter)
    @i
    M=M-1   // i = i - 1

    // 5. 跳回迴圈開頭 (Loop)
    @LOOP
    0;JMP

(END)
    @END
    0;JMP   // 無窮迴圈，終止程式
