# 🛸 Mothership Full

**4 specialized agents. ~550 lines total.**

```
plan → build → test → review → ship
```

---

## Agents

| Agent | Lines | Purpose |
|-------|-------|---------|
| **Oracle** | 120 | Read docs → create Linear stories |
| **Drone** | 109 | Implement ONE story → commit |
| **Probe** | 103 | Write tests for completed story |
| **Overseer** | 96 | Review code → approve or reject |

**Optional extras** in `/agents/extras/`:
- Beacon (deploy), Hivemind (prioritize), Watcher (monitor), Scribe (docs), Recycler (cleanup)

---

## Quick Start

```bash
# Install
cd your-project
cp -r /path/to/mothership/full/.mothership .

# Configure
edit .mothership/config.json  # Set linear_team

# Onboard
"Read .mothership/mothership.md and run: onboard"

# Build a feature
"Read .mothership/mothership.md and run: plan user authentication"
"Read .mothership/mothership.md and run: build"   # repeat
"Read .mothership/mothership.md and run: test"    # repeat
"Read .mothership/mothership.md and run: review"
```

---

## Commands

| Command | Agent | Action |
|---------|-------|--------|
| `plan [feature]` | Oracle | Creates Linear stories |
| `build` | Drone | Implements one story |
| `test` | Probe | Tests one story |
| `review` | Overseer | Reviews branch |
| `status` | - | Shows state |
| `reset` | - | Clears checkpoint |

---

## Signals

```
<oracle>PLANNED:12</oracle>     # Created 12 stories
<drone>BUILT:ENG-42</drone>     # Implemented story
<drone>COMPLETE</drone>         # No more stories
<probe>TESTED:ENG-42</probe>    # Tested story
<probe>COMPLETE</probe>         # All tested
<overseer>APPROVED</overseer>   # Ready to merge
<overseer>NEEDS-WORK</overseer> # Fixes required
```

---

## Files

```
.mothership/
├── mothership.md      # Orchestrator (119 lines)
├── config.json        # Settings
├── checkpoint.md      # State (4 lines)
├── codebase.md        # Patterns (generated)
└── agents/
    ├── oracle.md      # Planner
    ├── drone.md       # Builder
    ├── probe.md       # Tester
    ├── overseer.md    # Reviewer
    └── extras/        # Optional agents
```

---

## When to Use Full vs Lite

| Use Full | Use Lite |
|----------|----------|
| Want specialized agents | Want simplicity |
| Team projects | Solo projects |
| Complex workflows | Quick iterations |
| Need extras (deploy, monitor) | Just plan/build/test/review |
