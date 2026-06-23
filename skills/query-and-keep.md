---
skill: query-and-keep
trigger: When the user's question requires synthesizing across multiple wiki pages
description: Query the wiki, synthesize an answer, then archive the analysis as a new wiki page
---

# Query-and-Keep: Query and Archive

## Core Philosophy
Good answers shouldn't disappear into chat history. If an analysis synthesizes multiple wiki pages, reveals new connections, or is likely to be needed again — it should become a wiki page. This way, every question enriches the knowledge base.

> From Karpathy's original LLM Wiki concept: "good answers can be filed back into the wiki as new pages. This way your explorations compound in the knowledge base just like ingested sources do."

## Workflow

### 1. Locate Relevant Pages
- Read `index.md` first, find all potentially relevant pages (typically 3–10)

### 2. Deep Read
- Read full text of each candidate page
- Note hidden connections, contradictions, complementary coverage

### 3. Synthesize Answer
- Comprehensive answer with **mandatory** `[[citation links]]`
- Use callouts: `📌 Key Insight`, `⚠️ Contradiction`, `❓ Open Question`, `🔗 See Also`

### 4. Archive Prompt (MUST NOT skip)
After answering, **must** ask:
> "This analysis synthesizes N pages. Want me to archive it to `wiki/topics/` or `wiki/comparisons/`?"

### 5. If "Yes"
- Create the page with full frontmatter, analysis, and bidirectional links
- Update `index.md` and `log.md`

### 6. If "No"
- Do not create a page; append a brief query record to `log.md`
