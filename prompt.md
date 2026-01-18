Read progress.md to understand previous iteration learnings.
Read AGENTS.md (if exists) for codebase patterns and conventions.

## Your Workflow

1. **Understand the task**
   - The task ID, title, and description are provided above
   - Run `bd show <task-id>` for full details if needed
   - Check for any dependencies: `bd deps <task-id>`

2. **Check what's been tried**
   - Review progress.md for previous attempts on this task
   - Look for patterns, errors, and learnings from past iterations
   - Don't repeat approaches that already failed

3. **Implement the solution**
   - Focus on one task at a time
   - Write clean, tested code
   - Follow existing patterns in the codebase

4. **Verify with tests**
   - Run relevant tests to verify your changes
   - Ensure no regressions

5. **On SUCCESS**:
   - Commit your changes with a clear, descriptive message
   - Append learnings to progress.md (NEVER replace, only append)
   - Update beads: `bd update <task-id> --status done`
   - Write `<promise>COMPLETE</promise>` at end of progress.md

6. **On FAILURE**:
   - Append to progress.md: what you tried, errors encountered, potential solutions
   - Do NOT write the completion signal
   - Exit cleanly (next iteration will have fresh context to try again)

## Critical Rules

- **APPEND ONLY** to progress.md - previous iterations' knowledge is valuable
- **One task per iteration** - complete fully or document failure
- **Update AGENTS.md** with reusable patterns you discover
- **Signal completion** with `<promise>COMPLETE</promise>` ONLY when task is truly done
- **Fresh context is your superpower** - each iteration starts clean

## Progress.md Format

When appending to progress.md, use this structure:

```markdown
---

### Iteration N - YYYY-MM-DD

**Task**: <task-id> - <title>

**What was done**:
- Step 1...
- Step 2...

**Learnings**:
- Pattern discovered...
- Gotcha to remember...

**Status**: COMPLETE | FAILED - <reason>

<promise>COMPLETE</promise>  <!-- Only if truly complete -->
```

## Why Fresh Context Matters

This ralph loop spawns a NEW Claude Code session for each iteration.
This avoids "context rot" - the degradation in AI quality that happens
as the context window fills up (typically after ~100k tokens).

Each iteration you get:
- Full "smart" capacity (not degraded by previous context)
- Clean slate to try new approaches
- Learnings from progress.md without the noise

This is the key insight the built-in ralph-wiggum plugin misses.
