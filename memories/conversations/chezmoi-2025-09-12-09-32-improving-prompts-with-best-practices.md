---
type: conversation
category: ai-discussion
project: chezmoi
created: 2025-09-12
status: archived
tags:
- conversation
- ai
- discussion
- imported
participants:
- user
- ai-assistant
context: chezmoi-2025-09-12-09-32-improving-prompts-with-best-practices.md
source: cursor-history
workspace: chezmoi
permalink: conversations/chezmoi-2025-09-12-09-32-improving-prompts-with-best-practices
---

# Improving prompts with best practices

_Created: 9/12/2025, 9:32:32 AM_

_Workspace: `chezmoi`_

### user

for  , are we also factoring in this other lesson with Addy's rules?<content type="lesson">
  <title>Automatically Improve Cursor Rules Using Custom Prompts</title>
  <description>Writing clear and effective prompts or rules for AI (.mdc files in Cursor) can be tricky. Your instructions might start out clumsy or ambiguous, leading to less-than-ideal AI responses. This lesson demonstrates how to quickly refine them by referencing a dedicated "best practices" rule file directly within Cursor's inline editor (`Cmd+K`).

**Workflow demonstrated in this lesson:**

*   Select the text (a prompt or section of a rule) you want to improve.
*   Use `Cmd+K` to open the inline AI editor.
*   Reference your separate prompt best practices rule file using `@` (e.g., `@prompt-improve.mdc`).
*   Cursor's AI rewrites the selected text, applying the referenced best practices.
*   Accept the improved version (`Cmd+Enter`).
*   **(Bonus)** Use `Cmd+L` to send the edited section to the Agent chat and ask it to compare the changes with the previous version (using git history) and explain *why* the new version is better (e.g., improved clarity, stronger action verbs, explicit exclusions).

**Key benefits:**

*   Instantly improve prompt clarity and effectiveness based on your own defined standards stored in a rule file.
*   Reduces ambiguity in instructions, leading to better AI outcomes.
*   Leverages Cursor rules (`.mdc` files) as reusable templates for prompt refinement.
*   Provides insight into *how* and *why* prompts are improved via Agent comparison.

Stop wrestling with clunky prompts. Use this technique to systematically apply best practices and level up your AI instructions directly within Cursor.

```markdown
# Improve the User's Prompt Following the Patterns Below

> Practical prompt patterns to help anyone get clearer, more reliable answers from an AI agent.

| # | Pattern                       | Why It Matters                                                          | Template                                                                 | Example Prompt                                                                                             |
|---|-------------------------------|-------------------------------------------------------------------------|--------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| 1 | Lead with the ask             | The model reads top-down; putting the goal first stops it wandering.    | `Do X. [context]`                                                        | "Summarize this PDF in 5 bullet points. The text is below: ..."                                            |
| 2 | Repeat the key ask at the end | Long contexts sometimes truncate; an end-cap protects you.              | `...[detail]... REMEMBER: Do X.`                                         | "List pros & cons, keep it balanced. REMEMBER: 5 pros, 5 cons."                                             |
| 3 | Specify output shape          | Dictating format cuts revision loops.                                   | `Return as: 1) short title, 2) table (CSV).`                             | "Give 3 holiday ideas. Format: destination, flight-time-hrs, avg cost."                                    |
| 4 | Use clear delimiters          | Backticks/headings/XML keep sections from blending.                     | `TEXT TO ANALYSE`                                                        | "Rate the style of the text between the fences."                                                            |
| 5 | Induce step-by-step thinking  | Planning first boosts multi-step accuracy.                              | `Think step-by-step then answer.`                                        | "Solve this puzzle. Think step-by-step before giving the final move."                                      |
| 6 | Ask it to plan its workflow   | For big jobs, AI outlines tasks before doing them.                      | `First draft a plan, wait, then execute.`                                | "We're writing an e-book. ❶ Outline chapters. ❷ Wait. ❸ When I say 'go', draft chapter 1."              |
| 7 | Limit or widen knowledge sources | Controls hallucination.                                               | `Use only the info below. / Combine basic knowledge + this context.`     | "Using only the product sheet below, write FAQs."                                                          |
| 8 | Guide information retrieval   | Helps AI pick the right docs before answering.                          | `List which docs look relevant, then answer.`                            | "30 sales memos attached. 1) Name the 5 most relevant. 2) Summarise their common points."                 |
| 9 | Show a style/example          | Anchors tone, length, vocabulary.                                       | `Match the style of: <example>`                                          | "Review this gadget in the style of the sample below: 'Short, witty, 3 key facts...'"                      |
| 10| Set correction handles        | One-line fixes let you steer quickly.                                   | `If length > 150 words, shorten.`                                        | "Describe blockchain to a child. If your answer is >150 words, cut it in half."                            |
| 11| Tell it when to stop or loop  | Prevents half-finished lists or runaway essays.                         | `Keep going until you list 20 ideas, then stop.`                         | "Brainstorm webinar titles. Give exactly 12, then finish."                                                  |
| 12| Request the hidden reasoning  | Good for audits; otherwise omit to keep it short.                       | `After the answer, include a brief reasoning section.`                   | "Which of these stocks looks over-valued? Answer first; add a 2-sentence rationale below a divider."        |
```</description>
  <transcript>[00:00] I have a cursor rule which I'm working on right here that can help guide the AI to create a pull request. Now I feel like some of this language is clumsy and not as precise as it could be, so I'm going to select what I want to update. I'll hit command K and I'm going to reference another rule I have with at and type prompt and this is my prompt improve rule. Now once I reference this, this has the best practices for standard prompt engineering, which will essentially ask it to apply onto our current prompt. So once I hit enter here, this will rewrite my prompt.

