---
description: View and manage Mothership checkpoint state
tags: [mothership, checkpoint, state]
---

# Checkpoint Management

View and edit the `.mothership/checkpoint.md` workflow state.

## Usage

```
/checkpoint              # View current checkpoint
/checkpoint set phase build
/checkpoint set story DATA-002
```

## Checkpoint File Format

`.mothership/checkpoint.md`:
```yaml
phase: [plan|build|test|review|deploy|done]
project: [Project Name]
branch: [Git Branch]
story: [Current Story ID]
```

## Commands

### View Checkpoint
```
/checkpoint
```
Displays formatted checkpoint state with visual indicators.

### Set Phase
```
/checkpoint set phase [plan|build|test|review|deploy|done]
```

### Set Story
```
/checkpoint set story [STORY-ID]
```

### Set Project
```
/checkpoint set project [Project Name]
```

### Set Branch
```
/checkpoint set branch [branch-name]
```

### Reset
```
/checkpoint reset
```
Resets to initial state (phase: plan).

## Workflow Phases

| Phase | Description | Next Phase |
|-------|-------------|------------|
| plan | Creating stories | build |
| build | Implementing code | test |
| test | Running/fixing tests | review |
| review | Code review | deploy |
| deploy | Deploying to production | done |
| done | Story complete | plan (next story) |

## Phase Transitions

Normal flow:
```
plan → build → test → review → deploy → done → plan
```

Common transitions:
- `review → test` (needs work, re-test)
- `test → build` (fix implementation)
- `deploy → test` (rollback, investigate)

## Example Output

```
╔══════════════════════════════════════════════════════════════╗
║                    CHECKPOINT STATE                          ║
╠══════════════════════════════════════════════════════════════╣
║  phase:    test                                              ║
║  project:  Camino Platform - v1                              ║
║  branch:   feat/camino-platform-mvp                          ║
║  story:    DATA-001                                          ║
╠══════════════════════════════════════════════════════════════╣
║  plan ─▶ build ─▶ [test] ─▶ review ─▶ deploy ─▶ done        ║
╚══════════════════════════════════════════════════════════════╝
```

## Creating Checkpoint

If `.mothership/checkpoint.md` doesn't exist, create it:

```
/checkpoint init [project-name]
```

Creates:
```yaml
phase: plan
project: [project-name]
branch: main
story: INIT-001
```

## Tips

- Keep checkpoint in sync with actual work state
- Use `/next` for guidance based on current phase
- Checkpoint is per-project (in `.mothership/` directory)
