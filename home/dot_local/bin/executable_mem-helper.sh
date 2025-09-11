#!/usr/bin/env bash
set -euo pipefail

# Memory helper functions for conversation management

# Resolve repo root and name
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  ROOT="$(git rev-parse --show-toplevel)"
  NAME="$(basename "$ROOT")"
else
  ROOT="$(pwd)"
  NAME="$(basename "$ROOT")"
fi

MEM_DIR="$ROOT/memories"

# Ensure memories directory exists
if [[ ! -d "$MEM_DIR" ]]; then
  echo "Error: memories directory not found. Run basic-memory setup first." >&2
  exit 1
fi

# Function to save a conversation
save_conversation() {
  local title="$1"
  local date=$(date +"%Y-%m-%d")
  local timestamp=$(date +"%Y%m%d-%H%M%S")
  local filename="${timestamp}-${title//[^a-zA-Z0-9]/-}.md"
  
  cat > "$MEM_DIR/conversations/$filename" << EOF
---
type: conversation
category: ai-discussion
project: $NAME
created: $date
status: draft
tags: [conversation, ai, discussion]
participants: [user, ai-assistant]
context: $title
---

# Conversation: $title

**Date:** $date  
**Project:** $NAME  
**Context:** AI Assistant Discussion

## Summary
<!-- Brief summary of what was discussed -->

## Key Points
<!-- Main topics and insights -->

## Decisions Made
<!-- Any decisions that came out of this conversation -->

## Action Items
<!-- Tasks or follow-ups identified -->

## Full Transcript
<!-- Paste the full conversation here -->

## Related Files
<!-- Links to any files, specs, or other conversations referenced -->

## Next Steps
<!-- What should happen next based on this conversation -->
EOF

  echo "Created conversation file: $filename"
  echo "Edit it to add the full transcript and key insights"
}

# Function to create an ADR
create_adr() {
  local title="$1"
  local date=$(date +"%Y-%m-%d")
  local timestamp=$(date +"%Y%m%d-%H%M%S")
  local filename="ADR-${timestamp}-${title//[^a-zA-Z0-9]/-}.md"
  
  cat > "$MEM_DIR/decisions/$filename" << EOF
---
type: decision
category: adr
project: $NAME
created: $date
status: proposed
tags: [decision, adr, architecture]
adr-number: ${timestamp}
---

# ADR-${timestamp}: $title

## Status
Proposed

## Context
<!-- Describe the context and problem statement -->

## Decision
<!-- State the architectural decision -->

## Rationale
<!-- Explain the reasoning behind this decision -->

## Consequences
### Positive
<!-- List positive consequences -->

### Negative
<!-- List negative consequences -->

## Alternatives Considered
<!-- List alternatives that were considered -->

## References
<!-- Links to related conversations, specs, or other ADRs -->
EOF

  echo "Created ADR: $filename"
  echo "Edit it to add the full decision details"
}

# Function to extract knowledge from a specific conversation file
extract_knowledge_from_file() {
  local conversation_file="$1"
  
  if [[ ! -f "$conversation_file" ]]; then
    echo "Error: Conversation file not found: $conversation_file"
    return 1
  fi
  
  echo "🧠 Extracting knowledge from: $(basename "$conversation_file")"
  
  # This is a simplified version - in practice, you'd use AI to parse the content
  # For now, we'll create a basic extraction based on common patterns
  
  local date=$(date +"%Y-%m-%d")
  local timestamp=$(date +"%Y%m%d-%H%M%S")
  
  # Extract potential decisions
  if grep -qi "decided\|chose\|selected\|will use\|going with" "$conversation_file"; then
    echo "📋 Found potential decisions - consider creating ADRs"
    echo "   Use: mem create-adr \"decision-title\""
  fi
  
  # Extract potential tasks
  if grep -qi "todo\|task\|need to\|should\|must" "$conversation_file"; then
    echo "✅ Found potential tasks - consider adding to tasks/next.md"
  fi
  
  # Extract potential knowledge
  if grep -qi "learned\|discovered\|found out\|realized" "$conversation_file"; then
    echo "💡 Found potential knowledge - consider adding to knowledge/"
  fi
  
  echo ""
  echo "🔍 Manual review recommended:"
  echo "   - Review the conversation for important insights"
  echo "   - Create ADRs for architectural decisions"
  echo "   - Add tasks to tasks/next.md"
  echo "   - Update knowledge/ with important facts"
  echo ""
  echo "📝 Conversation saved with proper frontmatter for AI processing"
}

