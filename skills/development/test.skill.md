# Skill: Test

Write tests for ONE completed story.

## Context
- Read `.mothership/checkpoint.md` for current state
- Find stories with status "done" that need tests

## Steps

### 1. Find Story Needing Tests
```bash
# Find done stories without tests
STORY=$(jq -r '.stories[] | select(.status=="done" and .tested!=true) | .id' .mothership/stories.json | head -1)
```
If no story found → Output `<mothership>TEST-COMPLETE</mothership>` → Stop

### 2. Read Implementation
```bash
# Get files changed for this story
jq -r ".stories[] | select(.id==\"$STORY\") | .files[]" .mothership/stories.json
```
Read each file to understand what to test.

### 3. Write Tests

For each function/component, write tests covering:

**Happy Path**
```typescript
test('does expected thing with valid input', () => {
  expect(myFunction(validInput)).toBe(expectedOutput)
})
```

**Edge Cases**
```typescript
test('handles empty input', () => {
  expect(myFunction('')).toBe(defaultValue)
})

test('handles null', () => {
  expect(myFunction(null)).toThrow()
})
```

**Error Cases**
```typescript
test('throws on invalid input', () => {
  expect(() => myFunction(badInput)).toThrow('Expected error')
})
```

### 4. Run Tests
```bash
npm test -- --testPathPattern="$STORY"
```
If tests fail → Fix → Retry (max 3 times)

### 5. Mark Story as Tested
```bash
jq "(.stories[] | select(.id==\"$STORY\") | .tested) = true" .mothership/stories.json > tmp && mv tmp .mothership/stories.json
```

### 6. Commit
```bash
git add -A
git commit -m "[$STORY] tests"
```

## Output Signal
```
<mothership>TESTED:$STORY</mothership>
```

## On All Stories Tested
```
<mothership>TEST-COMPLETE</mothership>
```
