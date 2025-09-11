#!/usr/bin/env bash
set -euo pipefail

# Initialize Memory System for Current Project
# Usage: init-memory [project-name]

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

echo "🚀 Initializing memory system for project: $NAME"
echo "📁 Project root: $ROOT"

# Create memories directory structure
if [[ ! -d "$MEM_DIR" ]]; then
  echo "📂 Creating memories directory structure..."
  mkdir -p "$MEM_DIR"/{knowledge/domain-notes,plans/specs,issues,decisions,tasks,conversations,snippets,inbox,journal}
  
  # Create seed files with proper frontmatter
  cat > "$MEM_DIR/_index.md" << EOF
# $NAME Memory System

## 🎯 Project Overview
<!-- Brief description of the project -->

## 📋 Quick Commands
- \`mem export-conversation\` - Export Cursor conversations
- \`mem process-daily\` - Process daily notes
- \`mem create-adr "title"\` - Create architecture decision record
- \`mem search "query"\` - Search memories

## 📁 Directory Structure
- \`knowledge/\` - Domain knowledge, patterns, facts
- \`plans/\` - Roadmaps, specifications, strategies
- \`issues/\` - Problems, bugs, questions
- \`decisions/\` - Architecture decision records (ADRs)
- \`tasks/\` - Action items, checklists
- \`journal/\` - Daily notes and lessons learned

## 🔄 Workflow
1. **Daily**: Use Option+D for daily notes
2. **Conversations**: Export important AI discussions
3. **Decisions**: Create ADRs for architectural choices
4. **Knowledge**: Document patterns and solutions
5. **Issues**: Track problems and solutions
EOF

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
EOF

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
EOF

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
EOF

  echo "✅ Created memories directory structure with seed files"
else
  echo "✅ Memories directory already exists"
fi

# Add project to basic-memory (silently)
echo "📦 Adding project to basic-memory..."
"$BREW_BIN/bm" project add "$NAME" "$MEM_DIR" >/dev/null 2>&1 || echo "ℹ️  Project already exists in basic-memory"

echo ""
echo "🎯 Memory system initialized for $NAME!"
echo "📁 Location: $MEM_DIR"
echo ""
echo "💡 Next steps:"
echo "   - Use Option+D in Cursor for daily notes"
echo "   - Use 'mem export-conversation' to save AI discussions"
echo "   - Use 'mem process-daily' to analyze daily notes"
