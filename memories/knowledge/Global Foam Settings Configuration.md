---
title: Global Foam Settings Configuration
type: note
permalink: knowledge/global-foam-settings-configuration
---

# Global Foam Settings Configuration

## Problem Solved

You correctly identified that Foam settings should be **global** rather than project-specific, just like our Cursor rules. This ensures consistent daily note functionality across all projects.

## Implementation

### **Global Foam Settings** (Applied everywhere)
**Location**: `~/Library/Application Support/Cursor/User/settings.json`

```json
{
  "foam.dailyNote.filenameFormat": "YYYY-MM-DD",
  "foam.dailyNote.directory": "memories/notes",
  "foam.dailyNote.template": ".foam/templates/daily-note.md",
  "foam.openDailyNote.directory": "memories/notes"
}
```

### **Project-Specific VS Code** (Minimal)
**Location**: `.vscode/settings.json` in each project

```json
{
  "// Note": "Foam settings are now configured globally in Cursor settings"
}
```

## Benefits

### **Consistency:**
- ✅ **Same daily note format** across all projects
- ✅ **Same memory directory structure** everywhere
- ✅ **Same template** for daily notes
- ✅ **No duplication** of Foam settings

### **Maintainability:**
- ✅ **Update once** - Changes apply to all projects
- ✅ **No project-specific overrides** - Consistent behavior
- ✅ **Cleaner projects** - No redundant Foam settings

### **User Experience:**
- ✅ **Automatic daily notes** - Works in any project
- ✅ **Consistent shortcuts** - Same commands everywhere
- ✅ **Universal memory system** - Same structure everywhere

## Configuration Hierarchy

### **Global Level** (Applied everywhere)
- **Cursor Rules**: `~/.cursor/rules/` - AI behavior
- **Cursor Agents**: `~/.cursor/agents/` - AI agents
- **Foam Settings**: `~/Library/Application Support/Cursor/User/settings.json` - Daily notes

### **Project Level** (Project-specific)
- **MCP Config**: `.cursor/mcp.json` - Project-specific basic-memory
- **Tasks**: `.vscode/tasks.json` - Project-specific tasks
- **Project Rules**: `.cursor/rules/` - Project-specific overrides

## Result

🎯 **Perfect global configuration**: Foam settings applied everywhere automatically
🚀 **Consistent experience**: Same daily note functionality in all projects
🔧 **Maintainable**: Update once, applies everywhere
📁 **Clean projects**: No redundant Foam settings in projects

The Foam configuration is now properly global and consistent with our system architecture!