---
skill: query-and-keep
trigger: 当我的提问需要综合多个 wiki 页面才能回答时
description: 查询 wiki 并综合回答，然后将有价值的分析归档为新 wiki 页面，形成知识复利
---

# Query-and-Keep：查询并归档

## 核心理念
好的答案不应该消失在聊天历史中。如果一个分析综合了多个 wiki 页面、揭示了新的关联、或者很可能将来再次用到——它就应该变成一个 wiki 页面。这样每次提问都让知识库更丰富，而非仅仅消耗它。

> 此理念直接源自 Karpathy 的 LLM Wiki 原始概念:
> "good answers can be filed back into the wiki as new pages... This way your explorations compound in the knowledge base just like ingested sources do."

## 执行流程

### 1. 定位相关页面
- 先读 `index.md`，快速浏览所有类别
- 找到所有可能相关的页面（通常 3–10 个）
- 若有疑问是否相关，宁可多读一个

### 2. 深度阅读
- 阅读每个候选页面的全文
- 特别留意:
  - 页面之间的**隐藏关联**（同一主题在不同语境下的不同表述）
  - 页面之间的**矛盾**（不同来源/视角的冲突）
  - 页面之间的**互补**（各自覆盖了问题的一部分）
- 标记 `status: stale` 的页面，判断其中信息是否仍然有效

### 3. 综合回答
- 给出全面的回答，**必须**带 `[[引用链接]]`（链接到 wiki 中的来源页面）
- 使用 callout 标注关键发现:
  - `> 📌 Key Insight:` 跨页面综合后的新发现
  - `> ⚠️ Contradiction:` 不同页面的矛盾之处
  - `> ❓ Open Question:` 此回答未能解决的问题
  - `> 🔗 See Also:` 相关的 wiki 页面
- 引用格式: "根据 [[wiki/sources/某论文]] 的实验结果..."

### 4. 询问归档（关键步骤，不可省略）

回答之后，**必须**问我以下问题:

> "这个分析综合了 N 个页面（列出页面名）。需要我将其归档到 wiki 吗？
> - 若归档到 `wiki/topics/`，将来可作为该主题的综述页
> - 若归档到 `wiki/comparisons/`，将来可作为对比参考
>
> 或者你觉得这次分析还不需要单独成页？"

### 5. 如果我说"是，归档"

确定归档位置（`wiki/topics/` 或 `wiki/comparisons/`）后:

1. **创建页面**，包含:
   - 标准 frontmatter（type, tags, created, updated, sources, status）
   - 完整分析内容（比我口头回答更结构化、更详尽）
   - 到所有引用页面的 `[[双向链接]]`
   - 适合将来参考的标题层级

2. **更新索引**: 在 `index.md` 对应类别下添加条目

3. **追加日志**:
   ```markdown
   ## [YYYY-MM-DD] query | <分析标题>
   - **触及页面**: [[page1]], [[page2]], ...
   - **摘要**: 基于查询的综合分析，已归档为 [[新页面]]
   ```

4. **汇报**: "已归档到 `wiki/topics/<标题>.md`，index 已更新。将来再问同类问题，wiki 中已有现成的综合观点。"

### 6. 如果我说"否，不归档"
- 不创建页面
- 在 `log.md` 追加一条 query 记录（仅记录查询了什么，不创建新页面）
- 保留本次分析的思路，若以后用户改变主意可以随时回溯
