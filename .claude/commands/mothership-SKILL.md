---
description: Mothership AI development orchestration system
tags: [mothership, orchestration, workflow]
---

# Mothership

AI-driven development orchestration system. Manages the full development lifecycle through specialized agents.

## Quick Start

```
/mothership:next      # See current phase and what to do next
/mothership:status    # View checkpoint state
/mothership:onboard   # Scan project and create codebase.md
```

## Core Loop

The Mothership workflow follows this cycle:

```
plan → build → test → review → deploy → done
  ↑                                       │
  └───────────────────────────────────────┘
```

| Command | Agent | Description |
|---------|-------|-------------|
| `/mothership:plan` | Cipher | Create stories from feature description |
| `/mothership:build` | Vector | Implement features |
| `/mothership:test` | Cortex | Run and fix tests |
| `/mothership:review` | Sentinel | Code quality review |

## All Commands

### Guidance
- `/mothership:next` - Smart guidance with recommendations

### Core Loop
- `/mothership:plan [feature]` - Create stories (Cipher)
- `/mothership:build [story]` - Build features (Vector)
- `/mothership:test [story]` - Run/fix tests (Cortex)
- `/mothership:review [story]` - Code review (Sentinel)
- `/mothership:status` - Show checkpoint state
- `/mothership:onboard` - Scan project, create codebase.md

### Checkpoint
- `/mothership:checkpoint` - View/edit checkpoint state
- `/mothership:checkpoint:next` - Advance to next phase

### Extended Agents
- `/mothership:deploy` - Deployment (Pulse)
- `/mothership:prioritize` - Backlog prioritization (Nexus)
- `/mothership:monitor` - Production health (Vigil)
- `/mothership:document` - Documentation (Archive)
- `/mothership:cleanup` - Tech debt removal (Purge)

### Enterprise
- `/mothership:resolve` - Conflict resolution (Arbiter)
- `/mothership:orchestrate` - Blue-green/canary deploys (Conductor)
- `/mothership:coordinate` - Team coordination (Coalition)
- `/mothership:secrets` - Secrets management (Vault)
- `/mothership:metrics` - DORA metrics & analytics (Telemetry)

## Checkpoint File

State is tracked in `.mothership/checkpoint.md`:

```yaml
phase: build
project: My Project
branch: feat/my-feature
story: STORY-001
```

## Getting Started

1. **New project:**
   ```
   /mothership:onboard
   /mothership:plan "your first feature"
   ```

2. **Existing project:**
   ```
   /mothership:next
   ```

## Agents

| Agent | Role | Specialty |
|-------|------|-----------|
| Cipher | Planning | Decodes requirements into stories |
| Vector | Building | Implements code with precision |
| Cortex | Testing | Analyzes behavior through tests |
| Sentinel | Review | Guards code quality |
| Pulse | Deploy | Sends deployment signals |
| Nexus | Prioritize | Central coordination hub |
| Vigil | Monitor | Vigilant production watch |
| Archive | Document | Stores knowledge |
| Purge | Cleanup | Removes obsolete code |
| Arbiter | Resolve | Conflict resolution |
| Conductor | Orchestrate | Deployment orchestration |
| Coalition | Coordinate | Team coordination |
| Vault | Secrets | Secrets management |
| Telemetry | Metrics | Analytics & reporting |
