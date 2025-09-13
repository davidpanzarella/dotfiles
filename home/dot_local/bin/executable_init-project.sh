#!/usr/bin/env bash
set -euo pipefail

# init-project - Initialize a new AI-optimized project
# Usage: init-project [project-name] [--import-history]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: init-project [project-name] [--import-history] [--projects project1,project2]"
    echo ""
    echo "Initialize a new AI-optimized project with:"
    echo "  - Basic-memory knowledge base"
    echo "  - Cursor AI rules and configuration"
    echo "  - Foam knowledge workspace"
    echo "  - GitHub integration"
    echo ""
    echo "Options:"
    echo "  --import-history    Import conversation history from cursor-history"
    echo "  --projects          Comma-separated list of projects to import from"
    echo ""
    echo "Examples:"
    echo "  init-project                    # Initialize current directory"
    echo "  init-project my-new-app         # Create new project directory"
    echo "  init-project my-app --import-history  # Create project and import history"
    echo "  init-project my-app --import-history --projects chezmoi,ehb  # Import from multiple projects"
}

# Function to check dependencies
check_dependencies() {
    print_status "Checking dependencies..."
    
    local missing_deps=()
    
    if ! command -v bm &> /dev/null; then
        missing_deps+=("basic-memory")
    fi
    
    if ! command -v chi &> /dev/null; then
        missing_deps+=("cursor-history")
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        echo ""
        echo "Install missing dependencies:"
        for dep in "${missing_deps[@]}"; do
            case $dep in
                "basic-memory")
                    echo "  brew install basic-memory"
                    ;;
                "cursor-history")
                    echo "  pnpm install -g @johnlindquist/cursor-history@latest"
                    ;;
            esac
        done
        exit 1
    fi
    
    print_success "All dependencies found"
}

# Function to get project name and path
get_project_info() {
    local project_name="$1"
    local project_path
    
    if [[ -z "$project_name" ]]; then
        # Use current directory
        project_path="$(pwd)"
        project_name="$(basename "$project_path")"
        print_status "Initializing project '$project_name' in current directory" >&2
    else
        # Create new directory
        project_path="$(pwd)/$project_name"
        if [[ -d "$project_path" ]]; then
            print_error "Directory '$project_name' already exists" >&2
            exit 1
        fi
        print_status "Creating new project '$project_name'" >&2
    fi
    
    echo "$project_name|$project_path"
}

# Function to create directory structure
create_directory_structure() {
    local project_path="$1"
    
    print_status "Creating directory structure..."
    
    # Create main directories
    mkdir -p "$project_path"/{.cursor/rules,.foam/templates,.github/{workflows,ISSUE_TEMPLATE}}
    mkdir -p "$project_path"/memories/{knowledge,plans,decisions,tasks,conversations,notes,lessons-learned}
    
    print_success "Directory structure created"
}

# Function to copy global rules from chezmoi
copy_global_rules() {
    local project_path="$1"
    local global_rules="/Users/davidpanzarella/.cursor/rules"
    
    print_status "Updating global rules from ~/.cursor/rules/..."
    
    # Note: Universal rules are applied globally from ~/.cursor/rules/
    # Only copy project-specific rules if they exist
    print_status "Universal rules applied globally from ~/.cursor/rules/"
    
    # Agent documentation is handled globally - no project-specific agents needed
    print_status "Skipped: .cursor/agents/ (using global agent documentation)"
    
    print_success "Global rules and templates updated"
}

# Function to update global rules from chezmoi source
update_global_rules() {
    local chezmoi_rules="/Users/davidpanzarella/.local/share/chezmoi/home/dot_cursor/rules"
    local global_rules="/Users/davidpanzarella/.cursor/rules"
    
    if [[ -d "$chezmoi_rules" ]]; then
        mkdir -p "$global_rules"
        cp -r "$chezmoi_rules/"* "$global_rules/"
        print_status "Updated global rules from chezmoi source"
    fi
}