# Function to extract decisions from conversations
extract_decisions() {
  local conversations_dir="$MEM_DIR/conversations"
  local decisions_dir="$MEM_DIR/decisions"
  
  if [[ ! -d "$conversations_dir" ]]; then
    echo "No conversations directory found"
    return 0
  fi
  
  echo "Scanning conversations for decisions..."
  
  # Find conversations with decisions
  find "$conversations_dir" -name "*.md" -exec grep -l "decisions\|decided\|chose\|selected" {} \; | while read -r file; do
    echo "Found decisions in: $(basename "$file")"
    # This could be enhanced to automatically extract and create ADRs
  done
}

# Function to move and process exported conversation
move_conversation_to_memories() {
  local exported_file="$1"
  local date=$(date +"%Y-%m-%d")
  local timestamp=$(date +"%Y%m%d-%H%M%S")
  
  if [[ ! -f "$exported_file" ]]; then
    echo "Error: Exported file not found: $exported_file"
    return 1
  fi
  
  # Extract title from filename (remove path and extension)
  local basename=$(basename "$exported_file" .md)
  local title="${basename//-/ }"
  
  # Create new filename with timestamp
  local new_filename="${timestamp}-${basename}.md"
  local target_file="$MEM_DIR/conversations/$new_filename"
  
  echo "Processing conversation: $title"
  
  # Read the exported file and add frontmatter
  {
    cat << EOF
---
type: conversation
category: ai-discussion
project: $NAME
created: $date
status: archived
tags: [conversation, ai, discussion, exported]
participants: [user, ai-assistant]
context: $title
source: cursor-history
---

EOF
    cat "$exported_file"
  } > "$target_file"
  
  # Remove the original exported file
  rm "$exported_file"
  
  echo "✅ Conversation saved to: $target_file"
  echo "📝 Added proper frontmatter and metadata"
  echo "🗑️ Removed original file from downloads"
  
  # Offer to extract knowledge
  echo ""
  echo "💡 Next steps:"
  echo "   - Use 'mem extract-knowledge' to process this conversation"
  echo "   - Or manually review and edit the conversation file"
  
  # Ask if user wants to extract knowledge automatically
  echo ""
  read -p "🤖 Extract knowledge from this conversation automatically? (y/n): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    extract_knowledge_from_file "$target_file"
  fi
}

# Function to check for GitHub integration
check_github_integration() {
  if [[ -d "$ROOT/.github" ]]; then
    echo "GitHub integration available"
    return 0
  else
    echo "No GitHub integration - using local issues"
    return 1
  fi
}

# Function to create GitHub issue
create_github_issue() {
  local title="$1"
  local body="$2"
  local labels="$3"
  
  if command -v gh &> /dev/null; then
    gh issue create --title "$title" --body "$body" --label "$labels"
    echo "Created GitHub issue: $title"
  else
    echo "GitHub CLI not available. Install with: brew install gh"
    return 1
  fi
}

# Function to export latest Cursor conversation
export_latest_conversation() {
  if ! command -v chi &> /dev/null; then
    echo "cursor-history not installed. Install with: pnpm install -g @johnlindquist/cursor-history@latest"
    return 1
  fi
  
  echo "To export the latest Cursor conversation, use:"
  echo "  chi --workspace $NAME"
  echo ""
  echo "This will export the latest conversation and copy it to your clipboard."
  echo "You can then paste it into a file in memories/conversations/"
}

