---
title: Memory System Templates and Structure Reference
type: note
permalink: knowledge/memory-system-templates-and-structure-reference
tags:
- memory-system,templates,structure,reference
---

## Memory System Directory Structure

### Active Directories
- **conversations/** - AI conversation exports from Cursor
- **knowledge/** - Extracted insights and technical knowledge  
- **decisions/** - Architecture Decision Records (ADRs)
- **plans/** - Project specifications and roadmaps
- **tasks/** - Actionable items and next steps
- **journal/** - Daily notes and lessons learned
- **snippets/** - Code snippets and reusable patterns
- **inbox/** - Temporary items to be processed

### Template Directory
- **templates/** - Reference templates for creating new content

## Available Templates

### Knowledge Templates
- **glossary-template.md** - For creating project glossaries and term definitions

### Planning Templates  
- **intent-template.md** - For documenting project purpose and goals
- **roadmap-template.md** - For project milestones and planning

### Task Templates
- **next-tasks-template.md** - For organizing and prioritizing tasks

## Usage
1. Copy templates from  directory
2. Rename to appropriate name (remove '-template' suffix)
3. Fill in the content sections
4. Add to appropriate directory in memories/

## Key Principles
- All files use YAML frontmatter for AI discoverability
- Templates provide structure but should be customized for each use case
- Keep templates separate from active knowledge to avoid confusion