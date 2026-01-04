
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

1. Memory (整體記憶體)
輸入： in[16], load, address[15]

輸出： out[16]

說明： 將 RAM、螢幕、鍵盤整合到同一個地址空間。

0 ~ 16383：對應 RAM16K (數據區)。

16384 ~ 24575：對應 Screen (視訊記憶體)。

24576：對應 Keyboard (鍵盤暫存器)。

實作提示： 使用 DMux 根據 address 的高位元來分流。

2. CPU (中央處理器)
輸入： inM, instruction, reset

輸出： outM, writeM, addressM, pc

說明： 電腦的大腦。

解碼器： 判斷指令是 A (@value) 還是 C (dest=comp;jump)。

執行單元： 控制 ALU 計算，並決定結果要存回 A 暫存器、D 暫存器還是 Memory。

控制單元： 根據 ALU 的結果 (zr, ng) 和指令的跳轉位元 (j1~j3) 決定 PC 是否要跳轉。

3. Computer (Hack 電腦)
零件： ROM32K (程式唯讀記憶體), CPU, Memory。

ROM 給 CPU 指令。

CPU 讀寫 Memory 數據。

Memory 包含 I/O (螢幕鍵盤) 與使用者互動。


期末作業(6-12章)

作業說明:6-12章都由gemini設計,在由gemini說明


Project 6: Assembler (組譯器)
這是軟體的最底層。

核心機制：字串處理 (String Manipulation) 與 查表 (Look-up Table)。

技術細節：

符號解析：你的程式需要建立一個 SymbolTable (雜湊表/字典)。當讀到 (LOOP) 時，記下當前的 ROM 地址；當讀到 @sum 時，分配一個新的 RAM 地址。

二進位轉換：將 D=M+1 拆解，查表得知 dest=D 是 010，comp=M+1 是 1110111，最後拼湊成 16-bit 字串。

兩次掃描 (Two-Pass)：第一次唯讀標籤，第二次才翻譯指令，解決「先跳轉後定義」的問題。


Project 7: VM I - Stack Arithmetic (堆疊運算)
這是 VM 的心臟。VM 模型是基於「堆疊 (Stack)」的，這比暫存器模型更容易編譯。

核心機制：堆疊指標 (Stack Pointer, SP) 的操作。

技術細節：

記憶體映射：你需要實作如何將 local 2 (區域變數) 轉換成 RAM[LCL + 2] 的物理地址。

算術翻譯：當 VM 讀到 add 時，你的 Translator 要生成一段 Assembly 代碼：

SP-- (取出 y)

SP-- (取出 x)

D = x + y

SP++ (把結果 D 放回去)

邏輯比較：實作 eq (等於) 時，需要利用 Assembly 的跳轉指令 (JEQ) 來模擬 True (-1) 和 False (0) 的結果。


Project 8: VM II - Program Control (流程控制)
這是 VM 的大腦，處理最複雜的「函數呼叫」。

核心機制：堆疊幀 (Stack Frame) 與 返回地址 (Return Address)。

技術細節：

Function Call：當呼叫 call f 時，你必須把當下的狀態 (Return Address, LCL, ARG, THIS, THAT) 全部 push 到堆疊上保存起來，然後跳轉到函數 f。

Function Return：當函數結束 return 時，你必須從堆疊中把剛剛存的那些狀態恢復回來，並跳轉回呼叫點的下一行。

Bootstrap：撰寫一段啟動代碼 (Sys.init)，初始化 SP 指標並開始執行程式。


Project 9: High-Level Language (Jack 語言)
這是為了讓你體驗「使用者」的感覺。

核心機制：物件導向編程 (OOP)。

技術細節：

你會學到 Jack 語言的特性：它是強型別的 (Strongly typed)，有 class (類別)、method (方法)、function (靜態函數)。

你需要習慣手動管理記憶體 (do memory.deAlloc(this))，因為 Jack 沒有 Garbage Collection (垃圾回收)。


Project 10: Compiler I - Syntax Analysis (語法分析)
這是編譯器的前端。

核心機制：詞法分析 (Tokenizing) 與 語法分析 (Parsing)。

技術細節：

Tokenizer：把原始碼字串 while (i<0) { 切割成 Token 列表：keyword: while, symbol: (, identifier: i...。

Parser：根據 Jack 的語法規則 (Context-Free Grammar)，將 Token 組裝成一棵 語法樹 (Parse Tree)。

XML 輸出：將這棵樹印成 XML 格式，例如 <keyword> while </keyword>，用來驗證你的結構是否正確。


Project 11: Compiler II - Code Generation (代碼生成)
這是編譯器的後端，也是整個課程最難的一步。

核心機制：符號表 (Symbol Table) 與 遞迴下降編譯 (Recursive Descent)。

技術細節：

變數管理：你需要兩個符號表，一個是 Class 級別 (Field/Static)，一個是 Subroutine 級別 (Local/Argument)。編譯器要能分辨 x 到底是區域變數還是物件屬性。

表達式編譯：將中綴運算式 a + b * c 轉換成後綴堆疊操作。你需要先推入 a，推入 b，推入 c，呼叫 multiply，再呼叫 add。

物件操作：處理 b.move() 這種方法呼叫時，你需要隱藏地將 b (即 this 指標) 作為第一個參數傳遞進去。


Project 12: The Operating System
這不是像 Windows/Linux 那種管理行程的核心，而是一組用 Jack 寫的基礎類別庫。

核心機制：演算法效率與硬體驅動。

技術細節 (你需要實作這 8 個 Class)：

Math：硬體沒有乘法器，你需要用「位元位移 (Bit shifting)」演算法實作 multiply 和 divide (效率比連加法快得多)。

String：實作整數與字串的轉換 (ASCII 碼處理)。

Array：實作記憶體配置。

Output：透過寫入 Screen Map 來顯示字元 (Bitmap Font)。

Screen：實作 drawLine (畫線演算法) 和 drawCircle。你需要直接操作 RAM[16384] 的位元。

Keyboard：監聽 RAM[24576] 獲取使用者輸入。

Memory：實作 alloc (配置) 和 deAlloc (釋放)。你需要維護一個 Free List (空閒鏈結串列) 來管理堆積 (Heap) 記憶體。

Sys：OS 的進入點與 wait (延遲) 函數。