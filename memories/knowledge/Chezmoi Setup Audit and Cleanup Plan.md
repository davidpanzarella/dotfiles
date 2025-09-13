---
title: Chezmoi Setup Audit and Cleanup Plan
type: note
permalink: knowledge/chezmoi-setup-audit-and-cleanup-plan
---

# Chezmoi Setup Audit and Cleanup Plan

## Current Status Analysis

### **✅ ACTIVE COMPONENTS** (Keep and maintain)

#### **Core System Files:**
- ✅ `dot_cursor/` - Cursor rules, agents, settings (ACTIVE)
- ✅ `dot_vscode/` - VS Code tasks (ACTIVE)
- ✅ `dot_foam/` - Daily note templates (ACTIVE)
- ✅ `private_dot_config/` - Git, zsh, starship configs (ACTIVE)
- ✅ `dot_zshenv.tmpl` - Shell environment (ACTIVE)
- ✅ `dot_nanorc.tmpl` - Nano editor config (ACTIVE)

#### **Active Executables:**
- ✅ `executable_init-project.sh` - Main project initialization (ACTIVE)
- ✅ `executable_sync-all-settings.sh` - Settings sync system (ACTIVE)
- ✅ `executable_update-cursor-settings.sh` - Cursor settings update (ACTIVE)

### **❌ DEPRECATED COMPONENTS** (Remove)

#### **Hammerspoon (Not in use):**
- ❌ `dot_hammerspoon/` - Hammerspoon not running, not needed
- ❌ `MiroWindowsManager.spoon/` - Window management not used

#### **Deprecated Memory System Files:**
- ❌ `executable_basic-memory.sh` - Replaced by direct `bm` usage
- ❌ `executable_conversation-template.md` - Documentation, not executable
- ❌ `executable_cursor-agent-rules.md` - Documentation, not executable
- ❌ `executable_project-structure-analysis.md` - Documentation, not executable
- ❌ `executable_migrate-past-conversations.sh` - One-time migration, no longer needed
- ❌ `executable_init-project-with-best-practices.sh` - Superseded by main init-project
- ❌ `executable_sync-cursor-settings.sh` - Empty file, superseded by sync-all-settings

#### **Redundant Files:**
- ❌ `local_dot_local_bin_basic-memory.sh` - Duplicate of executable_basic-memory.sh
- ❌ `home/` - Empty directory
- ❌ `dot_duti` - File association tool, not actively used
- ❌ `dot_gitignore` - Global gitignore, may not be needed
- ❌ `dot_gitignore_global` - Duplicate gitignore

### **🔍 QUESTIONABLE COMPONENTS** (Review)

#### **SSH Configuration:**
- ❓ `private_dot_ssh/id_rsa.pub.tmpl` - SSH key template, may not be needed

#### **iTerm2 Integration:**
- ❓ `private_dot_config/iterm2/` - iTerm2 configs, check if using iTerm2

## Cleanup Actions Required

### **1. Remove Deprecated Executables:**
```bash
rm home/dot_local/bin/executable_basic-memory.sh
rm home/dot_local/bin/executable_conversation-template.md
rm home/dot_local/bin/executable_cursor-agent-rules.md
rm home/dot_local/bin/executable_project-structure-analysis.md
rm home/dot_local/bin/executable_migrate-past-conversations.sh
rm home/dot_local/bin/executable_init-project-with-best-practices.sh
rm home/dot_local/bin/executable_sync-cursor-settings.sh
rm local_dot_local_bin_basic-memory.sh
```

### **2. Remove Hammerspoon:**
```bash
rm -rf home/dot_hammerspoon/
```

### **3. Remove Redundant Files:**
```bash
rm home/dot_duti
rm home/dot_gitignore
rm home/dot_gitignore_global
rmdir home/home/
```

### **4. Review SSH and iTerm2:**
- Check if SSH key template is needed
- Verify iTerm2 usage

## Result After Cleanup

### **Streamlined Structure:**
```
home/
├── dot_cursor/           # Cursor rules, agents, settings
├── dot_vscode/          # VS Code tasks
├── dot_foam/            # Daily note templates
├── dot_local/bin/       # Active executables only
├── private_dot_config/  # Git, zsh, starship configs
├── dot_zshenv.tmpl      # Shell environment
└── dot_nanorc.tmpl      # Nano config
```

### **Active Executables (3 total):**
- `executable_init-project.sh` - Project initialization
- `executable_sync-all-settings.sh` - Settings sync
- `executable_update-cursor-settings.sh` - Cursor settings

## Benefits of Cleanup

1. **Reduced complexity** - Fewer files to maintain
2. **Clearer purpose** - Only active components remain
3. **Easier maintenance** - Less confusion about what's used
4. **Better performance** - Fewer files to process
5. **Cleaner structure** - Focused on essential components

## Next Steps

1. **Execute cleanup** - Remove deprecated components
2. **Test system** - Ensure everything still works
3. **Update documentation** - Reflect new streamlined structure
4. **Apply chezmoi** - Update system with cleaned configuration