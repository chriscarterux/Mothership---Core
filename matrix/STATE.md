# State Reference

## Config (`config.json`)
Schema: `config.schema.json` | Required: `version`, `state`, `commands`
```json
{"version": "matrix", "state": "linear|local", "linear": {"team": "X"}, "governance": {...}, "deployment": {...}, "teams": {...}, "security": {...}, "audit": {...}, "commands": {...}}
```
Validate: `version` = "matrix" | `state` ∈ {linear,local} | `deployment.services[].name` unique | `teams.*.max_stories` ≥ 1

## Checkpoint (`checkpoint.md`)
```
phase: plan|build|test|review|done
project: <name>
branch: <branch>
story: <id|null>
```

## Backends

**Linear** (`state: "linear"`): Use Linear CLI/API
- Stories = Issues in team
- Status: `Ready` → `In Progress` → `Done` | `Blocked`

**Local** (`state: "local"`): Use `stories.json`
```json
{"project": "X", "branch": "feat/x", "stories": [{"id": "1", "title": "User can X", "status": "ready", "ac": [], "files": []}]}
```
- Status: `ready` → `in_progress` → `done` | `blocked`

## Symbols
- `∅` = empty/null/none
- `→` = then/implies
- `|` = or
- `AC` = acceptance criteria

## Quality Commands
From `config.json.commands`:
```bash
{typecheck} && {lint} && {test} && {build}
```
