---
type: plan
category: strategy
project: chezmoi
created: 2025-09-11
status: draft
tags: [git, commits, organization, strategy]
---

# Git Commit Organization Strategy

## Context

Based on daily note from 2025-09-11, need to organize multiple changes into logical, textual commits instead of one massive commit.

## Current Git Status Analysis

### Modified Files (M)

- `home/.chezmoiscripts/darwin/run_ once_after-02-install-packages.sh.tmpl`
- `home/dot_gitignore`
- `home/private_dot_config/zsh/dot_zshenv.tmpl`
- `home/private_dot_config/zsh/dot_zshrc.tmpl`
- `home/private_dot_config/zsh/zsh-aliases.tmpl`

### New Files (??)

- `.cursor/` - Cursor IDE configuration
- `.foam/` - Foam note-taking setup
- `.vscode/` - VS Code configuration
- `home/.chezmoiscripts/darwin/run_ once_after-99-fix-executable-permissions.sh.tmpl`
- `home/.chezmoiscripts/darwin/run_once_install-basic-memory.sh.tmpl`
- `home/dot_cursor/` - Cursor dotfiles
- `home/dot_foam/` - Foam dotfiles
- `home/dot_local/` - Local bin scripts
- `home/dot_vscode/` - VS Code dotfiles
- `home/local_dot_local_bin_basic-memory.sh`
- `home/private_dot_config_cursor_config.json`
- `memories/` - Memory system

## Proposed Commit Groups

### 1. Memory System Setup

**Files**: All memory system related files

- `memories/` directory
- `home/dot_local/` directory
- `home/local_dot_local_bin_basic-memory.sh`
- `home/.chezmoiscripts/darwin/run_once_install-basic-memory.sh.tmpl`

**Commit Message**: "feat: Add basic-memory system integration"
**Description**: Set up complete memory system with scripts, templates, and directory structure

### 2. IDE Configuration

**Files**: Cursor, VS Code, and Foam configurations

- `.cursor/`, `home/dot_cursor/`
- `.vscode/`, `home/dot_vscode/`
- `.foam/`, `home/dot_foam/`
- `home/private_dot_config_cursor_config.json`

**Commit Message**: "feat: Add IDE configurations (Cursor, VS Code, Foam)"
**Description**: Configure development environment with proper IDE settings

### 3. Chezmoi Scripts Enhancement

**Files**: Updated chezmoi scripts

- `home/.chezmoiscripts/darwin/run_ once_after-02-install-packages.sh.tmpl`
- `home/.chezmoiscripts/darwin/run_ once_after-99-fix-executable-permissions.sh.tmpl`

**Commit Message**: "fix: Improve chezmoi script execution order and permissions"
**Description**: Fix executable permissions timing and enhance package installation

### 4. Shell Configuration Updates

**Files**: Zsh configuration updates

- `home/private_dot_config/zsh/dot_zshenv.tmpl`
- `home/private_dot_config/zsh/dot_zshrc.tmpl`
- `home/private_dot_config/zsh/zsh-aliases.tmpl`

**Commit Message**: "feat: Update zsh configuration for memory system"
**Description**: Enhance shell environment to work with memory system

### 5. Git Configuration

**Files**: Git ignore updates

- `home/dot_gitignore`

**Commit Message**: "chore: Update gitignore for new dotfiles"
**Description**: Add patterns for new IDE and memory system files

## Execution Order

1. Memory System Setup (foundation)
2. IDE Configuration (development environment)
3. Chezmoi Scripts Enhancement (infrastructure)
4. Shell Configuration Updates (user experience)
5. Git Configuration (cleanup)

## Benefits

- Each commit is focused and atomic
- Easy to review and understand
- Can be reverted individually if needed
- Clear progression of features
