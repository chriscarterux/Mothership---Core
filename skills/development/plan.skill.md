# Skill: Plan

Create atomic user stories from a feature description.

## Input
- Feature description (from user or docs/)

## Context
- Read `.mothership/codebase.md` for project patterns
- Read existing stories in `.mothership/stories.json`

## Steps

### 1. Analyze Feature
Break down the feature into small, independent pieces:
- Each story = ONE component, route, or function
- Should take ~15-20 minutes to implement
- No dependencies within stories if possible

### 2. Create Stories
For each piece, create a story:

```json
{
  "id": "FEATURE-001",
  "title": "User can [verb] [noun]",
  "status": "ready",
  "acceptance_criteria": [
    "Specific testable criterion with verification step",
    "Another criterion with how to verify"
  ],
  "files": ["expected/file/paths.ts"],
  "test_requirements": {
    "unit": ["functions to test"],
    "integration": ["components to test together"],
    "e2e": ["user flow to test"]
  }
}
```

### 3. Write Atomic Acceptance Criteria
Each criterion MUST include:
- WHAT happens
- HOW to verify it

Examples:
```
✓ "Submit button calls API - Verify: Click button, see network request"
✓ "Error shows on invalid email - Verify: Type 'bad', blur, see error text"
✗ "Button works" (too vague)
✗ "Form validates" (no verification step)
```

### 4. Save Stories
```bash
# Append to stories.json
jq '.stories += [NEW_STORIES]' .mothership/stories.json > tmp && mv tmp .mothership/stories.json
```

### 5. Update Checkpoint
```bash
cat > .mothership/checkpoint.md << EOF
phase: build
project: [Feature Name]
branch: feat/[feature-name]
story: null
EOF
```

## Output Signal
```
<mothership>PLANNED:[count]</mothership>
```

Example: `<mothership>PLANNED:7</mothership>` (created 7 stories)
