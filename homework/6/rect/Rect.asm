// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/6/rect/Rect.asm

// Draws a rectangle at the top-left corner of the screen.
// The rectangle is 16 pixels wide and R0 pixels high.
// Usage: Before executing, put a value in R0.

   // If (R0 <= 0) goto END else n = R0
   @R0
   D=M
   @END
   D;JLE    // 如果高度 <= 0，直接結束程式，什麼都不畫
   @n
   M=D      // 建立變數 n，用來當作倒數計時器 (還剩幾行要畫)
   // addr = base address of first screen row
   @SCREEN  // SCREEN 是一個預定義符號，代表數值 16384
   D=A
   @addr
   M=D      // 建立變數 addr，並將它的值設為 16384
(LOOP)
   // RAM[addr] = -1 (畫黑一行)
   @addr
   A=M      // 關鍵！把 addr 裡面的值 (例如 16384) 拿出來當作地址
   M=-1     // 在 RAM[16384] 填入 -1
   // addr = base address of next screen row (移動到下一行)
   @addr
   D=M
   @32
   D=D+A    // D = 目前地址 + 32
   @addr
   M=D      // 更新 addr 指向下一行的位置
   // decrements n and loops (計數器遞減與跳轉)
   @n
   MD=M-1   // 高度計數器 -1，同時存回 M 並放入 D 用於比較
   @LOOP
   D;JGT    // 如果還沒畫完 (n > 0)，跳回 LOOP 繼續畫

(END)
   @END
   0;JMP
