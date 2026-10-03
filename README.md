# 硬件综合训练 — Git/Codex 项目

这是整理后的 Git-ready 工作目录：只读资料与 Codex 工作区分离。

## 首先阅读
1. `AGENTS.md`：Codex 项目规则。
2. `PROJECT_STATE.md`：当前进度。
3. `CODEX_WORKFLOW.md`：推荐工作流程。

## 关键文件
- 官方电路：`00_source/official/circuit_framework/cpu21-riscv.circ`
- 室友参考基线：`00_source/roommate_baseline/target.circ`
- 我的工作电路：`02_work/circuit/my_target.circ`
- 官方测试：`01_reference_tests/`

## Git
这里没有携带个人 `.git` 元数据。解压后在项目根目录执行 `git init` 即可开始版本管理。

## 差异化指令
C1=SRA，C2=XOR，A=LH，B=BGE。
