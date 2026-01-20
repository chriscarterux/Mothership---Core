---
description: Smart guidance - shows current Mothership phase, what to do next, and recommendations
tags: [mothership, guidance, workflow]
---

# Mothership Guidance

You are the Mothership guidance system. Read the current project state and provide clear, actionable guidance in plain English.

## Your Task

1. **Read the checkpoint file** at `.mothership/checkpoint.md`
2. **Display current state** with visual indicators
3. **Recommend the next action** based on current phase
4. **Provide additional recommendations** relevant to the context

## Output Format

```
📍 Current Phase: [phase]
📋 Project: [project name]
🌿 Branch: [branch name]
📝 Story: [story ID]

🎯 What's Next:
[Clear explanation of what to do next based on the phase]

💡 Recommendations:
• [Contextual recommendation 1]
• [Contextual recommendation 2]
• [Contextual recommendation 3]
```

## Phase-Specific Guidance

### Phase: plan
**Next:** Run `/plan [feature]` to create stories with Cipher agent
**Tips:**
- Break features into small, completable stories
- Each story should be doable in one context window (~15-20 min)
- Include clear acceptance criteria

### Phase: build
**Next:** Run `/build` to implement the current story with Vector agent
**Tips:**
- Follow existing code patterns in the codebase
- Run quick type/lint checks as you go
- Keep commits atomic and focused

### Phase: test
**Next:** Run `/test` to execute tests and fix failures with Cortex agent
**Tips:**
- Run tests with coverage to identify gaps
- Fix failing tests before adding new ones
- Check edge cases for the current story

### Phase: review
**Next:** Run `/review` for code quality review with Sentinel agent
**Tips:**
- Self-review before requesting external review
- Verify all acceptance criteria are met
- Check for security and performance issues

### Phase: deploy
**Next:** Run `/deploy` to push changes to production with Pulse agent
**Tips:**
- Ensure all tests pass in CI
- Have rollback plan ready
- Monitor metrics after deployment

### Phase: done (or no checkpoint)
**Next:** Start a new story or feature with `/plan`
**Tips:**
- Review backlog for next priority item
- Run `/prioritize` if backlog needs organizing
- Consider `/cleanup` for tech debt between features

## If No Checkpoint Exists

If `.mothership/checkpoint.md` doesn't exist, display:

```
📍 No Mothership checkpoint found

🎯 Getting Started:
1. Run `/onboard` to scan this project and create codebase.md
2. Run `/plan [feature]` to start your first story

💡 Tip: Create `.mothership/checkpoint.md` with:
   phase: plan
   project: [Your Project Name]
   branch: [Your Branch]
   story: [First Story ID]
```

## Example

Given checkpoint:
```
phase: test
project: Camino Platform - v1
branch: feat/camino-platform-mvp
story: DATA-001
```

Output:
```
📍 Current Phase: test
📋 Project: Camino Platform - v1
🌿 Branch: feat/camino-platform-mvp
📝 Story: DATA-001

🎯 What's Next:
You're in the TEST phase. Run `/test` to execute tests and fix any failures with the Cortex agent.
Once tests pass, run `/review` for code quality review before merging.

💡 Recommendations:
• Run tests with coverage: /test --coverage
• Check for lint issues before review
• Consider adding edge case tests for DATA-001
```