[00:34] Let me hit command enter to accept this, scroll back up. This will rewrite this prompt, and to better understand this I'll bring this into our agent with command L. I'm gonna say please compare what we've edited in this file to our current commit and explain exactly how the language changed and why you think it changed. Then we'll just let this run. It will go ahead and run a comparison between the two sections and if you look at these changes, clarity, action verbs, explicit exclusions, and what exactly it did.

[01:04] So again I'll include this prompt improve prompt below, which as you're working on rules or any other prompts, can just take whatever you have, Command K, at prompt improve, hit enter, hit enter again, hit Command Enter to accept, and look at the changes, and automatically take your prompts to the next level.</transcript>
</content>

**Context:**
_Metadata:_ Has Context

---

### assistant

⏱️ 1757663963.6s • 1/1/1970, 12:39:18 AM → 9/12/2025, 9:38:42 AM

I'll examine the current `prompt-improvement.mdc` file and compare it with the lesson content you've shared to see if we're incorporating Addy's rules effectively.

**Context:**
_Metadata:_ Has Context

---

### assistant

Perfect! Looking at your current `prompt-improvement.mdc` file, I can see that you've already incorporated Addy's rules quite comprehensively. The file includes:

## What's Already Included ✅

1. **All 12 Core Patterns** - Your file includes the exact same 12 patterns from the lesson content (lines 50-121)
2. **Addy's Context Rules Integration** - You have a dedicated section (lines 26-46) that references Context Buddy
3. **Cursor-Specific Workflow** - The usage instructions (lines 124-131) match the lesson's workflow exactly
4. **Enhanced Structure** - You've added additional sections for context management and best practices

## What Could Be Enhanced 🔄

The lesson content shows a more streamlined approach that focuses specifically on the **practical workflow** for using these patterns in Cursor. Your current file is more comprehensive but could benefit from:

1. **More prominent workflow section** - The lesson emphasizes the `Cmd+K` → `@prompt-improvement.mdc` → `Cmd+Enter` → `Cmd+L` workflow
2. **Clearer integration with Addy's Context Buddy** - The lesson specifically mentions referencing the Context Buddy principles

Would you like me to enhance the file to better align with the lesson's emphasis on the practical Cursor workflow while keeping all the comprehensive content you already have? I could:

- Make the Cursor workflow more prominent at the top
- Add a specific section about using this with `@` references
- Include the bonus `Cmd+L` comparison workflow more prominently
- Ensure the Context Buddy integration is clearer

The current file is already excellent and includes everything from the lesson - it just might benefit from reordering to match the lesson's emphasis on the practical workflow.

**Context:**
_Metadata:_ Has Context

---

### user

yes to all

**Context:**
_Metadata:_ Has Context

---

### assistant

