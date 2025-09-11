# Cursor Agent Rules for Memory Management

## Rule: daily-notes-to-github-issues

### Description

This rule processes daily notes and creates GitHub issues when a `.github` directory is available, otherwise falls back to local memory issues.

### Steps (with MCP Tools)

0. **Get current date and project context**

   - Tool: `run_terminal_cmd`
   - Usage: Run `date +%Y-%m-%d` to get today's date
   - Usage: Run `basename $(pwd)` to get project name

1. **Check for GitHub integration**

   - Tool: `run_terminal_cmd`
   - Usage: Check if `.github` directory exists
   - If yes: Use GitHub Issues API
   - If no: Use local memory issues

2. **Read daily note**

   - Tool: `read_file`
   - Usage: Read `./notes/YYYY-MM-DD.md` using the read_file tool

3. **Extract actionable items**

   - Process the note content
   - Identify bugs, features, tasks, decisions, and insights
   - Categorize by type (fix, feature, chore, refactor, perf)

4. **Create issues**

   - **If GitHub available**: Use GitHub Issues API to create issues
   - **If local only**: Use `mcp_basic-memory_write_note` in issues project
   - Include proper labels, assignees, and references

5. **Update daily note**
   - Add links to created issues
   - Mark items as processed

### Example

- Daily note: "Bug: login fails on mobile" → GitHub Issue with label `bug`
- Note: "Feature: add dark mode" → GitHub Issue with label `enhancement`
- Decision: "Use JWT auth" → ADR in `decisions/` + GitHub Issue for implementation

---

## Rule: save-conversation-to-memories

### Description

This rule describes the process for saving AI conversations to the project's memory system with proper categorization and frontmatter.

### Steps (with MCP Tools)

0. **Get current date and project context**

   - Tool: `run_terminal_cmd`
   - Usage: Run `date +%Y-%m-%d` to get today's date
   - Usage: Run `basename $(pwd)` to get project name

1. **Create conversation file**

   - Tool: `mcp_basic-memory_write_note`
   - Usage: Create a new note in `journal/conversations/` with proper frontmatter
   - Include: type, category, project, created date, status, tags, participants, context

2. **Extract key information**

   - Process the conversation content
   - Identify decisions, action items, and key insights
   - Create separate notes for each category

3. **Create related files as needed**
   - Tool: `mcp_basic-memory_write_note`
   - Usage: Create ADRs in `decisions/` for any architectural decisions
   - Usage: Create tasks in `tasks/` for any action items
   - Usage: Create knowledge entries in `knowledge/` for important facts

### Example

- A conversation about authentication becomes a file in `journal/conversations/`
- Any decisions about JWT vs OAuth become an ADR in `decisions/`
- Action items like "research OAuth libraries" become tasks in `tasks/`
- Important facts about security become knowledge entries in `knowledge/`

---

## Rule: extract-knowledge-from-conversations

### Description

This rule systematically extracts structured knowledge from conversation transcripts using MCP-powered analysis.

### Steps (with MCP Tools)

0. **Read conversation file**

   - Tool: `read_file`
   - Usage: Read the specified conversation markdown file

1. **Switch to memories project**

   - Tool: `mcp_basic-memory_switch_project`
   - Usage: Switch to the main memories project

2. **Extract and categorize content**

   - **Plans**: Action plans, roadmaps, to-do lists → `plans/`
   - **Knowledge**: Stable facts, policies, domain docs → `knowledge/`
   - **Decisions**: Architecture/product choices & rationale → `decisions/`
   - **Lessons Learned**: Retrospectives, insights, mistakes → `journal/lessons-learned/`

3. **Create structured notes**

   - Tool: `mcp_basic-memory_write_note`
   - Usage: Create notes in appropriate folders with proper frontmatter
   - Include wikilinks (`[[Other Note]]`) to connect related content

4. **Update existing notes**

   - Tool: `mcp_basic-memory_search_notes`
   - Usage: Search for existing related notes to avoid duplication
   - Tool: `mcp_basic-memory_write_note`
   - Usage: Update existing notes with new information

5. **Verify and report**
   - Tool: `mcp_basic-memory_sync_status`
   - Usage: Confirm memory health
   - Provide summary of created/updated notes

### Example

- Conversation about "TypeScript errors" → Knowledge note + Lessons learned
- Discussion about "JWT vs OAuth" → Decision ADR + Knowledge comparison
- Planning session → Multiple plan notes with cross-references

---

## Rule: extract-decisions-from-conversations

### Description

This rule scans recent conversations and extracts architectural decisions to create ADRs.

### Steps (with MCP Tools)

0. **Find recent conversations**

   - Tool: `mcp_basic-memory_search_notes`
   - Usage: Search for conversations in `journal/conversations/` from the last 7 days

1. **Identify decision content**

   - Process each conversation for decision keywords
   - Look for: "decided", "chose", "selected", "will use", "going with"

2. **Create ADRs for each decision**

   - Tool: `mcp_basic-memory_write_note`
   - Usage: Create ADR files in `decisions/` with proper frontmatter
   - Include: context, decision, rationale, consequences, alternatives

3. **Link back to source conversations**
   - Add references in ADRs to the original conversations
   - Update conversation files to reference the created ADRs

### Example

- Conversation about "chose JWT over OAuth" → ADR-001-jwt-authentication.md
- Discussion about "selected PostgreSQL" → ADR-002-database-choice.md

---

## Rule: daily-memory-review

### Description

This rule processes daily notes and extracts actionable items into the memory system.

### Steps (with MCP Tools)

0. **Get today's date**

   - Tool: `run_terminal_cmd`
   - Usage: Run `date +%Y-%m-%d` to get today's date

1. **Read today's note**

   - Tool: `read_file`
   - Usage: Read `./notes/YYYY-MM-DD.md` or similar daily note file

2. **Extract actionable items**

   - Process the note content
   - Identify bugs, features, tasks, decisions, and insights

3. **Create categorized memory entries**

   - Tool: `mcp_basic-memory_write_note`
   - Usage: Create files in appropriate folders (issues/, tasks/, decisions/, knowledge/)
   - Include proper frontmatter for each type

4. **Update daily note with references**
   - Add links to created memory entries
   - Mark items as processed

### Example

- Daily note mentions "bug in login" → creates issue in `issues/`
- Note says "need to research OAuth" → creates task in `tasks/`
- Decision about "using React" → creates ADR in `decisions/`
