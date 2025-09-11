---
title: Memory System Directory Structure
type: note
permalink: knowledge/memory-system-directory-structure
tags:
- memory-system,structure,organization
---

## Overview
The memory system uses a structured directory layout for organizing different types of knowledge.

## Directory Structure
- **conversations/** - AI conversation exports from Cursor
- **knowledge/** - Extracted insights and technical knowledge
- **decisions/** - Architecture Decision Records (ADRs)
- **plans/** - Project specifications and roadmaps
- **tasks/** - Actionable items and next steps
- **journal/** - Daily notes and lessons learned
- **snippets/** - Code snippets and reusable patterns
- **inbox/** - Temporary items to be processed

## Key Principles
- All files use YAML frontmatter for AI discoverability
- Conversations are exported with original date/context naming
- Knowledge is extracted from conversations into structured notes
- Decisions are documented as ADRs with context and rationale

## Related Conversations
- chezmoi-2025-09-11-11-13-applying-initial-workflow-for-memories