
期中作業(1-5章)

作業說明:1到3章有參考網路圖片，4,5章由ai設計,使用gemini設計


第一章

Project 1: 基礎布林邏輯 (Boolean Logic)

1. Nand (Not-And)
邏輯： 只有當 a 和 b 都是 1 時，輸出才是 0；其他情況都是 1。

用途： 用來組出所有的邏輯閘。

2. Not (反相器)
輸入： in

輸出： out

說明：輸入 0 變 1，輸入 1 變 0。

3. And (及閘)
輸入： a, b

輸出： out

說明：只有 a 跟 b 同時為 1，才輸出 1。

4. Or (或閘)
輸入： a, b

輸出： out

說明：只要 a 或 b 其中一個是 1，就輸出 1。

5. Xor (互斥或閘)
輸入： a, b

輸出： out

說明：當 a 和 b 不一樣 時輸出 1 (例如 0,1 或 1,0)。

6. Mux (Multiplexer / 數據選擇器)
輸入： a, b, sel

輸出： out

說明： 二選一開關。

如果 sel == 0，輸出 a 的值。

如果 sel == 1，輸出 b 的值。

7. DMux (Demultiplexer / 數據分配器)
輸入： in, sel

輸出： a, b

說明： 分流開關。把輸入訊號 in 導向其中一條路，另一條路設為 0。

如果 sel == 0，a = in, b = 0。

如果 sel == 1，a = 0, b = in。

8. 多位元與多通道變體 (16-bit / Multi-way)
Not16, And16, Or16, Mux16： 將上述邏輯平行複製 16 次，處理匯流排 (Bus)。

Or8Way： 8 個輸入只要有一個是 1 就輸出 1。用樹狀結構做 (兩兩一組 Or)。

Mux4Way16 / Mux8Way16： 從 4 個或 8 個來源中選一個。需要更多 sel 位元 (如 sel[0..1] 或 sel[0..2])。


Project 2: 布林運算 (Boolean Arithmetic)

1. HalfAdder (半加器)
輸入： a, b

輸出： sum, carry

說明： 加兩個位元。

sum (個位數) = a Xor b

carry (進位) = a And b

2. FullAdder (全加器)
輸入： a, b, c (前一位的進位)

輸出： sum, carry

說明： 加三個位元。這是串接成加法器的基本單位。

實作提示： 用兩個 HalfAdder 和一個 Or 組成。

3. Add16 (16位元加法器)
輸入： a[16], b[16]

輸出： out[16]

說明： 將 16 個 FullAdder 串聯起來，進位像波浪一樣傳遞。

4. Inc16 (增量器)
輸入： in[16]

輸出： out[16]

說明： 把輸入的數字 +1。

實作提示： Add16(a=in, b[0]=true)。

5. ALU (算術邏輯單元)
輸入： x[16], y[16], 6個控制位元 (zx, nx, zy, ny, f, no)

輸出： out[16], zr (是否為0), ng (是否為負)

說明： CPU 的計算核心。透過 6 個控制位元的組合，能算出 x+y, x-y, x&y, x|y, -x, !x...等 18 種結果。


Project 3: 序向邏輯 (Sequential Logic)


Project 4: 機器語言 (Machine Language)

1. A 指令 (A-Instruction)

功能：選定地址： 把數值載入 A 暫存器 (Address Register)。
選定數據： 當你執行 @100 後，下一行如果寫 M，指的就是 RAM[100]。
準備跳轉： 如果下一行是 JMP，程式會跳到 A 暫存器指定的行號執行。
說明： 這是手指。告訴 CPU 「我要指著哪裡」。

2. C 指令 (C-Instruction)

功能：計算 (comp)： 控制 ALU 做運算 (如 D+M, D-1, 0, -1)。
存檔 (dest)： 決定結果存到哪 (A, D, M 的組合)。
跳轉 (jump)： 決定下一行要不要跳去別的地方 (JGT, JEQ, JMP...)。
說明： 這是大腦。叫 ALU 做事，並決定下一步。

3. Mult.asm (乘法程式)

輸入： R0, R1 (放在 RAM[0], RAM[1])輸出： R2 (放在 RAM[2])
Hack 的 ALU 硬體只會做加法，不會乘法。我們必須用軟體 (程式碼) 來彌補硬體的不足。
實作邏輯：使用累加法 (Repeated Addition)。把 R0 加 R1 次，就會等於乘法。需要使用到 Loop (迴圈) 和變數控制。

4. Fill.asm (螢幕填色程式)
輸入： 鍵盤訊號 (RAM[24576])
輸出： 螢幕顯示 (RAM[16384] ~ RAM[24575])
互動式 I/O。按住任意鍵-螢幕全黑。放開所有鍵-螢幕全白。
為什麼要做這個：練習 Memory Mapped I/O (記憶體映射輸入輸出) 的概念。讓你理解「控制螢幕」其實就只是「把數字寫進特定的 RAM 記憶體」而已。
實作邏輯：無窮迴圈監聽鍵盤。
使用指標 (Pointer) 操作來遍歷 8192 個螢幕暫存器單元。


Project 5: 電腦架構 (Computer Architecture)

19. Memory (整體記憶體)
輸入： in[16], load, address[15]

輸出： out[16]

說明： 將 RAM、螢幕、鍵盤整合到同一個地址空間。

0 ~ 16383：對應 RAM16K (數據區)。

16384 ~ 24575：對應 Screen (視訊記憶體)。

24576：對應 Keyboard (鍵盤暫存器)。

實作提示： 使用 DMux 根據 address 的高位元來分流。

20. CPU (中央處理器)
輸入： inM, instruction, reset

輸出： outM, writeM, addressM, pc

說明： 電腦的大腦。

解碼器： 判斷指令是 A (@value) 還是 C (dest=comp;jump)。

執行單元： 控制 ALU 計算，並決定結果要存回 A 暫存器、D 暫存器還是 Memory。

控制單元： 根據 ALU 的結果 (zr, ng) 和指令的跳轉位元 (j1~j3) 決定 PC 是否要跳轉。

21. Computer (Hack 電腦)
零件： ROM32K (程式唯讀記憶體), CPU, Memory。

ROM 給 CPU 指令。

CPU 讀寫 Memory 數據。

Memory 包含 I/O (螢幕鍵盤) 與使用者互動。