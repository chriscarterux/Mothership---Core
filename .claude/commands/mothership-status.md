---
description: Show current Mothership checkpoint state
tags: [mothership, status, checkpoint]
---

# Mothership Status

Display the current project state from `.mothership/checkpoint.md`.

## Usage

```
/status
```

## Your Task

1. **Read checkpoint file** at `.mothership/checkpoint.md`
2. **Display formatted status**
3. **Show recent activity** if progress.md exists

## Output Format

```
╔══════════════════════════════════════════════════════════════╗
║                    MOTHERSHIP STATUS                         ║
╠══════════════════════════════════════════════════════════════╣
║  Phase:    [current phase]                                   ║
║  Project:  [project name]                                    ║
║  Branch:   [branch name]                                     ║
║  Story:    [story ID]                                        ║
╠══════════════════════════════════════════════════════════════╣
║  Workflow: plan → build → test → review                      ║
║            [indicator of current position]                   ║
╚══════════════════════════════════════════════════════════════╝
```

## Visual Phase Indicator

Show progress through the workflow:

```
plan ──▶ build ──▶ test ──▶ review
 ●        ○        ○        ○      (phase: plan)
 ✓        ●        ○        ○      (phase: build)
 ✓        ✓        ●        ○      (phase: test)
 ✓        ✓        ✓        ●      (phase: review)
```

## If No Checkpoint

If `.mothership/checkpoint.md` doesn't exist:

```
╔══════════════════════════════════════════════════════════════╗
║                    MOTHERSHIP STATUS                         ║
╠══════════════════════════════════════════════════════════════╣
║  No checkpoint found                                         ║
║                                                              ║
║  Get started:                                                ║
║  1. Run /onboard to scan this project                        ║
║  2. Run /plan [feature] to create your first story           ║
╚══════════════════════════════════════════════════════════════╝
```

## Additional Information

If available, also show:

- **Config:** `.mothership/config.json` settings
- **Codebase:** Whether `.mothership/codebase.md` exists
- **Progress:** Last few entries from `.mothership/progress.md`

## Example Output

```
╔══════════════════════════════════════════════════════════════╗
║                    MOTHERSHIP STATUS                         ║
╠══════════════════════════════════════════════════════════════╣
║  Phase:    test                                              ║
║  Project:  Camino Platform - v1                              ║
║  Branch:   feat/camino-platform-mvp                          ║
║  Story:    DATA-001                                          ║
╠══════════════════════════════════════════════════════════════╣
║  Workflow: plan ──▶ build ──▶ test ──▶ review                ║
║             ✓        ✓        ●        ○                     ║
╠══════════════════════════════════════════════════════════════╣
║  Codebase: ✓ .mothership/codebase.md exists                  ║
║  Config:   ✓ .mothership/config.json loaded                  ║
╚══════════════════════════════════════════════════════════════╝
```
