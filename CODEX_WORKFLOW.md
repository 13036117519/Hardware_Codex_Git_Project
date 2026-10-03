# CODEX_WORKFLOW

## 启动顺序
1. 阅读 `AGENTS.md` 与 `PROJECT_STATE.md`。
2. 阅读 `00_source/` 和 `01_reference_tests/`，建立项目结构认知。
3. 只读比较官方 `cpu21-riscv.circ` 与室友 `target.circ`。
4. 检查 `02_work/circuit/my_target.circ` 的初始哈希是否与室友基线一致。

## 实施顺序
SRA → XOR → LH → BGE → CCAB 综合 → 流水线 → 中断 → 分支预测/其他回归。

## 每个功能
分析指令格式 → 找到现有对应指令 → 追踪控制/立即数/ALU/寄存器/存储器/流水线信号 → 做最小修改 → 运行针对性测试 → 记录结果 → Git commit。

## 禁止行为
- 不要直接修改 `00_source/`。
- 不要直接修改 `00_source/roommate_baseline/target.circ`。
- 不要为了通过测试去修改测试文件。
- 没有实际测试证据时，不要声称“已经完成”。
