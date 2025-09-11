#!/usr/bin/env bash
set -euo pipefail

# Complete Memory System Setup Script
# Based on the 10-lesson course: "Create an AI-Automated MCP-Driven Markdown Knowledge Base"

echo "🚀 Setting up Complete AI Memory System..."

# Ensure we're using the correct Homebrew context
if [[ "$(uname -m)" == "arm64" && -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  BREW_BIN="/opt/homebrew/bin"
elif [[ -f "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
  BREW_BIN="/usr/local/bin"
else
  echo "Error: Homebrew not found" >&2
  exit 1
fi

# Resolve repo root and name
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  ROOT="$(git rev-parse --show-toplevel)"
  NAME="$(basename "$ROOT")"
else
  ROOT="$(pwd)"
  NAME="$(basename "$ROOT")"
fi

MEM_DIR="$ROOT/memories"

echo "📁 Setting up project: $NAME in $ROOT"

# 1. Install basic-memory if not already installed
if ! command -v bm &> /dev/null; then
  echo "📦 Installing basic-memory..."
  brew tap basicmachines-co/basic-memory
  brew install basic-memory
else
  echo "✅ basic-memory already installed"
fi

# 2. Install cursor-history tool
if ! command -v chi &> /dev/null; then
  echo "📦 Installing cursor-history..."
  pnpm install -g @johnlindquist/cursor-history@latest
else
  echo "✅ cursor-history already installed"
fi

# 3. Create memories directory structure
echo "📂 Creating memories directory structure..."
mkdir -p "$MEM_DIR"/{knowledge/domain-notes,plans/specs,issues,decisions,tasks,journal/conversations,journal/lessons-learned,snippets,inbox,notes}

# 4. Create seed files with proper frontmatter
echo "📝 Creating seed files..."

# Main index with routing rules
cat > "$MEM_DIR/_index.md" << EOF
---
type: index
category: system
project: $NAME
created: $(date +"%Y-%m-%d")
tags: [index, routing, system]
---

# Memory System

## Routing Rules
- **facts** → \`knowledge/\`
- **plans/specs** → \`plans/\`
- **problems/risks/questions** → \`issues/\` (or GitHub Issues if .github exists)
- **decisions** → \`decisions/\` (ADRs)
- **tasks/checklists** → \`tasks/\`
- **daily summaries** → \`journal/\`
- **conversations** → \`journal/conversations/\` (AI chat transcripts)
- **lessons learned** → \`journal/lessons-learned/\`
- **unsure** → \`inbox/\` with \`route-to:\` hint

## Quick Commands
- \`mem save-conversation "title"\` - Save current AI conversation
- \`mem create-adr "title"\` - Create a new ADR
- \`mem extract-knowledge\` - Extract knowledge from conversations
- \`mem daily-to-issues\` - Process daily notes to issues
- \`chi --select\` - Export Cursor conversations
- \`mem search "query"\` - Search across all content

## GitHub Integration
- If \`.github/\` directory exists, issues are created as GitHub Issues
- Otherwise, issues are stored locally in \`issues/\` directory
- ADRs are always stored locally for project documentation

## Workflow
1. **Daily Notes**: Use Foam extension (Option+D) to capture thoughts
2. **Conversations**: Export with \`chi --select\` or save with \`mem save-conversation\`
3. **Knowledge Extraction**: Use \`mem extract-knowledge\` to process conversations
4. **Issue Creation**: Use \`mem daily-to-issues\` to process daily notes
5. **Decision Tracking**: Use \`mem create-adr\` for architectural decisions
EOF

# Knowledge files
cat > "$MEM_DIR/knowledge/glossary.md" << EOF
---
type: knowledge
category: glossary
project: $NAME
created: $(date +"%Y-%m-%d")
tags: [glossary, terms, definitions]
---

# Glossary

## Terms
<!-- Add domain-specific terms and definitions here -->

## Acronyms
<!-- Add project-specific acronyms here -->

## Domain Knowledge
<!-- Add stable facts, policies, and domain-specific information -->
EOF

# Plan files
cat > "$MEM_DIR/plans/intent.md" << EOF
---
type: plan
category: intent
project: $NAME
created: $(date +"%Y-%m-%d")
status: draft
tags: [intent, goals, objectives]
---

# Project Intent

## Current Goals
<!-- Define the main objectives and purpose of this project -->

## Success Criteria
<!-- What does success look like for this project? -->

## Constraints
<!-- Any limitations or constraints to consider -->

## Vision
<!-- Long-term vision and direction -->
EOF

cat > "$MEM_DIR/plans/roadmap.md" << EOF
---
type: plan
category: roadmap
project: $NAME
created: $(date +"%Y-%m-%d")
status: draft
tags: [roadmap, milestones, timeline]
---

# Roadmap

## Milestones
<!-- High-level project milestones and timeline -->

## Current Phase
<!-- What phase are we currently in? -->

## Next Steps
<!-- Immediate next steps to take -->

## Dependencies
<!-- External dependencies and blockers -->
EOF

# Task files
cat > "$MEM_DIR/tasks/next.md" << EOF
---
type: task
category: sprint
project: $NAME
created: $(date +"%Y-%m-%d")
status: active
tags: [tasks, sprint, backlog]
---

# Next Tasks

## Current Sprint
- [ ] <!-- Add immediate tasks here -->

## Backlog
- [ ] <!-- Add future tasks here -->

## Completed
- [x] <!-- Move completed tasks here -->

## Blocked
- [ ] <!-- Tasks waiting on external dependencies -->
EOF

# 5. Set up basic-memory project
echo "🔧 Setting up basic-memory project..."
"$BREW_BIN/bm" project add "$NAME" "$MEM_DIR" >/dev/null 2>&1 || true

# 6. Create VS Code/Foam settings for daily notes
echo "⚙️ Setting up Foam configuration..."
mkdir -p "$ROOT/.vscode"
cat > "$ROOT/.vscode/settings.json" << EOF
{
  "foam.openDailyNote.directory": "memories/notes",
  "foam.completion.enabled": true,
  "foam.graph.enabled": true
}
EOF

# 7. Create Cursor MCP configuration
echo "🔌 Setting up Cursor MCP configuration..."
mkdir -p "$ROOT/.cursor"
cat > "$ROOT/.cursor/mcp.json" << EOF
{
  "mcpServers": {
    "basic-memory": {
      "command": "~/.local/bin/basic-memory.sh",
      "args": []
    }
  }
}
EOF

# 8. Create extractor prompt template
echo "📋 Creating knowledge extraction template..."
cat > "$MEM_DIR/extract-conversation.md" << EOF
---
type: template
category: extraction
project: $NAME
created: $(date +"%Y-%m-%d")
tags: [template, extraction, automation]
---

# Extract Conversation into memories/ using Basic Memory MCP

## Goal
Extract important information from a referenced conversation into the following folders using the available tools:

### Folders
- \`plans\` - action plans, roadmaps, to-do lists
- \`knowledge\` - stable reference facts, policies, domain docs
- \`decisions\` - architecture / product choices & rationale
- \`journal/lessons-learned\` - retrospectives, what-went-well, mistakes to avoid

### Tasks
1. **Scan the conversation** for the following:
   - **Plans** - any clearly stated tasks, next steps, or roadmaps
   - **Knowledge** - stable facts, policies, formulas, specs
   - **Decisions** - explicit choices made and their justification
   - **Lessons Learned** - mistakes, insights, or heuristics expressed

2. **For each extracted item:**
   - Choose a clear, concise title
   - Run \`write_note\` with the folder set to the target directory
   - Include proper frontmatter with type, category, and tags

3. **Link and relate:**
   - Use wiki links (\`[[Other Note]]\`) to connect to existing notes when relevant
   - Add cross-references between related content

4. **Verify and report:**
   - After all writes/edits, provide a summary list of the notes created or updated
   - Include any recommendations for follow-up actions

## Usage
Reference this template and provide the conversation to extract:

\`\`\`markdown
@extract-conversation.md

<conversation>
@path-to-conversation-file.md
</conversation>
\`\`\`
EOF

# 9. Create daily notes template
echo "📅 Creating daily notes template..."
cat > "$MEM_DIR/notes/$(date +"%Y-%m-%d").md" << EOF
---
type: daily-note
category: journal
project: $NAME
created: $(date +"%Y-%m-%d")
tags: [daily, notes, journal]
---

# Daily Notes - $(date +"%Y-%m-%d")

## Thoughts & Ideas
<!-- Capture random thoughts, ideas, and insights -->

## Issues & Bugs
<!-- Note any problems encountered -->

## Features & Improvements
<!-- Ideas for new features or improvements -->

## Decisions Made
<!-- Any decisions made today -->

## Lessons Learned
<!-- What went well, what didn't, what to avoid -->

## Tomorrow's Focus
<!-- What to work on next -->
EOF

echo "✅ Complete Memory System Setup Complete!"
echo ""
echo "🎯 Next Steps:"
echo "1. Install Foam extension in Cursor/VS Code for wikilinks and graph view"
echo "2. Use Option+D to create daily notes"
echo "3. Use 'mem export-conversation' to select and export Cursor conversations"
echo "4. Use 'mem export-latest' to export the latest Cursor conversation"
echo "5. Use 'mem save-conversation \"title\"' to save AI conversations"
echo "6. Use 'mem daily-to-issues' to process daily notes into issues"
echo "7. Use 'mem extract-knowledge' to extract insights from conversations"
echo ""
echo "📚 Available Commands:"
echo "- mem save-conversation \"title\""
echo "- mem create-adr \"title\""
echo "- mem extract-decisions"
echo "- mem daily-to-issues"
echo "- mem export-conversation (select and export)"
echo "- mem export-latest (export latest)"
echo "- mem check-github (check GitHub integration)"
echo "- mem search \"query\""
echo "- mem list [type]"
echo "- chi --select (direct cursor-history usage)"
echo "- chi (export latest conversation)"
echo ""
echo "🔗 GitHub Integration:"
echo "- If .github/ directory exists, issues will be created as GitHub Issues"
echo "- Otherwise, issues are stored locally in memories/issues/"
echo ""
echo "🎉 Your AI Memory System is ready!"
