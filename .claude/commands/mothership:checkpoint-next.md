---
description: Advance checkpoint to next phase in workflow
tags: [mothership, checkpoint, workflow]
---

# Advance Checkpoint Phase

Move the checkpoint to the next phase in the Mothership workflow.

## Usage

```
/checkpoint:next         # Advance to next phase
/checkpoint:next --force # Skip validation and advance
```

## Workflow Order

```
plan → build → test → review → deploy → done → plan (next story)
```

## Phase Transitions

| Current Phase | Next Phase | Validation |
|---------------|------------|------------|
| plan | build | Stories exist |
| build | test | Code changes committed |
| test | review | Tests passing |
| review | deploy | Review approved |
| deploy | done | Deployment successful |
| done | plan | Ready for next story |

## Behavior

1. **Read current checkpoint**
2. **Validate transition** (unless --force)
3. **Update phase** to next in sequence
4. **Confirm change**

## Validation Checks

### plan → build
- Check that stories have been created
- Verify current story ID is set

### build → test
- Check for uncommitted changes
- Verify relevant files modified

### test → review
- Run test suite
- Verify tests passing
- Check coverage meets threshold

### review → deploy
- Check for approval signal
- Verify no blocking issues

### deploy → done
- Verify deployment success
- Check health metrics

### done → plan
- Archive completed story
- Clear story field for next

## Output

```
✅ Phase advanced: test → review

Current checkpoint:
  phase: review
  project: Camino Platform - v1
  branch: feat/camino-platform-mvp
  story: DATA-001

Next action: Run /review to perform code quality review
```

## Skip Validation

Use `--force` to skip validation checks:

```
/checkpoint:next --force
```

⚠️ Use with caution - validation ensures workflow integrity.

## Back to Previous Phase

To go back (e.g., review found issues):

```
/checkpoint set phase test
```

Or use the main checkpoint command for arbitrary phase changes.

## Example Flow

```bash
# Starting a new feature
/plan "user authentication"
/checkpoint:next  # plan → build

# After implementing
/checkpoint:next  # build → test

# After tests pass
/checkpoint:next  # test → review

# After review approved
/checkpoint:next  # review → deploy

# After deployment
/checkpoint:next  # deploy → done

# Start next story
/checkpoint:next  # done → plan
```