# Function to update global agents from chezmoi source
update_global_agents() {
    local chezmoi_agents="/Users/davidpanzarella/.local/share/chezmoi/home/dot_cursor/agents"
    local global_agents="/Users/davidpanzarella/.cursor/agents"
    
    if [[ -d "$chezmoi_agents" ]]; then
        mkdir -p "$global_agents"
        cp -r "$chezmoi_agents/"* "$global_agents/"
        print_status "Updated global agents from chezmoi source"
    fi
}

# Function to update global Cursor settings from chezmoi source
update_global_cursor_settings() {
    local update_script="/Users/davidpanzarella/.local/share/chezmoi/home/dot_local/bin/executable_update-cursor-settings.sh"
    
    if [[ -f "$update_script" ]]; then
        print_status "Updating global Cursor settings from chezmoi source..."
        bash "$update_script" >/dev/null 2>&1 || print_warning "Could not update Cursor settings (jq may be missing)"
    fi
}

# Function to create project-specific files
create_project_files() {
    local project_path="$1"
    local project_name="$2"
    
    print_status "Updating project configuration files..."
    
    # MCP configuration is handled globally - no project-specific MCP needed
    print_status "Skipped: .cursor/mcp.json (using global MCP configuration)"
    
    # Only create project.md if it doesn't exist or is a template
    if [[ ! -f "$project_path/.cursor/project.md" ]] || grep -q "\[Describe what this project accomplishes\]" "$project_path/.cursor/project.md"; then
        cat > "$project_path/.cursor/project.md" << EOF
---
title: "$project_name"
description: "AI-optimized project with knowledge management"
status: "active"
created: "$(date +%Y-%m-%d)"
---

# $project_name - AI Context

## Project Overview

- **Purpose**: [Describe what this project accomplishes]
- **Type**: [Application, library, documentation, etc.]
- **Audience**: [Who uses this project]

## Core Objectives

1. **Primary Goal**: [Main deliverable]
2. **Secondary Goals**: [Supporting objectives]
3. **Success Metrics**: [How you measure success]

## Technical Context

- **Stack**: [Technologies, frameworks, languages]
- **Architecture**: [System design, patterns]
- **Constraints**: [Performance, security, compatibility requirements]

## Development Workflow

- **AI Integration**: [How AI assists development]
- **Memory Routing**: [Where different types of content go]
- **Review Process**: [Code review, testing, deployment]

## Current Status

- **Phase**: [Planning, development, testing, production]
- **Next Steps**: [Immediate priorities]
- **Blockers**: [Current obstacles]
- **Timeline**: [Key milestones]
EOF
        print_status "Updated: .cursor/project.md"
    else
        print_status "Skipped: .cursor/project.md (already customized)"
    fi
    
    # VS Code tasks are handled globally - no project-specific tasks needed
    print_status "Skipped: .vscode/tasks.json (using global VS Code configuration)"
    
    # Only create .gitignore if it doesn't exist
    if [[ ! -f "$project_path/.gitignore" ]]; then
        cat > "$project_path/.gitignore" << EOF
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Build outputs
dist/
build/
out/

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE and editor files
.vscode/settings.json
.idea/
*.swp
*.swo
*~

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Logs
logs/
*.log

# Runtime data
pids/
*.pid
*.seed
*.pid.lock

# Cache directories
.cache/
.npm/
.eslintcache

# Temporary folders
tmp/
temp/

# Editor directories and files
.vscode/settings.json  # Global settings, not project-specific
!.vscode/extensions.json
!.vscode/tasks.json
.idea
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Memory system (uncomment if you want to exclude memories from git)
# memories/conversations/
# memories/notes/
# memories/tasks/
# memories/plans/
# memories/decisions/
# memories/knowledge/
# memories/lessons-learned/
EOF
        print_status "Created: .gitignore"
    else
        print_status "Skipped: .gitignore (already exists)"
    fi
    
    # Only create README if it doesn't exist or is a template
    if [[ ! -f "$project_path/README.md" ]] || grep -q "\[Project description\]" "$project_path/README.md"; then
        cat > "$project_path/README.md" << EOF
# $project_name

[Project description]

## Setup

This project is configured with AI-optimized development tools:

- **Basic-Memory**: Knowledge management and search
- **Cursor AI**: AI-assisted development
- **Foam**: Knowledge workspace
- **GitHub**: Issue tracking and automation

## Getting Started

1. Install dependencies: \`[add installation instructions]\`
2. Start development: \`[add start instructions]\`

## AI Development

This project uses AI-assisted development with:
- Memory system for knowledge management
- Automated conversation import
- Daily note processing
- Context-aware AI assistance

See \`.cursor/rules/\` for AI development guidelines.
EOF
        print_status "Updated: README.md"
    else
        print_status "Skipped: README.md (already customized)"
    fi
    
    print_success "Project configuration files updated"
}

# Function to set up basic-memory
setup_basic_memory() {
    local project_path="$1"
    local project_name="$2"
    
    print_status "Setting up basic-memory project..."
    
    cd "$project_path"
    
    # Create basic-memory project
    bm project add "$project_name" "$project_path/memories" 2>/dev/null || true
    
    print_success "Basic-memory project created: $project_name"
}

# Function to import conversation history
import_conversation_history() {
    local project_path="$1"
    local project_name="$2"
    local import_projects="$3"
    
    cd "$project_path"
    
    # Determine which projects to import from
    local projects_to_import=()
    if [[ -n "$import_projects" ]]; then
        # Parse comma-separated projects
        IFS=',' read -ra projects_to_import <<< "$import_projects"
        print_status "Importing conversation history from projects: ${projects_to_import[*]}"
    else
        # Default to current project
        projects_to_import=("$project_name")
        print_status "Importing conversation history for workspace: $project_name"
    fi
    
    # Export all conversations first
    print_status "Exporting all conversations from cursor-history"
    chi --extract
    
    # Find and move conversations from the latest extraction
    local cursor_conversations_dir="$HOME/Library/Preferences/cursor-history-nodejs/conversations"
    
    if [[ -d "$cursor_conversations_dir" ]]; then
        local moved_count=0
        
        # Find the latest extraction directory
        local latest_extraction=$(find "$cursor_conversations_dir" -maxdepth 1 -type d -name "2025-*" | sort | tail -1)
        
        if [[ -n "$latest_extraction" && -d "$latest_extraction" ]]; then
            print_status "Found latest extraction: $(basename "$latest_extraction")"
            
            # Look for conversations that match the specified workspaces
            local files_found=()
            while IFS= read -r -d '' file; do
                files_found+=("$file")
            done < <(find "$latest_extraction" -name "*.md" -type f -print0)
            
            for file in "${files_found[@]}"; do
                if [[ -f "$file" ]]; then
                    # Check if this conversation belongs to one of the target workspaces
                    local file_workspace=""
                    for workspace in "${projects_to_import[@]}"; do
                        if grep -q "_Workspace: \`$workspace\`" "$file"; then
                            file_workspace="$workspace"
                            break
                        fi
                    done
                    
                    # Only import if it matches one of our target workspaces
                    if [[ -n "$file_workspace" ]]; then
                        filename=$(basename "$file")
                        local target_file="$project_path/memories/conversations/$filename"
                        
                        # Add frontmatter and move the file
                        {
                            cat << FRONTMATTER
---
type: conversation
category: ai-discussion
project: $project_name
created: $(date +"%Y-%m-%d")
status: archived
tags: [conversation, ai, discussion, imported]
participants: [user, ai-assistant]
context: $filename
source: cursor-history
workspace: $file_workspace
---

FRONTMATTER
                            cat "$file"
                        } > "$target_file"
                        
                        echo "✅ Imported: $filename (workspace: $file_workspace)"
                        ((moved_count++))
                    fi
                fi
            done
            
            print_success "Imported $moved_count conversations from workspaces: ${projects_to_import[*]}"
        else
            print_warning "No latest extraction directory found"
        fi
    else
        print_warning "No cursor-history conversations directory found"
    fi
}

# Function to create initial memory files
create_initial_memories() {
    local project_path="$1"
    local project_name="$2"
    
    print_status "Creating initial memory files..."
    
    # Only create lessons-learned README if it doesn't exist
    if [[ ! -f "$project_path/memories/lessons-learned/README.md" ]]; then
        cat > "$project_path/memories/lessons-learned/README.md" << EOF
---
title: "Lessons Learned"
description: "What worked, what didn't, and retrospectives"
created: "$(date +%Y-%m-%d)"
tags: ["lessons-learned", "retrospective", "knowledge"]
status: "active"
---

# Lessons Learned

This folder contains retrospectives and lessons learned from this project.

## Template

\`\`\`markdown
---
title: "Lesson: [Brief Description]"
description: "What we learned from this experience"
created: "YYYY-MM-DD"
tags: ["lesson", "project-name", "category"]
status: "active"
---

# Lesson: [Brief Description]

## Context
What was the situation or project?

## What Worked
- List successful approaches
- Tools or methods that helped
- Positive outcomes

## What Didn't Work
- Challenges encountered
- Failed approaches
- Negative outcomes

## Key Insights
- Main takeaways
- Patterns observed
- Root causes

## Recommendations
- What to do differently next time
- Best practices to adopt
- Things to avoid
\`\`\`
EOF
        print_status "Created: memories/lessons-learned/README.md"
    else
        print_status "Skipped: memories/lessons-learned/README.md (already exists)"
    fi
    
    print_success "Initial memory files processed"
}

# Function to show what will be updated
show_update_summary() {
    local project_path="$1"
    
    echo ""
    print_status "Update Summary:"
    echo "  ✅ Always updated: Global rules, global agents, global settings, global MCP, global VS Code"
    echo "  ⚠️  Conditionally created: .gitignore (only if missing)"
    echo "  ⚠️  Conditionally updated: project.md, README.md (only if template)"
    echo "  🔒 Never touched: Existing project files, user content, conversations, memories"
    echo ""
}

# Main function
main() {
    local project_name=""
    local import_history=false
    local import_projects=""
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --import-history)
                import_history=true
                shift
                ;;
            --projects)
                import_projects="$2"
                shift 2
                ;;
            --help|-h)
                show_usage
                exit 0
                ;;
            -*)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
            *)
                if [[ -z "$project_name" ]]; then
                    project_name="$1"
                else
                    print_error "Multiple project names provided"
                    show_usage
                    exit 1
                fi
                shift
                ;;
        esac
    done
    
    # Check dependencies
    check_dependencies
    
    # Get project info
    local project_info
    project_info=$(get_project_info "$project_name")
    project_name=$(echo "$project_info" | cut -d'|' -f1)
    local project_path=$(echo "$project_info" | cut -d'|' -f2)
    
    # Create new directory if needed
    if [[ "$project_path" != "$(pwd)" ]]; then
        mkdir -p "$project_path"
        cd "$project_path"
    fi
    
    # Show what will be updated
    show_update_summary "$project_path"
    
    # Initialize project
    create_directory_structure "$project_path"
    update_global_rules   # Update global rules from chezmoi source first
    update_global_agents  # Update global agents from chezmoi source first
    update_global_cursor_settings  # Update global Cursor settings from chezmoi source
    copy_global_rules "$project_path"
    create_project_files "$project_path" "$project_name"
    setup_basic_memory "$project_path" "$project_name"
    create_initial_memories "$project_path" "$project_name"
    
    # Import history if requested
    if [[ "$import_history" == true ]]; then
        import_conversation_history "$project_path" "$project_name" "$import_projects"
    fi
    
    # Final success message
    echo ""
    print_success "Project '$project_name' initialized successfully!"
    echo ""
    echo "Next steps:"
    echo "  1. Open project in Cursor: code $project_path"
    echo "  2. Verify basic-memory integration in Cursor settings"
    echo "  3. Start using AI-assisted development"
    echo ""
    if [[ "$import_history" == true ]]; then
        echo "  4. Review imported conversations in memories/conversations/"
    fi
    echo ""
    echo "AI Development Commands:"
    echo "  - Use basic-memory MCP tools directly in Cursor"
    echo "  - Export conversations with: chi --select"
    echo "  - Process daily notes with AI agents"
}

# Run main function
main "$@"
