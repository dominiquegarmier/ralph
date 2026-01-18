---
description: Generate tasks for Ralph loop from a project idea
allowed-tools: Bash, Read, Write, Edit
---

# PRD Generation for Ralph

You are creating structured tasks for the Ralph loop using Beads.

## Process

### Step 1: Gather Requirements

Ask the user clarifying questions to understand the project:
- What is the core problem being solved?
- Who are the target users?
- What are the must-have features?
- What are nice-to-have features?
- Any technical constraints or preferences?
- What tech stack should be used?

### Step 2: Design Task Hierarchy

Break down the project into tasks that can each be completed in one context window (~100k tokens of work).

**Good task sizes**:
- "Set up project structure and dependencies"
- "Add user authentication endpoint"
- "Create React component for task list"
- "Set up database schema for users"
- "Add form validation to signup"
- "Write tests for auth module"

**Too large** (break these down):
- "Build entire authentication system"
- "Create the frontend"
- "Implement all API endpoints"

### Step 3: Create Tasks in Beads

First, ensure beads is initialized:
```bash
bd init --stealth 2>/dev/null || true
```

Create an epic (parent task) for the project:
```bash
EPIC_ID=$(bd create "Epic: <Project Name>" -p 0 --json | jq -r '.id')
echo "Created epic: $EPIC_ID"
```

For each user story/task, create it and link to the epic:
```bash
TASK_ID=$(bd create "<Task Title>" -p <priority> --json | jq -r '.id')
bd dep add "$TASK_ID" "$EPIC_ID"
echo "Created task: $TASK_ID - <Task Title>"
```

Priority should be:
- 0 = Critical path, do first
- 1 = Important
- 2 = Nice to have

### Step 4: Output Summary

After creating all tasks, output:

```
════════════════════════════════════════════════════════════════
Ralph PRD Setup Complete!
════════════════════════════════════════════════════════════════

Epic Task ID: <epic-id>
Total Tasks: <count>

Tasks created:
  1. <task-id> - <title> (priority: N)
  2. <task-id> - <title> (priority: N)
  ...

To start development:
  ralph

To target a specific task:
  ralph -t <task-id>

View all tasks:
  bd list

View ready tasks (unblocked):
  bd ready
════════════════════════════════════════════════════════════════
```

## Example Session

User: "I want to build a kanban board for content creators"

You would:
1. Ask clarifying questions about features, tech stack, etc.
2. Design task breakdown:
   - Task 1: Project initialization and basic structure
   - Task 2: Create board data model and storage
   - Task 3: Implement column management (add, remove, rename)
   - Task 4: Implement card CRUD operations
   - Task 5: Add drag-and-drop between columns
   - Task 6: Add card details modal
   - Task 7: Add styling and polish
   - Task 8: Write tests
3. Create beads tasks with proper priorities
4. Output the summary for ralph targeting

## Important Notes

- Tasks should be independent enough to complete in one iteration
- Order by priority - ralph will pick up the first ready task
- Dependencies help ensure proper ordering
- The user can always adjust tasks with `bd` commands later
