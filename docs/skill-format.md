# Universal Skill Format

Skills are AI-agnostic instruction sets. Any AI (Claude, Gemini, Codex, OpenCode) can read and execute them.

## Skill File Structure

```yaml
# skills/build.skill.yaml
name: build
version: 1.0
description: Implement one story from the backlog

# What the AI needs to know before starting
context:
  - Read .mothership/checkpoint.md for current state
  - Read .mothership/codebase.md for project patterns
  - Read the story's acceptance criteria

# Input parameters
inputs:
  story_id:
    type: string
    required: false
    description: Specific story to build (default: next ready story)

# Step-by-step instructions
steps:
  - id: 1
    action: read_checkpoint
    description: Get current project state
    command: cat .mothership/checkpoint.md

  - id: 2
    action: get_story
    description: Find the next ready story
    if: "!inputs.story_id"
    command: |
      # Find first story with status=ready
      jq '.stories[] | select(.status=="ready") | .id' .mothership/stories.json | head -1

  - id: 3
    action: implement
    description: Write the code
    instructions: |
      - Find similar code in codebase, follow patterns
      - Implement one file at a time
      - Run typecheck after each file
      - Follow acceptance criteria exactly

  - id: 4
    action: validate
    description: Run validation commands
    commands:
      - npm run typecheck
      - npm run lint
      - npm test

  - id: 5
    action: verify_wiring
    description: Check nothing is left unwired
    commands:
      - grep -rn "onClick={}" src/ && exit 1 || true
      - grep -rn "onSubmit={}" src/ && exit 1 || true

  - id: 6
    action: commit
    description: Commit the changes
    command: git add -A && git commit -m "[${story_id}] ${story_title}"

# Expected outputs
outputs:
  - signal: "<mothership>BUILT:${story_id}</mothership>"
    when: success
  - signal: "<mothership>BUILD-COMPLETE</mothership>"
    when: no_stories
  - signal: "<mothership>BLOCKED:${story_id}:${reason}</mothership>"
    when: error

# What to do on failure
on_failure:
  - Attempt fix up to 3 times
  - If still failing, emit BLOCKED signal
```

## Minimal Skill Format

For simple skills, use this compact format:

```yaml
# skills/quick-check.skill.yaml
name: quick-check
description: Fast sanity check for common issues

steps:
  - Check for empty handlers: grep -rn "onClick={}" src/
  - Check Docker runs: docker build -t test . && docker run -d test
  - Check build passes: npm run build
  - Check tests pass: npm test

outputs:
  success: "<mothership>QUICK-CHECK:pass</mothership>"
  failure: "<mothership>QUICK-CHECK:fail:${issue_count}</mothership>"
```

## Skill Categories

```
skills/
├── development/
│   ├── plan.skill.yaml
│   ├── build.skill.yaml
│   └── test.skill.yaml
├── verification/
│   ├── quick-check.skill.yaml
│   ├── verify.skill.yaml
│   └── test-matrix.skill.yaml
├── infrastructure/
│   ├── verify-env.skill.yaml
│   └── health-check.skill.yaml
└── utility/
    ├── status.skill.yaml
    └── onboard.skill.yaml
```
