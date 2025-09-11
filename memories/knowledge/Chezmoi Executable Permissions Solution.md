---
title: Chezmoi Executable Permissions Solution
type: note
permalink: knowledge/chezmoi-executable-permissions-solution
tags:
  - chezmoi,permissions,dotfiles,memory-system
---

## Problem

Chezmoi was not preserving executable permissions for files in ~/.local/bin after applying changes.

## Solution

Use the 'executable\_' prefix for files in chezmoi source directory. Chezmoi automatically sets execute permissions for files with this prefix.

## Implementation

- Renamed mem to executable_mem
- Renamed setup-project-memory to executable_setup-project-memory
- Renamed basic-memory.sh to executable_basic-memory.sh
- Renamed setup-complete-memory-system.sh to executable_setup-complete-memory-system.sh

## Result

All memory system commands now have proper execute permissions after chezmoi apply.

## Update: Script Execution Order Fix

**Problem**: The executable permissions script was running before zsh and other configuration files were copied, causing permission issues.

**Solution**: Renamed the script from `run_after-99-fix-executable-permissions.sh.tmpl` to `run_ once_after-99-fix-executable-permissions.sh.tmpl` to ensure it runs after all other scripts and only once.

**Result**: Executable permissions are now applied after all dotfiles (including zsh configuration) are copied, ensuring proper timing.

## Verification Test Results

**Test Date**: September 11, 2025

**Test Command**: `chezmoi apply --interactive`

**Results**:

- ✅ Script runs with `[99 - Fix Executable Permissions]` label
- ✅ Verification confirms `~/.zshrc` and `~/.zshenv` exist before permissions are set
- ✅ All memory system files have proper executable permissions (`-rwxr-xr-x`)
- ✅ `mem` command works correctly and shows help output
- ✅ Tab completion system is properly configured

**Conclusion**: The script execution order is now correct - executable permissions are applied AFTER all dotfiles are copied.

## Related Conversations

- chezmoi-2025-09-11-11-13-applying-initial-workflow-for-memories
- chezmoi-2025-09-10-14-11-set-up-basic-memory-system-in-cursor
