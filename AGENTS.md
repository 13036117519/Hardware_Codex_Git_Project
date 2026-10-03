# AGENTS.md

## 项目身份
这是 2026 秋《硬件综合训练》Logisim RISC-V 课程设计项目。

## 我的差异化指令
- C1 = SRA
- C2 = XOR
- A = LH
- B = BGE

## 室友参考版本的对应指令
- C1 = SLL
- C2 = SLTIU
- A = SB
- B = BGEU

## 文件权限与边界
- `00_source/`：只读资料，禁止修改。
- `01_reference_tests/`：官方测试与工具资料，禁止修改。
- `00_source/roommate_baseline/target.circ`：已完成的室友参考基线，禁止直接修改。
- `02_work/`：主要工作区。
- `02_work/circuit/my_target.circ`：我的工作电路。
- `06_submission/`：仅放确认后的最终提交副本。

## 工作原则
1. 先分析，再修改；不要一开始重写整个 CPU。
2. 优先比较官方 `cpu21-riscv.circ` 与室友 `target.circ`，定位差异化指令相关的实际电路结构。
3. 按 SRA → XOR → LH → BGE 的顺序逐项处理。
4. 每完成一个功能都做针对性测试，再进入下一项。
5. 综合测试、流水线、中断、分支预测等阶段必须有实际测试证据。
6. 不确定时检查源文件、测试文件或 Logisim 行为，不得猜测并宣布成功。
7. 尽量做最小范围的 `.circ` 修改，保留原有电路结构与命名。
8. 不要修改参考资料来“让测试通过”。
9. 每个稳定阶段建议做一次 Git commit。
