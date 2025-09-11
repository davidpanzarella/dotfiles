---
type: note
category: adr
project: chezmoi
created: 2025-09-11
status: proposed
tags:
- chezmoi,permissions,executable,decision
adr-number: 20250911-134114
permalink: decisions/adr-20250911-134114-use-executable-prefix-for-chezmoi-file-permissions
title: 'ADR-20250911-134114: Use executable_ prefix for chezmoi file permissions'
---

## Status
Accepted

## Context
Chezmoi was not preserving executable permissions for files in ~/.local/bin after applying changes. This caused permission denied errors for custom commands like 'mem', 'setup-project-memory', and 'basic-memory'.

## Decision
Use the 'executable_' prefix for files in chezmoi source directory. Chezmoi automatically sets execute permissions for files with this prefix.

## Rationale
- Chezmoi's built-in mechanism for handling executable files
- No need for custom permission-fixing scripts
- Consistent with chezmoi best practices
- Eliminates permission issues after chezmoi apply

## Implementation
- Renamed mem to executable_mem
- Renamed setup-project-memory to executable_setup-project-memory  
- Renamed basic-memory.sh to executable_basic-memory.sh
- Renamed setup-complete-memory-system.sh to executable_setup-complete-memory-system.sh

## Consequences
- All memory system commands now have proper execute permissions
- No need for post-apply permission fixing scripts
- Cleaner chezmoi configuration