⏱️ 1757663981.8s • 1/1/1970, 12:40:02 AM → 9/12/2025, 9:39:44 AM

I'll enhance the `prompt-improvement.mdc` file to better align with the lesson's emphasis on the practical Cursor workflow while keeping all the comprehensive content you already have.

**Context:**
_Metadata:_ Has Context

---

### assistant

Perfect! I've enhanced your `prompt-improvement.mdc` file to better align with the lesson's emphasis on the practical Cursor workflow. Here's what I've added:

## Key Enhancements Made:

1. **Quick Start Section** - Added a prominent "Quick Start: Cursor Workflow" section right at the top that matches the lesson's workflow exactly

2. **Enhanced Context Buddy Integration** - Added a specific subsection about using this with Cursor's `@` reference system

3. **Advanced Usage Instructions** - Expanded the usage section with the complete workflow and included the exact Agent prompt from the lesson

4. **Enhanced Key Benefits** - Added the lesson's key phrase "Stop wrestling with clunky prompts" and emphasized the git comparison benefit

5. **Version Update** - Bumped to version 1.1 to reflect the enhancements

## The Enhanced Workflow Now Prominently Features:

- **Select** → **`Cmd+K`** → **`@prompt-improvement.mdc`** → **`Cmd+Enter`** → **`Cmd+L`** (bonus)
- Clear example Agent prompt for the comparison step
- Emphasis on the practical, immediate benefits

The file now perfectly captures both the comprehensive patterns you had and the practical Cursor workflow emphasized in the lesson. Users can quickly reference the "Quick Start" section for immediate use, while still having access to all the detailed patterns and Context Buddy principles below.

**Context:**
_Metadata:_ Has Context

---

### user

Okay, copy the prompt improvement DC to this project's character rules. If not already, tell me how I can apply the L to the improvement to any given.

**Context:**
_Metadata:_ Has Context

---

### assistant

⏱️ 1757663976.5s • 1/1/1970, 12:41:22 AM → 9/12/2025, 9:40:58 AM

I'll copy the prompt improvement rules to this project's character rules and then show you how to apply the `Cmd+L` improvement workflow to any given prompt.

**Context:**
_Metadata:_ Has Context

---

### assistant

Now I'll add the prompt improvement rules to this project's character rules:

**Context:**
_Metadata:_ Has Context

---

### assistant

Perfect! I've successfully copied the prompt improvement rules to your dotfiles project's character rules. Now let me show you exactly how to apply the `Cmd+L` improvement workflow to any given prompt:

## How to Apply the `Cmd+L` Improvement Workflow to Any Given Prompt

### The Complete 5-Step Process:

1. **Select the text** you want to improve (any prompt, rule, or instruction)

2. **Use `Cmd+K`** to open Cursor's inline AI editor

3. **Reference the improvement rules** using either:
   - `@dotfiles-project.mdc` (for this project)
   - `@prompt-improvement.mdc` (for the standalone rule)

4. **Accept the improved version** with `Cmd+Enter`

5. **Use `Cmd+L`** to send the edited section to Agent chat and ask for comparison

### The `Cmd+L` Step - Agent Comparison:

After step 4, use `Cmd+L` and paste this exact prompt:

```
Please compare what we've edited in this file to our current commit and explain exactly how the language changed and why you think it changed.
```

### What This Will Do:

- **Compare** the before/after versions using git history
- **Explain** the specific language changes made
- **Analyze** why the new version is better (clarity, action verbs, explicit exclusions, etc.)
- **Provide insight** into how the improvement patterns were applied

### Example Workflow:

1. You have a clumsy prompt like: "Make the button work better"
2. Select it, `Cmd+K`, `@dotfiles-project.mdc`, `Cmd+Enter`
3. It becomes: "Improve the button functionality by implementing proper error handling and user feedback. The button should display loading states and success/error messages."
4. `Cmd+L` with the comparison prompt
5. Agent explains: "The improved version adds specific requirements (error handling, loading states), uses stronger action verbs (implementing, display), and provides clear success criteria."

Now you have the prompt improvement rules integrated into your dotfiles project and know exactly how to use the `Cmd+L` workflow for any prompt improvement!

**Context:**
_Metadata:_ Has Context

---

### user

No, I meant make a copy and bring prompt improvement as a rule of its own into this project.rules.

