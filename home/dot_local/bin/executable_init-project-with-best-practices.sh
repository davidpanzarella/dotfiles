#!/usr/bin/env bash
set -euo pipefail

# Initialize Project with AI-Assisted Development Best Practices
# Based on Addy Osmani's "Beyond Vibe Coding" principles

PROJECT_ROOT="$(pwd)"
PROJECT_NAME="$(basename "$PROJECT_ROOT")"

echo "🚀 Initializing project: $PROJECT_NAME"
echo "📍 Location: $PROJECT_ROOT"
echo ""

# Create project structure
echo "📁 Creating project structure..."

# Core project files
cat > SPEC.md << 'EOF'
# Project Specification

## Problem Statement
<!-- What problem does this project solve? -->

## Goals & Objectives
<!-- What are the main goals? -->

## Success Criteria
<!-- How do we measure success? -->

## Technical Constraints
<!-- Any technical limitations or requirements? -->

## User Journey
<!-- How will users interact with this system? -->

## Architecture Overview
<!-- High-level system design -->

## Implementation Plan
<!-- Phased approach to building this -->

## Risk Assessment
<!-- Potential challenges and mitigation strategies -->
EOF

# Cursor rules
cp ~/.local/share/chezmoi/home/dot_cursor/cursor-rules.md .cursorrules

# Documentation structure (optional)
mkdir -p docs
cat > docs/README.md << 'EOF'
# Documentation

This directory contains static documentation for the project.

## Structure
- `architecture.md` - System architecture and design decisions
- `contributing.md` - Development workflow and contribution guidelines
- `api.md` - API documentation (if applicable)
- `deployment.md` - Deployment guide (if applicable)
EOF

cat > docs/architecture.md << 'EOF'
---
type: documentation
category: architecture
project: $PROJECT_NAME
created: $(date +"%Y-%m-%d")
tags: [architecture, design, system]
---

# System Architecture

## Overview
<!-- High-level system architecture -->

## Components
<!-- Key system components and their responsibilities -->

## Data Flow
<!-- How data moves through the system -->

## Technology Stack
<!-- Technologies and frameworks used -->

## Design Decisions
<!-- Key architectural decisions and rationale -->
EOF

cat > docs/contributing.md << 'EOF'
---
type: documentation
category: contributing
project: $PROJECT_NAME
created: $(date +"%Y-%m-%d")
tags: [contributing, workflow, development]
---

# Contributing Guidelines

## Development Workflow
<!-- How to contribute to this project -->

## Code Standards
<!-- Coding standards and conventions -->

## AI-Assisted Development
<!-- Guidelines for using AI tools in development -->
EOF

# Initialize memory system
echo "🧠 Setting up memory system..."
~/.local/bin/init-memory.sh

# Create VS Code/Cursor settings
mkdir -p .vscode
cat > .vscode/settings.json << 'EOF'
{
  "foam.dailyNote.filenameFormat": "YYYY-MM-DD",
  "foam.dailyNote.directory": "memories/notes",
  "foam.dailyNote.template": ".foam/templates/daily-note.md",
  "files.associations": {
    "*.md": "markdown"
  },
  "markdown.preview.breaks": true,
  "markdown.preview.linkify": true
}
EOF

# Create Foam templates directory
mkdir -p .foam/templates
cp ~/.local/share/chezmoi/home/dot_foam/templates/daily-note.md .foam/templates/

# Create Cursor MCP configuration
mkdir -p .cursor
cat > .cursor/mcp.json << 'EOF'
{
  "mcpServers": {
    "basic-memory": {
      "command": "~/.local/bin/basic-memory.sh",
      "args": []
    }
  }
}
EOF

# Create basic source structure
mkdir -p src tests

# Create initial README
cat > README.md << 'EOF'
# $PROJECT_NAME

<!-- Brief project description -->

## Quick Start

1. **Read the SPEC**: Start with [SPEC.md](./SPEC.md) to understand the project
2. **Use AI assistance**: Check [.cursorrules](./.cursorrules) for AI development guidelines
3. **Manage knowledge**: Use the memory system in `memories/` folder

## Project Structure

```
$PROJECT_NAME/
├── .cursorrules              # Cursor AI development rules
├── SPEC.md                   # Project specification
├── docs/                     # Static documentation (optional)
├── memories/                 # AI knowledge base
├── src/                      # Source code
└── .vscode/                  # Editor settings
```

## AI-Assisted Development

This project follows [Beyond Vibe Coding](https://beyond.addy.ie/) principles:

- **Plan first, code second** - Always start with SPEC.md
- **Context is everything** - Provide relevant context to AI
- **Test ruthlessly** - Test after every change
- **Use memory system** - Capture learnings and decisions

## Memory System

Use the `mem` command for knowledge management:

```bash
mem save-conversation "title"    # Save AI conversations
mem create-adr "decision"        # Create architecture decisions
mem process-daily                # Analyze daily notes
mem export-conversation          # Export Cursor conversations
```

## Development Workflow

1. **Plan**: Update SPEC.md with requirements
2. **Code**: Use Cursor with AI assistance
3. **Test**: Verify functionality after changes
4. **Document**: Update memories with learnings
5. **Review**: Use memory system for context

## Contributing

See [docs/contributing.md](./docs/contributing.md) for detailed guidelines.

## License

<!-- Add license information -->
EOF

# Create initial test structure
cat > tests/README.md << 'EOF'
# Tests

## Test Structure
- `unit/` - Unit tests for individual components
- `integration/` - Integration tests for component interactions
- `e2e/` - End-to-end tests for user workflows

## Running Tests
<!-- Add test running instructions -->

## Test Guidelines
- Write tests for every AI-generated function
- Include security and performance tests
- Maintain high test coverage
- Test error scenarios and edge cases
EOF

mkdir -p tests/{unit,integration,e2e}

# Create .gitignore if it doesn't exist
if [[ ! -f .gitignore ]]; then
  cat > .gitignore << 'EOF'
# Dependencies
node_modules/
__pycache__/
*.pyc

# Build outputs
dist/
build/
*.o
*.so

# Environment files
.env
.env.local
.env.*.local

# IDE files
.vscode/settings.json
.idea/
*.swp
*.swo

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp
EOF
fi

echo ""
echo "✅ Project initialized successfully!"
echo ""
echo "📋 Next steps:"
echo "   1. Review and update SPEC.md with your project details"
echo "   2. Set up your development environment (see docs/deployment.md)"
echo "   3. Start coding with AI assistance using .cursorrules"
echo "   4. Use 'mem' commands to manage knowledge and decisions"
echo ""
echo "🎯 Key files created:"
echo "   - SPEC.md (project specification)"
echo "   - .cursorrules (AI development guidelines)"
echo "   - docs/ (static documentation)"
echo "   - memories/ (AI knowledge base)"
echo "   - .vscode/settings.json (Foam configuration)"
echo "   - .cursor/mcp.json (Cursor MCP configuration)"
echo ""
echo "💡 Pro tip: Use Option+D in Cursor for daily notes!"
echo "🚀 Happy coding with AI assistance!"
