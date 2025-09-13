---
title: "Cursor Agents Setup Guide"
description: "Documentation for setting up AI agents in Cursor for memory management and conversation processing"
created: "2024-09-12"
tags: ["agents", "cursor", "ai", "automation"]
status: "active"
---

# Cursor Agents Setup Guide

This directory contains documentation for setting up AI agents in Cursor to automate memory management and conversation processing.

## Available Agents

### 1. Memory Assistant

- **File**: `memory-assistant.md`
- **Purpose**: Use basic-memory MCP tools during conversations
- **Triggers**: "save this", "create note", "add to tasks"

### 2. Conversation Importer

- **File**: `conversation-importer.md`
- **Purpose**: Import conversations using cursor-history
- **Triggers**: "import conversation", "sync conversations"

### 3. Daily Note Processor

- **File**: `daily-note-processor.md`
- **Purpose**: Process daily notes into structured content
- **Triggers**: "process daily note", "extract tasks"

## Setup Instructions

1. **Open Cursor Settings**

   - Go to Cursor → Preferences → Agents
   - Click "Add Custom Agent"

2. **Create Each Agent**

   - Use the configurations in the individual markdown files
   - Copy the "Custom Instructions" section
   - Set appropriate triggers and permissions

3. **Configure Permissions**

   - Enable MCP tools for basic-memory
   - Enable terminal commands for cursor-history
   - Enable file operations for note creation

4. **Test Agents**
   - Try each trigger phrase
   - Verify MCP tool integration
   - Check output in memories directory

## Workflow Integration

These agents work together to create a seamless AI-assisted development workflow:

1. **During conversations**: Use Memory Assistant to save important information
2. **End of conversations**: Use Conversation Importer to archive discussions
3. **Daily workflow**: Use Daily Note Processor to organize thoughts and tasks

## Troubleshooting

- **MCP tools not available**: Check basic-memory project setup
- **Agents not responding**: Verify trigger phrases and permissions
- **File creation issues**: Check write permissions in memories directory

## Next Steps

After setting up agents:

1. Test with real conversations
2. Refine trigger phrases based on usage
3. Add additional agents as needed
4. Integrate with GitHub workflow