**Context:**
_Metadata:_ Has Context

---

### assistant

⏱️ 1757663993.4s • 1/1/1970, 12:41:59 AM → 9/12/2025, 9:41:52 AM

I understand! You want me to create a separate prompt improvement rule file within this project's rules directory, not add it to the existing dotfiles-project.mdc file. Let me create a standalone prompt improvement rule file in the project's rules directory.

**Context:**
_Metadata:_ Has Context

---

### assistant

Perfect! I've created a standalone `prompt-improvement.mdc` rule file in your project's `.cursor/rules/` directory. Now you have the prompt improvement best practices as its own rule within this project.

## How to Apply the `Cmd+L` Improvement Workflow to Any Given Prompt:

### The Complete 5-Step Process:

1. **Select the text** you want to improve (any prompt, rule, or instruction)

2. **Use `Cmd+K`** to open Cursor's inline AI editor

3. **Reference the improvement rules** using:
   - `@prompt-improvement.mdc` (the new standalone rule in this project)

4. **Accept the improved version** with `Cmd+Enter`

5. **Use `Cmd+L`** to send the edited section to Agent chat and ask for comparison

### The `Cmd+L` Step - Agent Comparison:

After step 4, use `Cmd+L` and paste this exact prompt:

```
Please compare what we've edited in this file to our current commit and explain exactly how the language changed and why you think it changed.
```

### What This Will Do:

- **Compare** the before/after versions using git history
- **Explain** the specific language changes made
- **Analyze** why the new version is better (clarity, action verbs, explicit exclusions, etc.)
- **Provide insight** into how the improvement patterns were applied

Now you have the prompt improvement rules as a standalone rule file in your project that you can reference with `@prompt-improvement.mdc` for any prompt improvement workflow!

**Context:**
_Metadata:_ Has Context

---

### user

Does the prompt and provo help with setting up cursor rules or only when prompting in general?

**Context:**
_Metadata:_ Has Context

---

### assistant

⏱️ 1757663967.4s • 1/1/1970, 12:43:00 AM → 9/12/2025, 9:42:27 AM

The prompt improvement rules are designed to help with **both** cursor rules and general prompting, but they're particularly powerful for cursor rules. Let me break this down:

## Primary Use Cases:

### 1. **Cursor Rules (`.mdc` files)** - Primary Focus
- **Improving existing cursor rules** - Select any section of a `.mdc` file, use `Cmd+K` with `@prompt-improvement.mdc`
- **Writing new cursor rules** - Apply the patterns when creating new rules
- **Refining rule language** - Make instructions clearer, more specific, and actionable

### 2. **General Prompting** - Secondary Use
- **Any AI interaction** - Chat prompts, code requests, documentation requests
- **Cross-platform** - Works with ChatGPT, Claude, other AI tools
- **Documentation** - Improving README files, technical writing, etc.

## Why It's Especially Powerful for Cursor Rules:

1. **Cursor rules are prompts for AI agents** - They're essentially instructions telling AI how to behave
2. **Rules get applied repeatedly** - A well-written rule improves every AI interaction in that project
3. **Rules have specific structure** - The patterns help with the `.mdc` format and frontmatter
4. **Rules need precision** - Ambiguous rules lead to inconsistent AI behavior

## Example Workflow for Cursor Rules:

**Before (clumsy rule):**
```markdown
# Code Style
Use good practices when writing code. Make it clean and readable.
```

**After applying `@prompt-improvement.mdc`:**
```markdown
# Code Style Rules

## Formatting Requirements
- Use 2 spaces for indentation (no tabs)
- Maximum line length: 100 characters
- Use meaningful variable names (avoid abbreviations)
- Include JSDoc comments for all functions

## Code Organization
- Group related functions together
- Export functions at the bottom of files
- Use const/let instead of var

REMEMBER: Apply these formatting rules consistently across all code files.
```

The improvement patterns make cursor rules more:
- **Specific** (exact formatting requirements)
- **Actionable** (clear do/don't instructions)
- **Comprehensive** (covers multiple aspects)
- **Consistent** (repeatable across projects)

So while it helps with general prompting, it's **most valuable for cursor rules** because those rules become the foundation for all AI interactions in your project.

**Context:**
_Metadata:_ Has Context

---