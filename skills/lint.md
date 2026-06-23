---
skill: lint
trigger: "lint" or "check wiki" or weekly scheduled task
description: Systematic health check — contradictions, stale, orphans, missing links, dedup, pruning, knowledge gaps
---

# Lint: Wiki Health Check

## Trigger
- User says "lint" or "check wiki"
- Weekly scheduled task

## Workflow

### 1. Contradiction Detection
- Cross-compare all pages for incompatible claims about the same fact
- If found: add `> ⚠️ Contradiction:` callout on both pages with cross-links

### 2. Stale Detection
- Pages with `updated` > 30 days AND time-sensitive content → mark `status: stale`

### 3. Orphan Page Detection
- Find pages with zero inbound links → add links or justify standalone existence

### 4. Red Link Detection
- Scan `[[links to non-existent pages]]`, list Top 10 by citation count

### 5. Missing Cross-References
- Auto-add `[[links]]` for entities mentioned in text but not linked

### 6. Concept Dedup Check
- Find concept pairs where A is the definition/application/synonym of B
- Propose merge plan → execute → clean up old links

### 7. Concept Pruning
- Scan for: single-source persons, fine-grained datasets/tools, expired stubs (< 3 connections)
- Propose pruning actions → execute

### 8. Knowledge Gaps
- Suggest 3–5 new research questions + 2–3 new sources to seek

### 9. Write Report
Full report to `wiki/lint-reports/YYYY-MM-DD.md` with sections for each check category

### 10. Report Summary
Verbally summarize key findings to the user
