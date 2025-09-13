---
title: "Project Name"
description: "Brief description of what this project is and what it accomplishes"
version: "1.0"
created: "2025-01-12"
status: "active"
tags: ["project-type", "technology", "purpose"]
---

# Project Name

## Project Overview

**What is this project?**
Brief description of the project's purpose and what it accomplishes.

**What problem does it solve?**
Clear statement of the problem or need this project addresses.

**Who is it for?**
Target audience or users of this project.

## Core Objectives

- **Primary Goal**: Main objective of the project
- **Secondary Goals**: Additional objectives
- **Success Criteria**: How we measure success

## Technical Context

**Technology Stack:**

- Primary technologies used
- Frameworks and libraries
- Development tools

**Architecture:**

- High-level system architecture
- Key components and their relationships
- Data flow and interactions

**Constraints:**

- Technical limitations
- Performance requirements
- Security considerations
- Compatibility requirements

## Project Structure

**Universal Directories:**

- `.cursor/` - Cursor AI configuration and project context
- `.foam/` - Foam workspace for daily notes and knowledge management
- `memories/` - AI knowledge base and project documentation
- `.github/` - GitHub workflows, templates, and repository management

**Project-Specific Directories:**

- `[project-specific]/` - Project-specific directories (src/, home/, content/, etc.)

**Important Files:**

- `README.md` - Human-readable project documentation
- `.cursor/project.md` - This file (AI agent context)
- `memories/plans/` - Project goals, constraints, and roadmaps

## Development Workflow

**AI-Assisted Development:**

- Use Cursor AI rules for consistent development practices
- Route learnings to appropriate `memories/` folders
- Use prompt improvement patterns for better AI interactions
- Apply memory system for knowledge management

**Daily Workflow:**

- Use Foam for daily notes and knowledge capture
- Update project context as needed
- Track decisions and learnings in memory system
- Maintain conversation history for context

## Memory System Integration

**Content Routing:**

- **Facts & learnings** → `memories/knowledge/`
- **Goals & constraints** → `memories/plans/`
- **Problems & questions** → `memories/issues/`
- **Decisions** → `memories/decisions/`
- **Tasks** → `memories/tasks/`
- **Conversations** → `memories/conversations/`
- **Daily notes** → `memories/notes/`

**AI Commands:**

- `mem save-conversation "title"` - Save AI conversations
- `mem create-adr "decision"` - Create decision records
- `mem process-daily` - Process daily notes
- `mem extract-knowledge` - Extract insights

## Project Status

**Current Phase:** [Planning/Development/Testing/Production]
**Next Steps:** Key upcoming tasks or milestones
**Blockers:** Any current obstacles or dependencies
**Timeline:** Key dates and milestones

---

_This file provides AI agents with essential project context to work effectively within the established cursor rules and memory system framework._
