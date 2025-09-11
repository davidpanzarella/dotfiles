# Cursor AI Rules

## 🎯 AI Agent Behavior

### System Context (Auto-Apply)

- **Homebrew**: Use ARM64 path `/opt/homebrew/bin/brew` on Apple Silicon
- **Package manager**: Use `pnpm` unless specified otherwise
- **Chezmoi**: Always run in interactive mode (`chezmoi apply --interactive`)
- **Terminal**: Always use configured context from dotfiles setup (zsh with aliases, ARM64 Homebrew, etc.)
- **Memory system**: Use `mem` commands for knowledge management

**CRITICAL**: When opening terminal, ensure it uses the configured dotfiles environment with proper aliases, Homebrew paths, and shell configuration.

### Automatic Content Routing

When processing content, automatically route to appropriate `memories/` folders:

- **Facts & learnings** → `memories/knowledge/`
- **Plans & specifications** → `memories/plans/`
- **Problems & questions** → `memories/issues/`
- **Architectural decisions** → `memories/decisions/` (create ADR)
- **Task management** → `memories/tasks/`
- **AI conversations** → `memories/journal/conversations/`
- **Daily notes** → `memories/notes/` (process with `mem process-daily`)

### Memory System Commands

- `mem save-conversation "title"` - Save current AI conversation
- `mem create-adr "decision"` - Create architecture decision record
- `mem process-daily` - Analyze and categorize daily notes
- `mem export-conversation` - Export Cursor conversations
- `mem extract-knowledge` - Extract insights from conversations

### System Commands (Auto-Apply)

- Use `chezmoi apply --interactive` for dotfile changes
- Use `pnpm` for package management unless specified
- Use ARM64 Homebrew path `/opt/homebrew/bin/brew`
- Monitor terminal output and make changes as needed

## 📋 Project Structure

```
project-root/
├── SPEC.md                 # Project specification
├── .cursorrules           # This file
├── README.md              # Project overview
├── docs/                  # Static documentation (optional)
├── memories/              # AI knowledge base
└── src/                   # Source code
```

## 🎯 Quality Gates

- [ ] Code compiles without errors
- [ ] All tests pass
- [ ] Memory system updated with learnings
- [ ] Documentation updated

---

# AI-Assisted Development Best Practices

_Based on [Addy Osmani's Beyond Vibe Coding](https://beyond.addy.ie/) and [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)_

## 🎯 Core Principles

### 1. Context is Everything

- **Always provide relevant context** before asking for code
- Include relevant files, schemas, error messages, and constraints
- Quality of AI output = Quality of context provided

### 2. Plan First, Code Second

- **Never code first - always plan first**
- Request architecture options before implementation
- Ask for simplified approaches (9/10 times AI suggests complexity)
- Use Plan Mode or SPEC.md before coding

### 3. The Three Pillars of Trust

- **Familiarity**: Build mental models through consistent tool usage
- **Trust**: Earned through reliable delivery over time
- **Control**: Vary based on trust level and task complexity

## 🚀 Development Workflow

### Before Starting Any Feature

```
❌ Bad: "Build me a todo app"
✅ Good: "Give me a few options for a todo app architecture, starting with the simplest first. Don't code yet - just outline the approach and ask me which direction to take."
🚀 Best: Create a mini-PRD or SPEC.md first
```

### Essential Pre-Coding Checklist

- [ ] Define the problem clearly
- [ ] Outline user journey and desired outcomes
- [ ] Specify technical constraints and requirements
- [ ] Check knowledge cutoff for frameworks/APIs
- [ ] Include relevant documentation in context
- [ ] Set global coding rules and standards

## 🛠️ Code Quality Standards

### Global Rules for AI

```
Always follow these guidelines:
1. Define the data model before writing code
2. Start with mock data instead of database
3. Create component library and split code into multiple files
4. Centralize state management
5. Batch implementation into smaller chunks
6. Double-check you're changing the correct files
7. Ask follow-up questions if requirements are unclear
8. Include comprehensive error handling
9. Add input validation and sanitization
10. Consider security implications
```

### Testing Requirements

- **Test ruthlessly after every change**
- Open browser console (Cmd+Option+J) to check for errors
- Small, incremental testing prevents nightmare debugging
- Generate unit tests for every AI-generated function
- Include integration tests for components
- Validate security controls and input handling

## 🔍 Debugging Best Practices

### Error-Driven Context

```
❌ Bad: "The button doesn't work"
✅ Good: "I want the Save button to store the form data and then redirect to the dashboard page. Currently it's not saving and shows this error: [paste error]"
```

### Include Full Context

- Paste complete error messages with stack traces
- Include relevant code files
- Provide API response examples
- Show expected vs actual behavior

## 🎨 Visual Context Guidelines

### When to Include Visuals

- Creating designs or fixing UI bugs
- Import Figma designs directly when possible
- Attach mocks, screenshots, or designs to prompts
- Use browser screenshots for real-time context

## 🔒 Security & Production Readiness

### Security Checklist

- [ ] Input validation and sanitization
- [ ] Authentication and authorization
- [ ] SQL injection prevention
- [ ] XSS protection
- [ ] Sensitive data handling
- [ ] API key and credential management
- [ ] HTTPS and secure communications

### Production Code Review

- Treat AI-generated code like junior developer code
- Check for security vulnerabilities
- Verify error handling
- Validate performance implications
- Ensure maintainability standards
- Review test coverage and quality

## 🚀 Advanced Techniques

### Prompt Engineering

- **Be specific**: "Generate a React component that handles user authentication with JWT tokens, includes loading states, and follows our existing design system"
- **Provide examples**: Include sample data, expected outputs, and similar implementations
- **Iterate**: Start broad, then narrow down based on results

### Context Management

- Keep relevant files open in Cursor
- Use @-mentions to reference specific files
- Include error messages and logs in context
- Provide constraints and requirements explicitly

## 🎯 Success Metrics

### Continuous Improvement

- Review AI suggestions critically
- Learn from debugging sessions
- Update rules based on project needs
- Share learnings with team
- Stay current with AI tool capabilities

---

_Remember: AI-assisted development is a spectrum. Start with vibe coding for rapid prototyping, then apply engineering rigor for production systems._
