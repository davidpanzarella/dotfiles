---
title: Chezmoi Safety Rule - Core Principle
type: note
permalink: knowledge/chezmoi-safety-rule-core-principle
---

# Chezmoi Safety Rule - Core Principle

## Critical Safety Rule

**ALWAYS run `chezmoi apply` interactively** to review changes before applying them to your system.

## Why This Matters

- **Safety**: Interactive mode shows you exactly what will change before applying
- **Control**: You can review and approve each change individually
- **Prevention**: Avoids accidentally overwriting important system files
- **Transparency**: You see the full impact of changes before they happen

## Proper Usage

### ✅ Correct - Interactive Mode (Default)
```bash
PATH="/opt/homebrew/bin:$PATH" chezmoi apply
```
- Shows changes and asks for confirmation
- Allows you to review each change
- Safe for system-wide changes

### ✅ Correct - Targeted Changes Only
```bash
chezmoi apply --target ~/.zshrc
chezmoi apply --target ~/.config/git/config
```
- Applies only specific files
- Safe when you know exactly what changed

### ❌ Never Do This
```bash
chezmoi apply --force
chezmoi apply --no-interactive
```
- Applies all changes without review
- Dangerous for system files
- Can overwrite important configurations

## Implementation

This rule is now embedded in:
- **System Context Rules** - Core environment setup
- **Development Workflow** - Core principle #4
- **Memory System Rules** - Daily workflow safety

## ARM64 Context

Always use the proper ARM64 context:
```bash
PATH="/opt/homebrew/bin:$PATH" chezmoi apply
```

This ensures chezmoi uses the correct Homebrew installation on Apple Silicon.