# Function to export project-specific conversations
export_conversation() {
  if ! command -v chi &> /dev/null; then
    echo "cursor-history not installed. Install with: pnpm install -g @johnlindquist/cursor-history@latest"
    return 1
  fi
  
  echo "🚀 Exporting conversations for project: $NAME"
  echo "📁 Target: $MEM_DIR/conversations/"
  echo ""
  
  # Create conversations directory if it doesn't exist
  mkdir -p "$MEM_DIR/conversations"
  
  # Get the number of conversations for this workspace
  local conversation_count=$(chi --workspace "$NAME" 2>&1 | grep "Found.*conversations" | sed 's/.*Found \([0-9]*\) conversations.*/\1/')
  
  if [[ -n "$conversation_count" && "$conversation_count" -gt 0 ]]; then
    echo "📊 Found $conversation_count conversations for workspace: $NAME"
    echo ""
    echo "💡 To export conversations for this project:"
    echo "  1. Run: chi --workspace $NAME"
    echo "     (This exports the latest conversation for this workspace)"
    echo ""
    echo "  2. For all conversations globally (then filter manually):"
    echo "     chi --extract"
    echo ""
    echo "  3. To browse and select specific conversations:"
    echo "     chi --browse"
    echo ""
    echo "📝 After exporting, conversations will be saved to:"
    echo "   $MEM_DIR/conversations/"
    echo ""
    echo "🔄 Then use these commands to process them:"
    echo "  mem extract-knowledge <file>  # Extract insights from a conversation"
    echo "  mem create-adr \"title\"      # Create decision records"
    echo "  mem search \"query\"          # Search across all memories"
  else
    echo "❌ No conversations found for workspace: $NAME"
    echo "   Make sure you're in the correct project directory"
    echo "   and that Cursor has saved conversations for this workspace"
  fi
}

