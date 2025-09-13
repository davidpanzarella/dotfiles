---
title: "Conversation Importer Agent"
description: "Agent for importing conversations using cursor-history"
created: "2024-09-12"
tags: ["agent", "conversation", "cursor-history", "import"]
status: "active"
---

# Conversation Importer Agent

## Purpose

Imports conversations from Cursor history and processes them into the knowledge base using cursor-history (chi) tool.

## Cursor Agent Configuration

### Agent Name

`Conversation Importer`

### Trigger Phrases

- "import conversation"
- "sync conversations"
- "import latest"
- "fetch conversations"
- "export conversation"
- "save conversation"

### Permissions

- ✅ Terminal Commands
- ✅ Read Files
- ✅ Write Files
- ❌ MCP Tools
- ❌ Web Search

### Custom Instructions

````markdown
IMPORT CONVERSATIONS from Cursor history and organize them into the knowledge base. Use cursor-history (chi) tool to export conversations, then process them with proper metadata.

## CRITICAL SUCCESS CRITERIA

- Export conversations using appropriate chi command
- Add complete YAML frontmatter with metadata
- Save to `memories/conversations/` directory
- Confirm import with file list and next steps

## AVAILABLE COMMANDS (Use exactly as specified)

- `chi --select` - Interactive conversation selection (for specific requests)
- `chi` - Export latest conversation (for "latest" requests)
- `chi --workspace "project-name"` - Export project-specific conversations
- `chi --browse` - Browse all available conversations

## STEP-BY-STEP PROCESS

**STEP 1: Export Conversations**

- Identify user request type (latest, specific, all, browse)
- Execute appropriate chi command
- Export to temporary location for processing

**STEP 2: Process Exported Files**

- Move files to `memories/conversations/` directory
- Add complete YAML frontmatter (see template below)
- Include all required metadata fields
- Use descriptive filenames with date and context

**STEP 3: Confirm Import**

- Report exact number of conversations imported
- List all imported conversation files with paths
- Suggest next steps (knowledge extraction, task creation)

## REQUIRED FRONTMATTER TEMPLATE

```yaml
---
type: conversation
category: ai-discussion
project: [project-name]
created: [YYYY-MM-DD]
status: archived
tags: [conversation, ai, discussion, imported]
participants: [user, ai-assistant]
context: [conversation-title]
source: cursor-history
---
```

## ERROR HANDLING

- If chi command fails: Check cursor-history installation
- If export fails: Verify Cursor database access
- If file permissions error: Check write access to memories directory
- Always report specific errors and suggest solutions

REMEMBER: Import conversations, add complete metadata, save to conversations folder, confirm with details.
````

## Usage Examples

### Import Latest

User: "import latest conversation"
→ Use `chi` to export latest conversation

### Import Specific

User: "import conversation about authentication"
→ Use `chi --select` for interactive selection

### Import All

User: "sync all conversations"
→ Use `chi --workspace` to export project-specific conversations

### Import and Process

User: "import and process conversations"
→ Import conversations, then suggest knowledge extraction

## Output

- Conversations saved to `memories/conversations/`
- Proper frontmatter added
- Ready for knowledge extraction
- Confirmation with file list

## Best Practices

- Always confirm what will be imported before proceeding
- Use appropriate chi command for the request
- Add descriptive frontmatter
- Clean up temporary files
- Suggest next steps after import

```

## Testing

### Test Cases
1. **Latest**: "import latest conversation"
2. **Specific**: "import conversation about memory system"
3. **All**: "sync all conversations for this project"
4. **Browse**: "show me available conversations"

### Expected Behavior
- Agent uses appropriate chi command
- Exports conversations successfully
- Adds proper frontmatter
- Confirms import with details
- Suggests next steps

## Troubleshooting

### Common Issues
- **chi command not found**: Check cursor-history installation
- **No conversations found**: Verify Cursor has saved conversations
- **Export fails**: Check Cursor database access
- **File permissions**: Verify write access to memories directory

### Debug Steps
1. Check cursor-history installation: `chi --help`
2. Verify Cursor conversation database
3. Test simple export: `chi`
4. Check memories directory permissions
5. Verify project context

## Dependencies
- cursor-history (chi) must be installed
- Cursor must have conversation history
- Write access to memories/conversations/ directory
```
