---
title: Bidirectional Settings Sync System
type: note
permalink: knowledge/bidirectional-settings-sync-system
---

# Bidirectional Settings Sync System

## Problem Solved

You correctly identified the need for **bidirectional sync** between chezmoi templates and global settings. This ensures that:
1. **Changes in Cursor/VS Code** can be pulled back to chezmoi templates
2. **Changes in chezmoi templates** can be pushed to global settings
3. **Consistent source of truth** maintained in chezmoi project

## Complete Sync System

### **Scripts Created:**

1. **`sync-cursor-settings.sh`** - Cursor-specific sync
2. **`sync-all-settings.sh`** - Complete system sync (Cursor + VS Code)

### **Commands Available:**

```bash
# Initialize templates from current global settings
sync-all-settings init

# Push chezmoi templates to global settings
sync-all-settings push

# Pull current global settings to chezmoi templates  
sync-all-settings pull

# Show comprehensive status
sync-all-settings status
```

## File Structure

### **Chezmoi Templates** (Source of Truth):
- `home/dot_cursor/settings/cursor-global-settings.json` - Cursor settings template
- `home/dot_cursor/settings/vscode-global-settings.json` - VS Code settings template
- `home/dot_cursor/settings/backups/` - Automatic backups

### **Global Settings** (Applied everywhere):
- `~/Library/Application Support/Cursor/User/settings.json` - Cursor global
- `~/Library/Application Support/Code/User/settings.json` - VS Code global

## Workflow

### **When You Make Changes in Cursor/VS Code:**
1. **Pull changes**: `sync-all-settings pull`
2. **Review templates**: Check what was extracted
3. **Edit if needed**: Modify templates in chezmoi
4. **Push updates**: `sync-all-settings push`

### **When You Make Changes in Chezmoi Templates:**
1. **Edit templates**: Modify settings in chezmoi
2. **Push changes**: `sync-all-settings push`
3. **Restart editors**: Apply changes

### **Regular Maintenance:**
1. **Check status**: `sync-all-settings status`
2. **Pull latest**: `sync-all-settings pull` (if you made changes in editors)
3. **Push updates**: `sync-all-settings push` (if you edited templates)

## Features

### **Automatic Backups:**
- ✅ **Before every push/pull** - Automatic backup creation
- ✅ **Timestamped backups** - Easy to restore if needed
- ✅ **Separate directories** - Organized backup storage

### **Smart Merging:**
- ✅ **jq-based merging** - Preserves existing settings
- ✅ **Fallback support** - Works without jq
- ✅ **Non-destructive** - Never overwrites without backup

### **Comprehensive Status:**
- ✅ **File sizes and dates** - See what's changed
- ✅ **Settings detection** - Know what's configured
- ✅ **Backup tracking** - See backup history

## Integration with init-project

The `init-project` script now automatically:
1. **Updates global rules** from chezmoi source
2. **Updates global agents** from chezmoi source  
3. **Updates global Cursor settings** from chezmoi source
4. **Ensures consistency** across all projects

## Result

🎯 **Perfect bidirectional sync**: Changes flow both ways between chezmoi and global settings
🚀 **Consistent source of truth**: Chezmoi project maintains all settings templates
🔧 **Easy maintenance**: Simple commands to sync in either direction
📁 **Automatic backups**: Never lose settings during sync operations
🔄 **Integrated workflow**: Works seamlessly with init-project system

The system now provides complete bidirectional sync for all settings!