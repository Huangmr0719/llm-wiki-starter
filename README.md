# LLM Wiki Starter

> A one-command starter kit for building a self-maintaining AI knowledge base with Claude Code + Obsidian. Based on [Andrej Karpathy's LLM Wiki pattern](https://github.com/karpathy/llm-wiki).

🔗 **中文用户? 请阅读 [README.zh-CN.md](README.zh-CN.md)** | Want Chinese versions of all working files? Run `./setup.sh` and select `2`.

---

## What is this?

Your best ideas are scattered across a dozen places: notes apps, browser tabs, Claude conversations you've already closed. Every time you sit down to work, you rebuild context from memory — and most of it you've forgotten.

**LLM Wiki solves this.** It's a self-growing markdown knowledge base. You drop articles in, AI reads them, writes summaries, and builds connections between ideas. It's not RAG (re-retrieving from scratch every query) — it's **incremental building**. Knowledge is compiled once, then kept current, growing richer with every use.

```
You (human)                   Claude (AI)                    Obsidian (UI)
──────────                    ──────────                    ──────────
Curate sources → raw/   →    Read, extract, summarize
Ask good questions      →    Search wiki, synthesize
Periodic check          →    Find contradictions, stale, orphans
Browse graph            ←    All output → wiki/             →  Graph view
```

---

## Quick Start

### Prerequisites
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) CLI (requires Pro subscription, $20/month)
- [Obsidian](https://obsidian.md) (free, for visual browsing)
- [Git](https://git-scm.com) (pre-installed on macOS/Linux)

### 3 Steps

```bash
# 1. Clone
git clone https://github.com/Huangmr0719/llm-wiki-starter.git ~/brain
cd ~/brain

# 2. Pick your language (optional — root files are English by default)
./setup.sh
# Enter 1 for English (default, no changes needed)
# Enter 2 for 中文 (Chinese CLAUDE.md + skills)

# 3. Open this folder as an Obsidian vault
#    Settings → Community plugins → Enable → Search "Local REST API" → Install → Enable
#    Copy the API Key (do NOT include the "Bearer" prefix)

# 4. Connect Claude Code
claude mcp add-json obsidian-vault '{ "type": "stdio", "command": "uvx", "args": ["mcp-obsidian"], "env": { "OBSIDIAN_API_KEY": "your-key", "OBSIDIAN_HOST": "127.0.0.1", "OBSIDIAN_PORT": "27124" } }'
```

Then in Claude Code, say:

```
Interview me to fill out my CLAUDE.md
```

Claude will interview you one question at a time — who you are, your goals, your projects, your communication preferences — and write it all to `CLAUDE.md`. Every session after that, Claude automatically knows you.

---

## Architecture

```
brain/
├── raw/                    # ① Raw sources — immutable, read-only
│   ├── articles/           #   Web clippings, papers
│   ├── podcast-notes/      #   Podcast / video notes
│   ├── book-chapters/      #   Book chapters
│   └── assets/             #   Image attachments
│
├── wiki/                   # ② Wiki layer — Claude-maintained knowledge
│   ├── entities/           #   Entity pages (people, concepts, tools, terms)
│   ├── topics/             #   Topic synthesis (cross-source)
│   ├── sources/            #   Source summaries (1:1 with raw/)
│   ├── comparisons/        #   Comparison analyses
│   └── lint-reports/       #   Periodic health-check reports
│
├── projects/               # ③ Project layer — deliverables
│
├── skills/                 # ④ Skills — reusable workflows
│   ├── ingest.md           #   Ingest new material
│   ├── lint.md             #   Health check (contradictions/stale/orphans/dedup/prune)
│   └── query-and-keep.md   #   Query and archive
│
├── i18n/                   # ⑤ Translations
│   └── zh-CN/              #   Chinese versions of CLAUDE.md + skills
│
├── setup.sh                # ⑥ Language selector
├── CLAUDE.md               # ⑦ Schema + personal profile (auto-loaded every session)
├── index.md                # ⑧ Wiki content catalog
└── log.md                  # ⑨ Chronological operation log
```

### Core Design Principles

| Principle | Description |
|-----------|-------------|
| **Dedup over new pages** | New concepts are merged as subsections of existing pages whenever possible |
| **Prune to stay lean** | Single-source people, fine-grained datasets, expired stubs get demoted or deleted |
| **Connection density > page count** | 10 densely connected pages are far more valuable than 50 isolated ones |
| **Plain text + Git** | All knowledge is local markdown files — yours forever, zero lock-in |
| **Security via keys** | Grant read-only access to sensitive data; never rely on text instructions for safety |

---

## Daily Usage

### Operation 1: Ingest (2-5 times per week)

Clip an article to `raw/articles/` using the **Obsidian Web Clipper** browser extension, then:

```
ingest raw/articles/that-article.md
```

Claude will: read the article → discuss key points with you → create a source summary → update/create entity pages → update topic syntheses → check for contradictions with existing knowledge → update index → append log.

### Operation 2: Query (anytime)

Ask questions. Claude reads `index.md` first to locate relevant pages, then deep-reads and synthesizes an answer with citations.

**After answering**, Claude will ask whether to archive the analysis — say yes, and it becomes a new wiki page.

### Operation 3: Lint (weekly)

```
lint
```

Claude scans for: contradictions, stale pages, orphan pages, missing cross-references, concepts to dedup or prune, knowledge gaps. A full report is written to `wiki/lint-reports/`.

### Usage Rhythm

```
Daily                        Weekly                       Monthly
─────                        ──────                       ──────
Clip interesting articles    Sunday evening → lint        Review graph: is the network healthy?
Say "ingest xxx"             Read the lint report         Adjust CLAUDE.md rules
Browse the graph view        Handle stale/contradictions
Ask questions anytime
```

---

## Tips

- **Ingest one at a time**: Don't batch. Discuss each one with Claude to guide its focus
- **Start with stubs**: A new entity only needs a title + one sentence definition. Claude will expand it as more sources come in
- **Use callouts**: `📌 Key Insight`, `⚠️ Contradiction`, `❓ Open Question` — these are the wiki's "highlighters"
- **Merge fearlessly**: If two pages say the same thing, merge them immediately. A small wiki fears page count, not concept fragmentation
- **Check graph view daily**: `Cmd+G` — hub nodes = core concepts, orphans = missed cross-references
- **Git is your undo button**: `git commit` before major operations, `git reset --hard` to roll back

---

## Multilingual Support

```
User clones the repo
    │
    ├─ English user (default): root files are already English — no setup needed
    │
    └─ Chinese user: run ./setup.sh → select 2 → i18n/zh-CN/ files overwrite root
```

To contribute a translation: create a new directory under `i18n/` (e.g., `ja/`, `ko/`, `fr/`), translate `CLAUDE.md` and the three skill files, then add an option to `setup.sh`.

---

## Going Further

When your wiki exceeds 50 pages:
- Add **[qmd](https://github.com/tobi/qmd)** for local hybrid search (BM25 + vector)
- Install **Dataview** Obsidian plugin for dynamic lists from frontmatter
- Create **custom skills** for recurring writing tasks
- Connect **real-time data sources** (Google Calendar read-only → meeting notes into wiki)

---

## Acknowledgements

- **Andrej Karpathy** — [LLM Wiki original concept](https://github.com/karpathy/llm-wiki) (April 2026)
- **Yarchi ([@undefinedKi](https://x.com/undefinedKi))** — community practical guide
- All open-source contributors to the LLM Wiki ecosystem

---

## License

MIT — these are just markdown files and text. Take them, remix them, make them yours.
