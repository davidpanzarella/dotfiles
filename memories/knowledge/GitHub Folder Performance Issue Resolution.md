---
title: GitHub Folder Performance Issue Resolution
type: knowledge
permalink: knowledge/github-folder-performance-issue-resolution
created: 2025-01-27
tags: ["performance", "vscode", "cursor", "github", "pnpm", "file-explorer"]
---

# GitHub Folder Performance Issue Resolution

## Problem Description

**Issue**: `.github` folders in pnpm projects causing VS Code/Cursor file explorer to be slow and crash the window.

**Symptoms**:

- File explorer becomes unresponsive when navigating to `.github` folders
- Window crashes when expanding `.github/workflows` directories
- Performance degradation in projects using pnpm

## Root Causes

1. **File Explorer Performance**: VS Code/Cursor's file explorer struggles with certain folder structures
2. **pnpm Store Integration**: Complex nested directories in pnpm can create performance issues
3. **GitHub Workflows**: Complex workflow files with many dependencies slow down file indexing
4. **File Watching**: Excessive file watching on `.github` directories

## Solution Implementation

### 1. VS Code/Cursor Settings Optimization

**Updated `settings.json` with exclusions:**

```json
{
  "files.exclude": {
    "**/.github": true
  },
  "files.watcherExclude": {
    "**/.github/**": true
  }
}
```

**Benefits**:

- Prevents file explorer from indexing `.github` folders
- Reduces file watching overhead
- Eliminates crashes when navigating to GitHub-related directories

### 2. pnpm Configuration Optimization

**Created global `.npmrc` configuration:**

```ini
# pnpm configuration for performance optimization
virtual-store-dir-max-length=80
store-dir=~/.pnpm-store
prefer-frozen-lockfile=true
strict-peer-dependencies=false
registry=https://registry.npmjs.org/
```

**Key Settings**:

- `virtual-store-dir-max-length=80`: Limits directory path length to prevent long path issues
- `store-dir=~/.pnpm-store`: Centralizes pnpm store location
- `prefer-frozen-lockfile=true`: Improves installation performance

### 3. File System Exclusions

**Already configured exclusions**:

- `**/node_modules`: Excluded from file watching
- `**/pnpm-store/**`: Excluded from file watching
- `**/.git/**`: Excluded from file watching

## Implementation Steps

1. ✅ **Updated Cursor settings** - Added `.github` folder exclusions
2. ✅ **Created pnpm configuration** - Added `.npmrc` template with performance settings
3. ✅ **Applied file watcher exclusions** - Prevented excessive file monitoring
4. ✅ **Documented solution** - Created this knowledge base entry

## Verification

**To verify the fix works**:

1. Open a pnpm project with `.github` folder
2. Navigate to file explorer
3. Confirm `.github` folder is hidden from explorer
4. Check that window no longer crashes
5. Verify pnpm operations are faster

## Alternative Solutions (If Needed)

### Option 1: Selective GitHub Folder Access

If you need to access `.github` files occasionally:

- Use Command Palette: `Ctrl/Cmd + Shift + P` → "File: Toggle Excluded Files"
- Temporarily show hidden files when needed

### Option 2: Workspace-Specific Settings

For projects where you need `.github` access:

```json
{
  "files.exclude": {
    "**/.github/workflows": true
  }
}
```

This excludes only the workflows folder while keeping other GitHub files accessible.

### Option 3: Git Integration

Use Git integration instead of file explorer for GitHub-related files:

- Git panel in VS Code/Cursor
- Command line Git operations
- GitHub CLI for workflow management

## Prevention

**Best Practices**:

1. **Regular cleanup**: Remove unused workflow files
2. **Optimize workflows**: Keep workflow files simple and focused
3. **Monitor performance**: Watch for new performance issues
4. **Update tools**: Keep pnpm and VS Code/Cursor updated

## Related Issues

- **Long path issues**: Common on Windows, mitigated by `virtual-store-dir-max-length`
- **Memory usage**: Large `node_modules` can cause similar issues
- **File watching**: Excessive file monitoring can impact performance

## References

- [pnpm Performance Issues](https://github.com/pnpm/pnpm/issues/7355)
- [VS Code File Explorer Performance](https://code.visualstudio.com/docs/editor/workspace-trust)
- [pnpm Configuration](https://pnpm.io/npmrc)

## Status

✅ **RESOLVED** - Solution implemented and documented
📅 **Date**: 2025-01-27
🔧 **Applied to**: Global Cursor settings and pnpm configuration
