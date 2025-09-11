#!/usr/bin/env bash
set -euo pipefail

# Migrate Past Conversations to Memory System
# This script helps organize existing conversations, documentation, and issues

PROJECT_ROOT="$(pwd)"
PROJECT_NAME="$(basename "$PROJECT_ROOT")"

echo "🔄 Migrating past conversations and documentation for: $PROJECT_NAME"
echo "📍 Location: $PROJECT_ROOT"
echo ""

# Check if memories directory exists
if [[ ! -d "memories" ]]; then
    echo "❌ No memories directory found. Run 'setup-project' first."
    exit 1
fi

# Function to process conversation files
process_conversation_file() {
    local file="$1"
    local title="$2"
    local date=$(date +"%Y-%m-%d")
    local timestamp=$(date +"%Y%m%d-%H%M%S")
    
    echo "📝 Processing: $title"
    
    # Create new filename with timestamp
    local new_filename="${timestamp}-${title// /-}.md"
    local target_file="memories/journal/conversations/$new_filename"
    
    # Add frontmatter and content
    {
        cat << EOF
---
type: conversation
category: ai-discussion
project: $PROJECT_NAME
created: $date
status: archived
tags: [conversation, ai, discussion, migrated]
participants: [user, ai-assistant]
context: $title
source: migrated
---

EOF
        cat "$file"
    } > "$target_file"
    
    echo "✅ Migrated to: $target_file"
}

# Function to extract decisions from conversation
extract_decisions() {
    local file="$1"
    local title="$2"
    
    # Look for decision patterns
    if grep -qi "decision\|decided\|choose\|selected\|adopted" "$file"; then
        echo "🎯 Found potential decisions in: $title"
        echo "   Consider running: mem create-adr \"$title decisions\""
    fi
}

# Function to extract knowledge
extract_knowledge() {
    local file="$1"
    local title="$2"
    
    # Look for knowledge patterns
    if grep -qi "learned\|discovered\|found out\|realized\|insight" "$file"; then
        echo "🧠 Found potential knowledge in: $title"
        echo "   Consider extracting to: memories/knowledge/"
    fi
}

# Function to extract issues
extract_issues() {
    local file="$1"
    local title="$2"
    
    # Look for issue patterns
    if grep -qi "bug\|error\|problem\|issue\|fix\|broken" "$file"; then
        echo "🐛 Found potential issues in: $title"
        echo "   Consider moving to: memories/issues/"
    fi
}

# Function to extract plans
extract_plans() {
    local file="$1"
    local title="$2"
    
    # Look for plan patterns
    if grep -qi "plan\|roadmap\|strategy\|approach\|next steps" "$file"; then
        echo "📋 Found potential plans in: $title"
        echo "   Consider moving to: memories/plans/"
    fi
}

echo "🔍 Scanning for existing conversations and documentation..."

# Process .cursor/rules files
if [[ -d ".cursor/rules" ]]; then
    echo "📁 Found .cursor/rules directory"
    for rule_file in .cursor/rules/*.mdc; do
        if [[ -f "$rule_file" ]]; then
            local basename=$(basename "$rule_file" .mdc)
            process_conversation_file "$rule_file" "cursor-rule-$basename"
        fi
    done
fi

# Process .cursorrules (legacy)
if [[ -f ".cursorrules" ]]; then
    echo "📁 Found legacy .cursorrules file"
    process_conversation_file ".cursorrules" "legacy-cursor-rules"
fi

# Process .specstory files
if [[ -d ".specstory" ]]; then
    echo "📁 Found .specstory directory"
    for spec_file in .specstory/**/*.md; do
        if [[ -f "$spec_file" ]]; then
            local basename=$(basename "$spec_file" .md)
            process_conversation_file "$spec_file" "specstory-$basename"
        fi
    done
fi

# Process GitHub issues (if .github exists)
if [[ -d ".github" ]]; then
    echo "📁 Found .github directory"
    echo "   Consider using 'gh issue list' to export issues"
    echo "   Then run: mem create-adr for resolved issues"
fi

# Process existing documentation
if [[ -d "docs" ]]; then
    echo "📁 Found docs directory"
    for doc_file in docs/**/*.md; do
        if [[ -f "$doc_file" ]]; then
            local basename=$(basename "$doc_file" .md)
            process_conversation_file "$doc_file" "doc-$basename"
        fi
    done
fi

# Process any existing conversation files
for conv_file in **/*conversation*.md; do
    if [[ -f "$conv_file" ]]; then
        local basename=$(basename "$conv_file" .md)
        process_conversation_file "$conv_file" "conversation-$basename"
    fi
done

echo ""
echo "🎯 Content Analysis Complete!"
echo ""
echo "📋 Next Steps:"
echo "   1. Review migrated conversations in memories/journal/conversations/"
echo "   2. Extract decisions: mem create-adr \"decision title\""
echo "   3. Extract knowledge: mem extract-knowledge"
echo "   4. Process daily notes: mem process-daily"
echo "   5. Update memories/ with project-specific insights"
echo ""
echo "💡 Pro Tips:"
echo "   - Use 'mem list conversations' to see all migrated conversations"
echo "   - Use 'mem search \"keyword\"' to find specific content"
echo "   - Use 'mem extract-knowledge' to process conversations for insights"
echo ""
echo "✅ Migration complete! Your past conversations are now organized in the memory system."
