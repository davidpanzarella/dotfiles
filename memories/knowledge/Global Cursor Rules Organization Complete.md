---
title: Global Cursor Rules Organization Complete
type: note
permalink: knowledge/global-cursor-rules-organization-complete
---

# Global Cursor Rules Organization Complete

## Problem Solved
You correctly identified that universal rules, agents, and basic-memory setup should be at the global level since they apply to ALL Cursor projects, not just specific ones.

## Global Organization Implemented

### **Global Rules** (`~/.cursor/rules/`) - Apply to ALL projects:
✅ `cursor-ai-rules.mdc` - Universal AI principles
✅ `memory-system.mdc` - Memory system setup (works everywhere)
✅ `prompt-improvement.mdc` - Prompt optimization (universal)
✅ `github-integration.mdc` - GitHub workflows (universal)
✅ `development-workflow.mdc` - Core development principles
✅ `system-context.mdc` - Environment setup with proper ARM64 chezmoi commands

### **Global Agents** (`~/.cursor/agents/`) - Available in ALL projects:
✅ `memory-assistant.md` - Memory management agent
✅ `conversation-importer.md` - Conversation import agent
✅ `daily-note-processor.md` - Daily note processing agent
✅ `README.md` - Agent documentation

### **Project-Specific Rules** (`.cursor/rules/`) - Only for THIS project:
✅ `dotfiles-project.mdc` - Chezmoi/dotfiles specific rules only

## Key Improvements

1. **DRY Principle**: No duplication across projects
2. **Consistency**: Same rules apply everywhere
3. **Maintenance**: Update once, applies everywhere
4. **Performance**: Cursor loads rules once globally
5. **Proper ARM64 Context**: All chezmoi commands use `PATH="/opt/homebrew/bin:$PATH" chezmoi apply`

## System Context Updates

**Updated system context rules to include:**
- **Chezmoi**: Always run `chezmoi apply` in interactive mode with ARM64 context
- **Memory system**: Use `bm` and `chi` tools directly (removed outdated `mem` commands)
- **Environment**: Proper ARM64 Homebrew paths

## init-project Script Updates

**Updated to copy from global locations:**
- Rules copied from `~/.cursor/rules/` instead of project-specific
- Agents copied from `~/.cursor/agents/` instead of project-specific
- Maintains smart overwrite logic for templates vs user content

## Result

🎯 **Perfect organization**: Universal rules and agents are global, project-specific rules stay local
🚀 **Ready for any project**: Every new project gets the complete system automatically
🔧 **Proper ARM64 context**: All commands use the correct environment setup