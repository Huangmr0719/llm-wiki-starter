# CLAUDE.md — LLM Wiki Schema & Personal Profile

> **Description**: This file is loaded automatically at the start of every Claude Code session. You need to complete two parts: **(1) Let Claude interview you to fill in your personal profile**, **(2) Wiki conventions are pre-configured and can be adjusted as needed**.
>
> **Quick start**: In Claude Code, say `Interview me to fill out my CLAUDE.md`. Claude will ask questions one at a time and write your answers here.
>
> 🌐 **中文用户?** Run `./setup.sh` and select `zh-CN` for Chinese versions of all files, or read [README.zh-CN.md](README.zh-CN.md).

---

## 1. About Me (to be filled)

*Let Claude interview you and fill in the following. Or fill it in manually.*

### Identity
- **Name**: [Your name]
- **Role**: [Your role / title]
- **Field**: [Your domain / expertise]

### Annual Goals
1. [Goal 1]
2. [Goal 2]
3. [Goal 3]

### Current Projects
- **[Project name]**: [Brief description]
- **[Project name]**: [Brief description]

### Self-Assessment
- **Strengths**: [What you're good at]
- **Areas to improve**: [What you want to get better at]

### Interests
- [Domain / topic 1]
- [Domain / topic 2]

### Communication Preferences
- **Style**: [Formal / Casual]
- **Technical depth**: [Brief / Deep-dive / From-shallow-to-deep]
- **Language**: [English / Chinese / Mixed]

---

## 2. Wiki Conventions

### Directory Architecture

```
vault/
├── raw/                    # ① Raw sources — immutable, read-only
│   ├── articles/           #   Web clippings, papers, articles
│   ├── podcast-notes/      #   Podcast / video notes
│   ├── book-chapters/      #   Book chapters
│   └── assets/             #   Image attachments
├── wiki/                   # ② Wiki layer — fully maintained by Claude
│   ├── entities/           #   Entity pages (people, tools, concepts, terms)
│   ├── topics/             #   Topic synthesis (cross-source knowledge)
│   ├── sources/            #   Source summaries (one-to-one with raw/)
│   ├── comparisons/        #   Comparison analyses (A vs B)
│   └── lint-reports/       #   Periodic health-check reports
├── projects/               # ③ Project layer — deliverables
├── skills/                 # ④ Skills — reusable workflows
│   ├── ingest.md           #   Ingest new material
│   ├── lint.md             #   Health check
│   └── query-and-keep.md   #   Query and archive
├── CLAUDE.md               # ⑤ This file — Schema + personal profile
├── index.md                # ⑥ Navigation — wiki content catalog
└── log.md                  # ⑦ Log — chronological operation log
```

### Page Naming Conventions
- Entity: `wiki/entities/<Name>.md`
- Topic: `wiki/topics/<Topic>.md`
- Source: `wiki/sources/<Title>.md`
- Comparison: `wiki/comparisons/<A-vs-B>.md`
- Lint report: `wiki/lint-reports/YYYY-MM-DD.md`

### Frontmatter (required on every wiki page)

```yaml
---
type: entity | topic | source | comparison | lint-report
tags: [tag1, tag2]
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: [[source-page-1]], [[source-page-2]]
status: stub | draft | complete | stale
---
```

- `stub`: Title + one sentence only, awaiting expansion
- `draft`: Has content but incomplete
- `complete`: Sufficient and up-to-date
- `stale`: May contain outdated information, needs review

### Cross-Referencing Rules

1. Every concept/entity mentioned in body text that has (or should have) a wiki page **must** be linked with `[[double brackets]]`
2. Every important claim must link to its source page (link to `wiki/sources/` page)
3. When creating a new page, search the existing wiki for all pages that mention the topic and add backlinks
4. Use the following callouts to annotate special information:
   - `> ⚠️ Contradiction:` — This claim contradicts another page, with link to the conflicting page
   - `> 📌 Key Insight:` — Important cross-source synthesis finding
   - `> ❓ Open Question:` — Unresolved question worth investigating
   - `> 🔗 See Also:` — Related pages not directly cited in body text

### Concept Deduplication Rules

**Before creating a new entity page, always check whether a related page already exists:**

1. **Search existing concepts**: Search `index.md` and `wiki/entities/` for keywords related to the new concept
2. **Determine hierarchy**: If the new concept is a **sub-topic or special case** of an existing concept (e.g., FACS is the definition framework for AUs, identity decoupling is an application of disentanglement), merge it as a subsection of the existing page rather than creating a standalone page
3. **Merge, don't parallelize**: Two pages should be merged if any of the following is true:
   - A is the definition/framework of B
   - A is a specific application instance of B
   - A and B describe the same thing under different names
4. **Clean up after merging**: After deleting the old page, search the entire vault for all `[[old page name]]` references and replace them with `[[merged page name]]`. Ensure index.md and log.md are also updated
5. **Page size trade-off**: If an entity page is only 2-3 sentences and has no standalone reading value, it should be merged. Stub pages should be merged into the nearest parent unless expected to expand significantly with more ingests

### Concept Pruning Rules

**Wiki value lies in connection density, not page count. The following should be pruned or demoted:**

1. **Single-source persons**: If a researcher is mentioned in only one source and has no other independent value, merge their info into the source page or the corresponding concept page as an "Author/Proposer" section. Do NOT create standalone person pages
2. **Dataset/tool entities**: Unless a dataset is a core object of your research (appearing repeatedly, requiring detailed comparison), keep it as a subsection of its corresponding concept page
3. **The 3-link rule**: If a page has fewer than 3 connections to other pages and hasn't been touched in the last 5 ingests, it should be merged or demoted to a subsection
4. **Stub expiry**: If a stub hasn't expanded beyond 3 sentences after 5 ingests, merge it into the most relevant parent page
5. **Prune on every lint**: After the "dedup check" step, scan all pages and recommend or execute pruning for pages matching the above criteria
6. **Anti-patterns to avoid**:
   - Don't create a page for every minor concept mentioned in a paper (only core concepts that will be repeatedly referenced)
   - Don't create standalone pages for person names unless they appear across multiple sources or have independent research contributions worth knowing
   - Datasets, tools, and evaluation metrics are typically subsections of parent pages, not standalone pages

### Markdown Formatting
- Heading levels: `#` page title (unique), `##` major section, `###` sub-section
- Code blocks with language: ` ```python `, ` ```bash `, ` ```yaml ` etc.
- Math formulas: LaTeX syntax, inline `$...$`, display `$$...$$`

---

## 3. Core Operations

### Operation 1: Ingest

**Trigger**: Say `ingest <filename>` or "process new files in raw/"

**Workflow**:
1. **Read**: Read the specified file from `raw/`
2. **Discuss**: Extract 3-5 key takeaways, discuss with the user about emphasis and unexpected findings
3. **Create source page**: Create a summary page in `wiki/sources/` with frontmatter, full summary, and key quotes
4. **Update entity/topic pages**: For each entity/concept mentioned —
   - **Run dedup check first**: Search existing pages to determine if the new concept is a sub-topic/special-case/synonym of an existing one
   - If sub-topic or special case → merge as a subsection, do NOT create standalone page
   - If page already exists → update with new information
   - If genuinely new and cannot be merged → create stub (status: stub)
   - Update all affected `wiki/topics/` pages
5. **Cross-reference & contradiction check**: Search existing wiki → add `[[bidirectional links]]` → check for contradictions → annotate with callouts
6. **Update navigation**: Update affected entries in `index.md`; append record to `log.md`
7. **Git commit**: If ≥ 5 files changed, `git commit` before starting; always commit after completion
8. **Report**: Summarize pages touched, new pages created, contradictions or open questions found

### Operation 2: Query

**Workflow**:
1. **Locate**: Read `index.md` first to find relevant pages (typically 3-10)
2. **Deep-dive**: Read full text of relevant pages, noting hidden connections and contradictions
3. **Answer**: Provide comprehensive answer with `[[citation links]]`; use callouts for key findings
4. **Archive prompt** (DO NOT skip): After answering, **must** ask:
   > "This analysis synthesizes N pages. Want me to archive it to `wiki/topics/` or `wiki/comparisons/`?"
   - If yes → write to wiki → update index → append log
   - If no → don't archive, but retain the analysis path

### Operation 3: Lint

**Trigger**: Say `lint` or run weekly

**Workflow**:
1. **Contradiction scan**: Cross-compare all pages, annotate `⚠️ Contradiction` on both sides
2. **Stale detection**: If `updated` > 30 days and contains time-sensitive content → mark `status: stale`
3. **Orphan pages**: Pages with zero inbound links → add links or justify standalone existence
4. **Red links**: Scan all `[[links to non-existent pages]]`, list Top 10 by citation count
5. **Missing cross-references**: Auto-add `[[links]]` for entities mentioned in text but not linked
6. **Dedup check**: Scan for mergeable concept pairs, propose and execute
7. **Pruning**: Scan single-source persons, fine-grained entities, expired stubs → propose and execute
8. **Knowledge gaps**: Suggest 3-5 new research questions + 2-3 new sources to seek
9. **Write report**: Full report to `wiki/lint-reports/YYYY-MM-DD.md`

---

## 4. Maintenance Principles

- **Permission via keys, not prompts**: Grant read-only access to sensitive data (email, calendar); never rely on text instructions for security
- **Raw sources are immutable**: All files in `raw/` are never modified, read-only
- **Always update index.md and log.md after every operation**: These two files are the navigation backbone of the entire wiki
- **Git as safety net**: `git commit` before major operations, `git reset --hard` to roll back
- **Wiki belongs to you, not the tool**: All files are local markdown + git, readable by any model/tool, never locked in
- **Fewer pages, more value**: One content-dense page is better than ten one-sentence pages
