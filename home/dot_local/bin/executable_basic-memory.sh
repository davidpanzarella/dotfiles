#!/usr/bin/env bash
set -euo pipefail

# Ensure we're using the correct Homebrew context
# Prioritize ARM64 Homebrew on Apple Silicon
if [[ "$(uname -m)" == "arm64" && -f "/opt/homebrew/bin/brew" ]]; then
  # Apple Silicon - use ARM64 Homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"
  BREW_BIN="/opt/homebrew/bin"
elif [[ -f "/usr/local/bin/brew" ]]; then
  # Intel Mac or fallback - use x86_64 Homebrew
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

# Create memories directory structure on first run
if [[ ! -d "$MEM_DIR" ]]; then
  echo "Creating memories directory structure for project: $NAME"
  mkdir -p "$MEM_DIR"/{knowledge/domain-notes,plans/specs,issues,decisions,tasks,journal/conversations,snippets,inbox}
  
  # Create seed files
  cat > "$MEM_DIR/_index.md" << 'EOF'
# Memory System

## Routing Rules
- **facts** → `knowledge/`
- **plans/specs** → `plans/`
- **problems/risks/questions** → `issues/`
- **decisions** → `decisions/` (ADRs)
- **tasks/checklists** → `tasks/`
- **daily summaries** → `journal/`
- **unsure** → `inbox/` with `route-to:` hint

## Quick Commands
- `mem write "content"` - Write to appropriate folder
- `mem search "query"` - Search across all content
- `mem list issues` - List all issues
- `mem list tasks` - List all tasks
- `mem save-conversation "title"` - Save current AI conversation
- `mem extract-decisions` - Extract decisions from recent conversations
EOF

  cat > "$MEM_DIR/knowledge/glossary.md" << 'EOF'
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

  cat > "$MEM_DIR/plans/intent.md" << 'EOF'
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

  cat > "$MEM_DIR/plans/roadmap.md" << 'EOF'
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

  cat > "$MEM_DIR/tasks/next.md" << 'EOF'
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

  echo "Created mem directory structure with seed files"
fi

# Ensure a project exists in basic-memory
"$BREW_BIN/bm" project add "$NAME" "$MEM_DIR" >/dev/null 2>&1 || true

# Launch MCP server scoped to this repo
exec "$BREW_BIN/basic-memory" --project "$NAME" mcp
