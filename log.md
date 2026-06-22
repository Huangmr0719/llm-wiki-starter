# 操作日志

> 仅追加。每条记录以 `## [YYYY-MM-DD] <操作类型> | <标题>` 开头。
> 可被 `grep "^## \[" log.md | tail -10` 解析。
>
> 操作类型: `ingest` | `query` | `lint` | `restructure` | `skill`

---

## [YYYY-MM-DD] restructure | Wiki 初始化
- **触及页面**: [[CLAUDE.md]], [[index.md]], [[log.md]], [[skills/ingest.md]], [[skills/lint.md]], [[skills/query-and-keep.md]]
- **摘要**: 按 LLM Wiki 模式完成 vault 三层架构初始化，配置 MCP 连接，创建 CLAUDE.md（Schema + 个人画像）、index.md（内容目录）、log.md（本文件）、三个核心技能文件
