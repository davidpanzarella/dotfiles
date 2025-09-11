# Project Structure Analysis: memories/ vs docs/notes/

## 🎯 Recommendation: Use `memories/` (Current Choice)

### Why `memories/` is Optimal

#### 1. **AI-First Design**

- **Purpose-built for AI agents** - The folder name signals to AI that this contains structured, searchable knowledge
- **YAML frontmatter integration** - Designed for AI discoverability and categorization
- **Semantic routing** - Clear rules for where different types of content go

#### 2. **Distinguishes from Traditional Docs**

- **`docs/`** = Static documentation (API docs, user guides, setup instructions)
- **`memories/`** = Dynamic knowledge base (learnings, decisions, conversations, plans)
- **Clear separation of concerns** - Prevents mixing static docs with evolving knowledge

#### 3. **Tool Integration**

- **`basic-memory` CLI** expects `memories/` structure
- **Foam integration** works seamlessly with the established pattern
- **Cursor MCP** configured for this specific structure

#### 4. **Scalability**

- **Grows organically** with project complexity
- **Self-organizing** through routing rules
- **Version controlled** alongside code

## 📁 Recommended Project Structure

```
project-root/
├── .cursorrules                    # Cursor AI rules (this file)
├── SPEC.md                        # Project specification
├── README.md                      # Project overview
├── docs/                          # Static documentation
│   ├── api.md                     # API documentation
│   ├── deployment.md              # Deployment guide
│   ├── contributing.md            # Contribution guidelines
│   └── architecture.md            # System architecture
├── memories/                      # AI knowledge base
│   ├── _index.md                  # Memory system guide
│   ├── knowledge/                 # Facts, learnings, domain knowledge
│   │   ├── glossary.md           # Terms and definitions
│   │   └── domain-notes/         # Domain-specific knowledge
│   ├── plans/                     # Planning and specifications
│   │   ├── intent.md             # Project goals and objectives
│   │   ├── roadmap.md            # Milestones and timeline
│   │   └── specs/                # Technical specifications
│   ├── issues/                    # Problems, bugs, questions
│   ├── decisions/                 # Architecture Decision Records (ADRs)
│   ├── tasks/                     # Task management
│   │   └── next.md               # Current sprint tasks
│   ├── journal/                   # Daily notes and conversations
│   │   └── conversations/        # AI conversation exports
│   ├── snippets/                  # Code snippets and examples
│   ├── inbox/                     # Uncategorized items
│   └── notes/                     # Daily notes (Foam integration)
├── src/                           # Source code
├── tests/                         # Test files
└── .vscode/                       # VS Code/Cursor settings
    └── settings.json              # Foam configuration
```

## 🔄 Content Routing Rules

### Static Documentation (`docs/`)

- **API documentation** - Endpoint specs, schemas
- **User guides** - How to use the application
- **Setup instructions** - Installation, configuration
- **Architecture diagrams** - System design visuals
- **Contributing guidelines** - Development workflow

### Dynamic Knowledge (`memories/`)

- **Facts & learnings** → `knowledge/`
- **Plans & specs** → `plans/`
- **Problems & questions** → `issues/`
- **Architectural decisions** → `decisions/`
- **Task management** → `tasks/`
- **Daily summaries** → `journal/`
- **AI conversations** → `journal/conversations/`
- **Code snippets** → `snippets/`
- **Uncategorized** → `inbox/` (with route-to hints)

## 🎯 Benefits of This Structure

### For Developers

- **Clear mental model** - Know where to put different types of information
- **Easy navigation** - Logical folder structure
- **Tool integration** - Works with existing memory system

### For AI Agents

- **Semantic understanding** - Folder names indicate content type
- **Structured search** - Can search within specific knowledge domains
- **Context awareness** - Understands project evolution through memories

### For Project Evolution

- **Knowledge preservation** - Important decisions and learnings are captured
- **Onboarding** - New team members can understand project history
- **Decision tracking** - ADRs provide context for architectural choices

## 🚀 Implementation Strategy

### For New Projects

1. **Run `setup-project`** - Creates full structure with seed files
2. **Add SPEC.md** - Define project goals and constraints
3. **Configure Cursor** - Include `.cursorrules` for AI guidance
4. **Start documenting** - Use memory system from day one

### For Existing Projects

1. **Gradual migration** - Move existing docs to appropriate folders
2. **Preserve history** - Keep important decisions in `memories/decisions/`
3. **Update workflows** - Train team on new structure
4. **Tool integration** - Set up memory system and Foam

## 📊 Comparison: memories/ vs docs/notes/

| Aspect                 | `memories/`         | `docs/notes/`          |
| ---------------------- | ------------------- | ---------------------- |
| **AI Integration**     | ✅ Purpose-built    | ❌ Generic             |
| **Tool Support**       | ✅ Full integration | ❌ Limited             |
| **Semantic Structure** | ✅ Clear routing    | ❌ Ambiguous           |
| **Scalability**        | ✅ Self-organizing  | ❌ Manual organization |
| **Team Adoption**      | ✅ Clear purpose    | ❌ Unclear distinction |
| **Version Control**    | ✅ Structured       | ❌ Mixed content       |

## 🎯 Conclusion

**Stick with `memories/`** - It's purpose-built for AI-assisted development and provides clear separation between static documentation and dynamic knowledge management. The structure scales well and integrates seamlessly with our existing tools and workflows.
