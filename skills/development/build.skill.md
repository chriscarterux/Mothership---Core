# Skill: Build

Build ONE story from the backlog. Implement, validate, commit.

## Context
- Project: Read `.mothership/checkpoint.md`
- Patterns: Read `.mothership/codebase.md`
- Stories: Read `.mothership/stories.json`

## Steps

### 1. Get Next Story
```bash
# Find first story with status "ready"
STORY=$(jq -r '.stories[] | select(.status=="ready") | .id' .mothership/stories.json | head -1)
```
If no story found → Output `<mothership>BUILD-COMPLETE</mothership>` → Stop

### 2. Read Acceptance Criteria
```bash
jq -r ".stories[] | select(.id==\"$STORY\") | .acceptance_criteria[]" .mothership/stories.json
```

### 3. Find Similar Code
Search codebase for similar patterns. Copy the style.

### 4. Implement
- One file at a time
- Type-check after each file: `npm run typecheck`
- Follow acceptance criteria exactly

### 5. Validate
```bash
npm run typecheck
npm run lint
npm test
```
If any fails → Fix → Retry (max 3 times)

### 6. Verify Wiring
```bash
# Must find NOTHING - any output = fail
grep -rn "onClick={}" src/
grep -rn "onSubmit={}" src/
grep -rn "={() => {})" src/
```
If unwired handlers found → Fix them → Re-validate

### 7. Commit
```bash
git add -A
git commit -m "[$STORY] $STORY_TITLE"
git push
```

### 8. Update Story Status
```bash
# Update stories.json: status = "done"
jq "(.stories[] | select(.id==\"$STORY\") | .status) = \"done\"" .mothership/stories.json > tmp && mv tmp .mothership/stories.json
```

## Output Signal
```
<mothership>BUILT:$STORY</mothership>
```

## On Failure
After 3 failed attempts:
```
<mothership>BLOCKED:$STORY:$REASON</mothership>
```
