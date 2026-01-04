// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/6/max/Max.asm

// Computes R2 = max(R0, R1)  (R0,R1,R2 refer to RAM[0],RAM[1],RAM[2])
// Usage: Before executing, put two values in R0 and R1.

  // D = R0 - R1
  @R0
  D=M      // D = RAM[0] (先把 R0 的值放入 D)
  @R1
  D=D-M    // D = D - RAM[1] (現在 D 變成了 R0 - R1 的差值)
  // If (D > 0) goto ITSR0
  @ITSR0   // 準備跳轉的目標地址 (ITSR0 是一個標籤)
  D;JGT    // 若 D > 0 (即 R0 > R1)，則跳轉到 ITSR0
  // Its R1
  @R1
  D=M      // 因為 R1 比較大，所以把 R1 的值讀入 D
  @OUTPUT_D
  0;JMP    // 無條件跳轉到 OUTPUT_D (為了跳過下面 R0 的處理區塊)
  (ITSR0)     // 這是一個標籤 (Label)，給 JGT 跳轉用的定位點
  @R0
  D=M      // 因為 R0 比較大，所以把 R0 的值讀入 D
(OUTPUT_D)  // 匯集點標籤
   @R2
   M=D      // 將最大值 (D) 寫入 RAM[2]

(END)       // 程式結束標籤
   @END
   0;JMP    // 無限迴圈
