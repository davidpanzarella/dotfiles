---
title: Centralized Source of Truth - Chezmoi Project
type: note
permalink: knowledge/centralized-source-of-truth-chezmoi-project
---

# Centralized Source of Truth - Chezmoi Project

## Problem Solved

You correctly identified that agents (and rules) should be maintained in the chezmoi project as the **source of truth** and then applied globally, ensuring updates propagate to all projects.

## New Architecture

### **Source of Truth** (Chezmoi Project)
- **Rules**: `home/dot_cursor/rules/` - Universal rules maintained here
- **Agents**: `home/dot_cursor/agents/` - Custom agents maintained here
- **Updates**: Made in chezmoi project, propagated globally

### **Global Application** (Applied everywhere)
- **Rules**: `~/.cursor/rules/` - Updated from chezmoi source
- **Agents**: `~/.cursor/agents/` - Updated from chezmoi source
- **Projects**: Get latest versions when initialized

## Workflow

### **When Updating Rules/Agents:**
1. **Edit in chezmoi project** (`home/dot_cursor/rules/` or `home/dot_cursor/agents/`)
2. **Run `init-project`** on any project (including chezmoi itself)
3. **Global locations updated** automatically from chezmoi source
4. **All projects get latest versions** when initialized

### **init-project Process:**
1. **Update global rules** from chezmoi source
2. **Update global agents** from chezmoi source  
3. **Copy agents to project** from chezmoi source
4. **Apply global rules** (no copying needed)

## Benefits

### **Centralized Management:**
- ✅ **Single source of truth** - All rules/agents in chezmoi project
- ✅ **Version control** - Changes tracked in chezmoi git history
- ✅ **Consistency** - Same versions applied everywhere
- ✅ **Maintainability** - Update once, applies everywhere

### **Future-Proof:**
- ✅ **Ready for Cursor's native agent format** (MDC/JSON)
- ✅ **Easy migration** when Cursor adds native support
- ✅ **Global agent availability** in all Cursor instances
- ✅ **Reference documentation** always available

## Implementation

**New functions in init-project:**
- `update_global_rules()` - Updates global rules from chezmoi source
- `update_global_agents()` - Updates global agents from chezmoi source

**Process flow:**
1. Update global rules from chezmoi source
2. Update global agents from chezmoi source
3. Copy agents to project from chezmoi source
4. Apply global rules (universal application)

## Result

🎯 **Perfect centralized system**: Chezmoi project is the source of truth
🚀 **Automatic propagation**: Updates flow to all projects
🔧 **Future-ready**: Ready for Cursor's native agent support
📁 **Maintainable**: Single place to manage all rules and agents

The system now has a proper centralized source of truth with automatic global propagation!