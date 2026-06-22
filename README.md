# LLM Wiki Starter

> 一键启动你的 AI 第二大脑。基于 Andrej Karpathy 的 [LLM Wiki 模式](https://github.com/karpathy/llm-wiki)，将 Claude Code 变成你的个人知识管理员——读文章、写摘要、建链接、查矛盾，越用越聪明。

**A one-command starter kit for building a self-maintaining AI knowledge base with Claude Code + Obsidian.**

---

## 这是什么

你最好的想法散落在十几个地方：笔记应用、浏览器标签页、已经关掉的 Claude 对话。每次坐下来工作，都需要凭记忆重新构建上下文。

**LLM Wiki 解决了这个问题**——它是一个会自我生长的 markdown 知识库。你把文章扔进去，AI 帮你读、帮你写摘要、帮你在知识点之间建立连接。它不是 RAG（每次从零检索），而是**增量构建**——知识被编译一次，然后持续更新，随着每一次使用变得丰富。

```
你（人类）                      Claude（AI）                      Obsidian（界面）
──────────                     ──────────                       ──────────
精选资料 → raw/        →       读、提取、写摘要
提出好问题             →       搜索 wiki、综合回答
定期检查               →       矛盾检测、过时标记、补链接
浏览图谱               ←       所有内容写回 wiki/              →  图谱视图、反向链接
```

---

## 快速开始

### 前提条件
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) CLI（需 Pro 订阅，$20/月）
- [Obsidian](https://obsidian.md)（免费，用于可视化浏览）
- [Git](https://git-scm.com)（已预装于 macOS/Linux）

### 3 步启动

```bash
# 1. 克隆模板仓库
git clone https://github.com/Huangmr0719/llm-wiki-starter.git ~/brain
cd ~/brain

# 2. 在 Obsidian 中打开此文件夹作为 vault
#    设置 → Community plugins → 启用 → 搜索安装 "Local REST API"
#    复制 API Key（不要包含 "Bearer" 前缀）

# 3. 连接 Claude Code
claude mcp add-json obsidian-vault '{ "type": "stdio", "command": "uvx", "args": ["mcp-obsidian"], "env": { "OBSIDIAN_API_KEY": "你的密钥", "OBSIDIAN_HOST": "127.0.0.1", "OBSIDIAN_PORT": "27124" } }'
```

然后在 Claude Code 中说：

```
Interview me to fill out my CLAUDE.md
```

Claude 会逐一采访你——你是谁、你的目标、你的项目、你的沟通偏好——然后写入 `CLAUDE.md`。从此每次对话，Claude 都自动了解你。

---

## 架构

```
brain/
├── raw/                    # ① 原始资料层 — 你扔进来的东西，永不修改
│   ├── articles/           #   Web Clipper 剪藏的文章
│   ├── podcast-notes/      #   播客/视频笔记
│   ├── book-chapters/      #   书籍章节
│   └── assets/             #   图片等附件
│
├── wiki/                   # ② Wiki 层 — Claude 全权维护的知识产物
│   ├── entities/           #   实体页（人物、概念、工具、术语）
│   ├── topics/             #   主题综述（跨来源的知识合成）
│   ├── sources/            #   每篇原始资料的摘要页
│   ├── comparisons/        #   对比分析
│   └── lint-reports/       #   定期健康检查报告
│
├── projects/               # ③ 项目层 — 具体工作的交付物
│
├── skills/                 # ④ 技能 — 可复用的工作流
│   ├── ingest.md           #   摄入新资料（读→讨论→写摘要→更新实体→更新索引）
│   ├── lint.md             #   健康检查（矛盾/过时/孤儿/去重/剔除/空白）
│   └── query-and-keep.md   #   查询归档（问→答→问是否保存回 wiki）
│
├── CLAUDE.md               # ⑤ Schema + 个人画像（每次会话自动加载）
├── index.md                # ⑥ 全 wiki 内容目录
└── log.md                  # ⑦ 操作日志（按时间追加）
```

### 核心设计原则

| 原则 | 说明 |
|------|------|
| **去重优于新增** | 新概念优先合并到已有页面作为小节，不轻易创建独立页面 |
| **剔除保持简洁** | 单源人物、细粒度数据集、过期 stub 应被降级或删除 |
| **连接密度 > 页面数量** | 10 个紧密互联的页面远比 50 个孤立页面有价值 |
| **纯文本 + Git** | 所有知识是本地 markdown 文件，属于你，永不锁定 |
| **权限靠钥匙** | 对敏感数据只授予只读权限，不靠提示词防守 |

---

## 日常使用

### 操作 1: Ingest（每周 2-5 次）

用浏览器 **Obsidian Web Clipper** 扩展剪藏文章到 `raw/articles/`，然后：

```
ingest raw/articles/那篇文章.md
```

Claude 会：读文章 → 和你讨论要点 → 创建摘要页 → 更新/创建相关实体页 → 更新主题综述 → 检查与已有知识的矛盾 → 更新 index → 追加 log。

### 操作 2: Query（随时）

直接提问。Claude 会先读 `index.md` 定位相关页面，再深读并综合回答，带引用链接。

**回答之后**，Claude 会问你是否归档这个分析——如果说"是"，它就变成一个新 wiki 页面，你的知识库又丰富了一层。

### 操作 3: Lint（每周一次）

```
lint
```

Claude 会扫描：矛盾检测、过时页面、孤儿页面、缺失交叉引用、可合并/剔除的细粒度概念、知识空白。完整报告写入 `wiki/lint-reports/`。

### 使用节奏

```
每天                        每周                        每月
───                        ───                        ───
看到好文章 → 剪藏         周日晚上 → lint             回顾图谱：知识网络是否健康？
说 "ingest xxx"            阅读 lint 报告             调整 CLAUDE.md 中的规则
浏览图谱看新连接           处理过时/矛盾页面           
随时提问
```

---

## 安装与依赖

### 必装
- **[Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview)** — AI 大脑，读写 markdown、维护 wiki
- **[Obsidian](https://obsidian.md)** — 可视化浏览器，提供图谱视图和反向链接面板
- **Obsidian Local REST API 插件** — Claude 的入口（Obsidian 社区插件商店免费安装）

### 推荐
- **[Obsidian Web Clipper](https://obsidian.md/clipper)** 浏览器扩展 — 一键剪藏网页文章
- **Obsidian 图片本地化快捷键** — 设置 → 快捷键 → 搜索"下载" → 绑定 `Cmd+Shift+D`

---

## 小贴士

- **每次只 ingest 一篇**：逐篇处理，在每次摄入时参与讨论，引导 AI 的关注方向
- **从 stub 开始**：新实体只需标题 + 一句话定义，随着更多资料摄入自然扩展
- **用好 callout**：`📌 Key Insight`、`⚠️ Contradiction`、`❓ Open Question` 是 wiki 的"高亮标记"
- **合并不要怕**：发现两个页面说的是同一件事时立即合并——小 wiki 不怕页面少，怕概念碎片化
- **图谱视图每天看一次**：`Cmd+G` 打开，枢纽节点 = 核心概念，孤立节点 = 漏掉的交叉引用
- **Git 就是后悔药**：重大操作前 `git commit`，出错了 `git reset --hard`

---

## 进阶方向

当 wiki 超过 50 个页面后：
- 添加 **[qmd](https://github.com/tobi/qmd)** 本地搜索引擎（BM25 + 向量混合搜索）
- 安装 **Dataview** Obsidian 插件，基于 frontmatter 生成动态列表
- 为重复出现的写作任务创建更多**自定义技能**
- 接入**实时数据源**（Google Calendar 只读 → 会议要点自动入 wiki）

---

## 致谢

- **Andrej Karpathy** — [LLM Wiki 原始概念](https://github.com/karpathy/llm-wiki)（2026 年 4 月）
- **Yarchi ([@undefinedKi](https://x.com/undefinedKi))** — 社区实操教程
- 所有为 LLM Wiki 生态贡献开源项目的开发者

---

## 许可证

MIT — 这些只是 markdown 文件和文本。拿去用，改造成你自己的。
