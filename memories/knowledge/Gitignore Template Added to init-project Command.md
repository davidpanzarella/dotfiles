---
title: Gitignore Template Added to init-project Command
type: note
permalink: knowledge/gitignore-template-added-to-init-project-command
---

## Gitignore Template Added to init-project Command

### Problem Solved
You correctly identified that we needed a `.gitignore` template for new projects since the old global gitignore files were removed during cleanup.

### What Was Added
- **Comprehensive `.gitignore` template** in `init-project.sh`
- **Always overwrites** `.gitignore` (template behavior)
- **Covers common patterns** for web development, Node.js, and our memory system

### Template Includes
- **Dependencies**: node_modules, package manager logs
- **Build outputs**: dist, build, .next, .nuxt, etc.
- **Environment files**: .env variants
- **IDE files**: .vscode, .idea, editor temp files
- **OS files**: .DS_Store, Thumbs.db, etc.
- **Logs and cache**: Various log and cache directories
- **Framework-specific**: Next.js, Nuxt.js, Gatsby, Storybook
- **Memory system**: All memories/ subdirectories

### Key Features
- **Project-specific section** for our memory system directories
- **Comprehensive coverage** of common development patterns
- **Always updated** when running `init-project` (template behavior)
- **Ready for any project type** (web, mobile, desktop, etc.)

### Testing Results
✅ **Successfully tested** with chezmoi project
✅ **Template created correctly** with all expected patterns
✅ **Memory system directories** properly ignored
✅ **No conflicts** with existing project structure

### Usage
Every new project initialized with `init-project` will now get a comprehensive `.gitignore` file that covers:
- Standard development patterns
- Framework-specific files
- Our memory system structure
- OS and IDE generated files

This ensures new projects start with proper git hygiene from day one.