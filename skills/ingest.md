---
skill: ingest
trigger: "ingest <filename>" or "process new files in raw/"
description: Integrate a raw source into the wiki — update pages, cross-references, and index
---

# Ingest: Process New Material

## Trigger
- User says "ingest `<filename>`"
- User adds a new file to `raw/` and asks you to process it
- Batch: User says "ingest all new files in raw/"

## Workflow

### 1. Read the Source
- Read the specified file from `raw/` in full
- If images are present: read text first, then view images for additional context

### 2. Extract and Discuss
- Extract 3–5 key takeaways, summarize the core argument
- Discuss with the user:
  - What deserves emphasis?
  - Any surprising findings or contradictions with existing knowledge?
  - Which angle does the user care about most?

### 3. Create Source Page
Create a summary page in `wiki/sources/` with this structure:

```markdown
---
type: source
tags: [relevant tags]
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: [[corresponding file in raw/]]
status: complete
---
# Source Title
## Source Info
- Author / Origin
- Date
- URL (if applicable)

## Key Takeaways
1. ...
2. ...

## Notable Quotes
> Worth-preserving excerpts from the source

## Personal Notes
- Connections to existing knowledge
- Directions worth exploring further
```

### 4. Update Entity and Topic Pages
- For each **entity** mentioned (person, institution, tool, concept, term):
  - **Run dedup check first**: Search `wiki/entities/` and `index.md` for synonymous or overlapping concepts
  - **Determine hierarchy**: If the new concept is a sub-topic or special case of an existing page → merge as a subsection, do NOT create a standalone page
  - If `wiki/entities/<name>.md` already exists → append new information, update `updated` date
  - If it doesn't exist AND is not a sub-topic → create a stub:
    ```markdown
    ---
    type: entity
    tags: [...]
    created: YYYY-MM-DD
    updated: YYYY-MM-DD
    sources: [[this source page]]
    status: stub
    ---
    # Name
    One-sentence definition. [[source link]]
    ```
- Update all relevant `wiki/topics/` pages

### 5. Cross-Referencing & Contradiction Detection
- Search existing wiki for all pages related to this source's topics
- Add bidirectional `[[links]]` between new and existing pages
- **Contradiction check**: Does the new information contradict any existing wiki page?
  - If found: add `> ⚠️ Contradiction:` callout on **both** pages

### 6. Update Navigation
- **index.md**: Add/update entries under relevant categories
- **log.md**: Append a record

### 7. Git Commit
- If ≥ 5 files changed: `git commit -m "pre-ingest: <title>"` before starting
- After completion: `git commit -m "ingest: <title>"`

### 8. Report
Report to the user: new pages created, pages updated, contradictions or open questions found
