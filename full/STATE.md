# State Backend Reference

Check `.mothership/config.json`:
- `"state": "linear"` → Use Linear API
- `"state": "local"` → Use `.mothership/stories.json`

## Local Format

```json
{"project": "Name", "branch": "feat/x", "stories": [
  {"id": "1", "title": "User can X", "status": "ready", "priority": 1, "ac": [], "files": []}
]}
```

Status: `ready` → `in_progress` → `done` | `blocked`

## Checkpoint Format

```
phase: [plan|build|test|review|done]
project: <name>
branch: <branch>
story: <id or null>
```
