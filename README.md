# Ralph

The **Real** Ralph Loop for Claude Code - spawning fresh sessions for peak AI performance.

## What is Ralph?

Ralph is a bash script that implements the true Ralph loop technique: iterating on tasks with **fresh context windows** to avoid the dreaded "context rot" that degrades AI performance.

### The Key Insight

The built-in `ralph-wiggum` plugin in Claude Code just blocks exit and continues in the same session. This means context keeps growing until it hits ~150k tokens and auto-compacts.

**The real power of Ralph isn't repetition - it's fresh context.**

Studies show LLM performance degrades significantly after ~100k tokens. By spawning a **new Claude Code session** for each iteration, ralph keeps the AI operating at peak capacity.

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/dominiquegarmier/ralph/main/install.sh | bash
```

### Prerequisites

```bash
# JSON processor
brew install jq

# Claude Code CLI
npm i -g @anthropic-ai/claude-code

# Beads task tracker
npm i -g @beads/bd
```

## Quick Start

```bash
# Initialize ralph in your project
cd your-project
ralph --init

# Create some tasks
bd create "Set up project structure" -p 0
bd create "Implement core feature" -p 1
bd create "Add tests" -p 2

# Run the ralph loop
ralph
```

Or use the `/prd` skill in Claude Code to generate tasks from an idea:

```
/prd I want to build a kanban board for content creators
```

## Usage

```
ralph [OPTIONS]

Options:
  -t, --task <id>      Target specific beads task (default: first ready)
  -m, --max <n>        Maximum iterations (default: 10)
  -p, --prompt <file>  Custom prompt template
  --init               Initialize ralph in current project
  --no-stealth         Commit beads to repo (default: stealth)
  -h, --help           Show this help

Examples:
  ralph                      # Run on first ready task
  ralph -t bd-a3f8           # Target specific task
  ralph -m 20                # Run up to 20 iterations
  ralph --init               # Initialize project
```

## How It Works

```
┌─────────────────────────────────────────────────────────────────┐
│ 1. You have an idea                                             │
│    → Use /prd skill or bd create to make tasks                  │
├─────────────────────────────────────────────────────────────────┤
│ 2. Run: ralph                                                   │
├─────────────────────────────────────────────────────────────────┤
│ 3. Ralph Loop (for each iteration):                             │
│    a. Spawn FRESH Claude Code session                           │
│    b. Load task from beads + learnings from progress.md         │
│    c. Claude attempts to complete the task                      │
│    d. On success: mark done, move to next task                  │
│    e. On failure: log learnings, retry with fresh context       │
└─────────────────────────────────────────────────────────────────┘
```

### Why Beads?

[Beads](https://github.com/steveyegge/beads) is a distributed, git-backed issue tracker designed for AI agents:

- **Hash-based IDs** (`bd-a1b2`) - no merge conflicts
- **Hierarchical tasks** - Epic → Task → Subtask
- **Dependency tracking** - `bd ready` shows unblocked tasks
- **Stealth mode** - local-only tracking without repo commits

## Configuration

Edit `~/.config/ralph/config`:

```bash
# Maximum iterations per ralph run
MAX_ITERATIONS=10

# Path to prompt template
PROMPT_TEMPLATE="$HOME/.config/ralph/prompt.md"

# Use beads stealth mode (local only, no commits)
BEADS_STEALTH=true
```

## Files

| File | Purpose |
|------|---------|
| `ralph` | Main bash script |
| `progress.md` | Append-only log of iteration learnings |
| `.beads/` | Beads task storage (in stealth mode) |
| `AGENTS.md` | Codebase patterns for future iterations |

## The Completion Signal

When a task is complete, the agent writes `<promise>COMPLETE</promise>` to progress.md. This signals ralph to:

1. Mark the task done in beads
2. Move to the next ready task
3. Start a fresh session

If the signal isn't found, ralph assumes the task needs more work and retries with fresh context.

## Comparison: Ralph vs Ralph-Wiggum Plugin

| Feature | Ralph (this) | Ralph-Wiggum Plugin |
|---------|--------------|---------------------|
| Fresh sessions | Yes | No |
| Context management | Stays under 100k | Grows to 150k |
| Task tracking | Beads | PRD.md checkboxes |
| Progress persistence | progress.md | Limited |
| Dependency tracking | Yes | No |

## Credits

Inspired by:
- [ghuntley.com/ralph](https://ghuntley.com/ralph/) - The original Ralph technique
- [snarktank/ralph](https://github.com/snarktank/ralph) - Reference implementation
- [steveyegge/beads](https://github.com/steveyegge/beads) - Task management for AI agents

## License

MIT
