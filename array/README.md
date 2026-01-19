# 🛸 Mothership Array

**4 specialized agents. ~550 lines total.**

> *An organized collection. Teams working together.*

```
plan → build → test → review → ship
```

---

## Agents

| Agent | Lines | Purpose |
|-------|-------|---------|
| **Cipher** | 37 | Read docs → create Linear stories |
| **Vector** | 31 | Implement ONE story → commit |
| **Cortex** | 30 | Write tests for completed story |
| **Sentinel** | 30 | Review code → approve or reject |

**Optional extras** in `/agents/extras/`:
- Pulse (deploy), Nexus (prioritize), Vigil (monitor), Archive (docs), Purge (cleanup)

---

## Quick Start

```bash
# Install
cd your-project
cp -r /path/to/mothership/array/ .mothership/

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
| `plan [feature]` | Cipher | Creates Linear stories |
| `build` | Vector | Implements one story |
| `test` | Cortex | Tests one story |
| `review` | Sentinel | Reviews branch |
| `status` | - | Shows state |
| `reset` | - | Clears checkpoint |

---

## Signals

```
<cipher>PLANNED:12</cipher>     # Created 12 stories
<vector>BUILT:ENG-42</vector>   # Implemented story
<vector>COMPLETE</vector>       # No more stories
<cortex>TESTED:ENG-42</cortex>  # Tested story
<cortex>COMPLETE</cortex>       # All tested
<sentinel>APPROVED</sentinel>   # Ready to merge
<sentinel>NEEDS-WORK</sentinel> # Fixes required
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
    ├── cipher.md      # Planner
    ├── vector.md      # Builder
    ├── cortex.md      # Tester
    ├── sentinel.md    # Reviewer
    └── extras/        # Optional agents
        ├── pulse.md   # Deployment
        ├── nexus.md   # Prioritization
        ├── vigil.md   # Monitoring
        ├── archive.md # Documentation
        └── purge.md   # Tech debt
```

---

## When to Use Array vs Shard vs Matrix

| Use Array | Use Shard | Use Matrix |
|-----------|-----------|------------|
| Want specialized agents | Want simplicity | Need enterprise features |
| Team projects | Solo projects | Multi-team coordination |
| Complex workflows | Quick iterations | Governance & approvals |
| Need extras (deploy, monitor) | Just plan/build/test/review | Multi-service deployments |

---

## Upgrade to Matrix

Need enterprise features? Upgrade to **Matrix**:

```bash
# Copy enterprise agents
cp -r matrix/agents/extras/enterprise/ .mothership/agents/extras/
cp matrix/mothership.md .mothership/
cp matrix/config.json .mothership/
```

Matrix adds:
- **Arbiter** - Conflict resolution
- **Conductor** - Multi-service deployment
- **Coalition** - Multi-team coordination
- **Vault** - Secrets management
- **Telemetry** - Analytics & compliance

---

## Credits

- [Geoffrey Huntley](https://ghuntley.com/ralph/) - Original Ralph concept
- [Ryan Carson](https://github.com/snarktank/ralph) - Ralph implementation

Array takes Ralph's concept and specializes it for team workflows.

---

*"I come in peace. I leave with features."* 🛸