# Function to export all conversations for the current project
export_all_conversations() {
  if ! command -v chi &> /dev/null; then
    echo "cursor-history not installed. Install with: pnpm install -g @johnlindquist/cursor-history@latest"
    return 1
  fi
  
  echo "🚀 Exporting conversations for project: $NAME"
  echo "📁 Target: $MEM_DIR/conversations/"
  echo ""
  
  # Create conversations directory if it doesn't exist
  mkdir -p "$MEM_DIR/conversations"
  
  # Get the number of conversations for this workspace
  local conversation_count=$(chi --workspace "$NAME" 2>&1 | grep "Found.*conversations" | sed 's/.*Found \([0-9]*\) conversations.*/\1/')
  
  if [[ -n "$conversation_count" && "$conversation_count" -gt 0 ]]; then
    echo "📊 Found $conversation_count conversations for workspace: $NAME"
    echo ""
    echo "🔄 Exporting conversations for this project only..."
    
    # Export all conversations globally first
    chi --extract
    
    # Find the cursor-history conversations directory
    local cursor_conversations_dir="$HOME/Library/Preferences/cursor-history-nodejs/conversations"
    
    if [[ -d "$cursor_conversations_dir" ]]; then
      echo "📁 Filtering conversations from: $cursor_conversations_dir"
      
      # Look for conversations that contain the project name in the filename or content
      # Search recursively through subdirectories and process them
      local moved_count=0
      
      # Create a temporary file to store the count
      local count_file=$(mktemp)
      echo "0" > "$count_file"
      
      find "$cursor_conversations_dir" -name "*.md" -type f -print0 | while IFS= read -r -d '' file; do
        if [[ -f "$file" ]]; then
          local filename=$(basename "$file")
          
          # Check if filename contains project name (this is the primary indicator)
          # Only match conversations that were actually in this workspace
          if [[ "$filename" == *"$NAME"* ]]; then
            # Use the original conversation filename (already contains date and context)
            local basename=$(basename "$file" .md)
            local new_filename="${basename}.md"
            local target_file="$MEM_DIR/conversations/$new_filename"
            
            # Add frontmatter and move the file
            {
              cat << EOF
---
type: conversation
category: ai-discussion
project: $NAME
created: $(date +"%Y-%m-%d")
status: archived
tags: [conversation, ai, discussion, exported]
participants: [user, ai-assistant]
context: $basename
source: cursor-history
---

EOF
              cat "$file"
            } > "$target_file"
            
            echo "✅ Moved: $filename -> $new_filename"
            # Increment count in temp file
            local current_count=$(cat "$count_file")
            echo $((current_count + 1)) > "$count_file"
          fi
        fi
      done
      
      # Get the final count
      moved_count=$(cat "$count_file")
      rm "$count_file"
      
      echo ""
      echo "✅ Export complete!"
      echo "📊 Moved $moved_count conversations for project: $NAME"
      echo "📁 Conversations saved to: $MEM_DIR/conversations/"
      echo ""
      echo "🔄 Next steps:"
      echo "  mem extract-knowledge <file>  # Extract insights from conversations"
      echo "  mem create-adr \"title\"      # Create decision records"
      echo "  mem search \"query\"          # Search across all memories"
      
      # Clean up the global export directory
      echo ""
      read -p "🗑️  Clean up global export directory? (y/N): " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -f "$cursor_conversations_dir"/*.md
        echo "✅ Cleaned up global export directory"
      fi
    else
      echo "❌ Could not find cursor-history conversations directory"
      echo "   Expected: $cursor_conversations_dir"
    fi
  else
    echo "❌ No conversations found for workspace: $NAME"
    echo "   Make sure you're in the correct project directory"
    echo "   and that Cursor has saved conversations for this workspace"
  fi
}

# Function to move exported conversation to memories directory
move_exported_conversation() {
  local temp_file="$1"
  local project_name="$2"
  
  if [[ -f "$temp_file" ]]; then
    # Create conversations directory if it doesn't exist
    mkdir -p "$MEM_DIR/conversations"
    
    # Use the original conversation filename (already contains date and context)
    local basename=$(basename "$temp_file" .md)
    local new_filename="${basename}.md"
    local target_file="$MEM_DIR/conversations/$new_filename"
    
    # Add frontmatter and move the file
    {
      cat << EOF
---
type: conversation
category: ai-discussion
project: $project_name
created: $(date +"%Y-%m-%d")
status: archived
tags: [conversation, ai, discussion, exported]
participants: [user, ai-assistant]
context: $basename
source: cursor-history
---

EOF
      cat "$temp_file"
    } > "$target_file"
    
    # Remove the temporary file
    rm "$temp_file"
    
    echo "✅ Conversation moved to: $target_file"
    echo "📝 Added proper frontmatter and metadata"
    
    return 0
  else
    echo "❌ Temporary file not found: $temp_file"
    return 1
  fi
}

# Function to process daily notes
process_daily_notes() {
  local date=$(date +"%Y-%m-%d")
  local daily_note="$MEM_DIR/journal/$date.md"
  
  if [[ ! -f "$daily_note" ]]; then
    echo "No daily note found for today: $daily_note"
    return 1
  fi
  
  echo "Processing daily note: $daily_note"
  
  # Simple categorization based on content patterns
  local has_issues=false
  local has_plans=false
  local has_tasks=false
  local has_knowledge=false
  
  # Check for different types of content
  if grep -qi "bug\|error\|fix\|problem\|issue" "$daily_note"; then
    has_issues=true
  fi
  
  if grep -qi "plan\|roadmap\|strategy\|approach" "$daily_note"; then
    has_plans=true
  fi
  
  if grep -qi "todo\|task\|need to\|should\|must" "$daily_note"; then
    has_tasks=true
  fi
  
  if grep -qi "learned\|discovered\|found out\|realized" "$daily_note"; then
    has_knowledge=true
  fi
  
  echo "📋 Content analysis:"
  [[ "$has_issues" == true ]] && echo "   - Issues found"
  [[ "$has_plans" == true ]] && echo "   - Plans found"
  [[ "$has_tasks" == true ]] && echo "   - Tasks found"
  [[ "$has_knowledge" == true ]] && echo "   - Knowledge found"
  
  echo ""
  echo "💡 Next steps:"
  echo "   - Review the daily note manually"
  echo "   - Use 'mem create-adr' for decisions"
  echo "   - Use 'mem save-conversation' for important discussions"
  echo "   - Add tasks to tasks/next.md"
  echo "   - Update knowledge/ with important facts"
  
  if check_github_integration; then
    echo "   - GitHub integration available for issues"
  fi
}

# Function to search across all memories
search_memories() {
  local query="$1"
  echo "Searching memories for: $query"
  
  find "$MEM_DIR" -name "*.md" -type f -exec grep -l "$query" {} \; | while read -r file; do
    echo "Found in: ${file#$MEM_DIR/}"
  done
}

# Function to list items by type
list_items() {
  local type="$1"
  local dir="$MEM_DIR/$type"
  
  if [[ ! -d "$dir" ]]; then
    echo "No $type directory found"
    return 0
  fi
  
  echo "=== $type ==="
  find "$dir" -name "*.md" -type f | while read -r file; do
    local basename=$(basename "$file" .md)
    echo "- $basename"
  done
}

# Main command handling
case "${1:-}" in
  "save-conversation")
    if [[ -z "${2:-}" ]]; then
      echo "Usage: mem save-conversation \"title\""
      exit 1
    fi
    save_conversation "$2"
    ;;
  "create-adr")
    if [[ -z "${2:-}" ]]; then
      echo "Usage: mem create-adr \"title\""
      exit 1
    fi
    create_adr "$2"
    ;;
  "extract-decisions")
    extract_decisions
    ;;
  "extract-knowledge")
    if [[ -z "${2:-}" ]]; then
      echo "Usage: mem extract-knowledge [conversation-file]"
      echo "       mem extract-knowledge (will process all recent conversations)"
      exit 1
    fi
    extract_knowledge_from_file "$2"
    ;;
  "process-daily")
    process_daily_notes
    ;;
  "export-conversation")
    export_conversation
    ;;
  "export-latest")
    export_latest_conversation
    ;;
  "export-all")
    export_all_conversations
    ;;
  "move-exported")
    if [[ -z "${2:-}" ]]; then
      echo "Usage: mem move-exported <temp-file-path>"
      echo "Example: mem move-exported /var/folders/.../conversation.md"
      exit 1
    fi
    move_exported_conversation "$2" "$NAME"
    ;;
  "check-github")
    check_github_integration
    ;;
  "search")
    if [[ -z "${2:-}" ]]; then
      echo "Usage: mem search \"query\""
      exit 1
    fi
    search_memories "$2"
    ;;
  "list")
    if [[ -z "${2:-}" ]]; then
      echo "Usage: mem list [issues|tasks|decisions|conversations]"
      exit 1
    fi
    list_items "$2"
    ;;
  *)
    echo "Memory Helper Commands:"
    echo "  save-conversation \"title\"  - Save a new conversation"
    echo "  create-adr \"title\"        - Create a new ADR"
    echo "  extract-decisions          - Extract decisions from conversations"
    echo "  extract-knowledge [file]   - Extract knowledge from conversation file"
    echo "  process-daily              - Process daily notes (analyze content)"
    echo "  export-conversation        - Show instructions for exporting conversations"
    echo "  export-latest              - Export latest Cursor conversation"
    echo "  export-all                 - Export all conversations for current project"
    echo "  move-exported <file>       - Move exported conversation to memories directory"
    echo "  check-github               - Check GitHub integration status"
    echo "  search \"query\"            - Search across all memories"
    echo "  list [type]               - List items by type"
    ;;
esac
