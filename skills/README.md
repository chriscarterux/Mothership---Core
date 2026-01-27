# Skills

Skills are AI-agnostic instructions that any coding assistant can follow.

## What's a Skill?

A skill is a markdown file that describes:
1. **What** to do (goal)
2. **How** to do it (steps)
3. **What to output** (signals)

Any AI that can read markdown can execute a skill.

## Directory Structure

```
skills/
├── development/
│   ├── plan.skill.md      # Create stories from requirements
│   ├── build.skill.md     # Implement one story
│   └── test.skill.md      # Write tests for a story
├── verification/
│   ├── quick-check.skill.md   # Fast sanity check
│   ├── verify.skill.md        # Runtime verification
│   └── test-matrix.skill.md   # Comprehensive testing
├── infrastructure/
│   ├── verify-env.skill.md    # Check environment
│   └── health-check.skill.md  # Check integrations
└── utility/
    ├── status.skill.md    # Report current state
    └── onboard.skill.md   # Scan and document project
```

## Using Skills

### With Claude Code
```bash
claude "Read skills/development/build.skill.md and execute it"
```

### With Gemini
```bash
gemini --prompt "$(cat skills/development/build.skill.md)"
```

### With Codex
```bash
codex --prompt "$(cat skills/development/build.skill.md)"
```

### With OpenCode
```bash
opencode --prompt "$(cat skills/development/build.skill.md)"
```

### With Mothership Loop
```bash
./m build   # Automatically loads build.skill.md
```

## Skill Format

```markdown
# Skill: [Name]

[One-line description]

## Context
- What files to read first
- What state to check

## Steps

### 1. [Step Name]
[Description]
```bash
[Command to run]
```

### 2. [Next Step]
...

## Output Signal
[What to output when done]
```

## Creating New Skills

1. Create a `.skill.md` file in the appropriate category
2. Follow the format above
3. Include clear steps any AI can follow
4. Define output signals for success/failure

### Tips
- Use concrete commands, not vague instructions
- Include example output where helpful
- Define what "done" looks like
- Specify error handling

## Skill Signals

Every skill must output a signal when complete:

| Signal Pattern | Meaning |
|---------------|---------|
| `<mothership>DONE</mothership>` | Generic success |
| `<mothership>BUILT:ID</mothership>` | Story built |
| `<mothership>BLOCKED:ID:reason</mothership>` | Can't proceed |
| `<mothership>VERIFIED</mothership>` | Verification passed |
| `<mothership>FAILED:reason</mothership>` | Skill failed |

The Mothership loop detects these signals to decide what to do next.
