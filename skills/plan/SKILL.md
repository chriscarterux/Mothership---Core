# Plan Skill

Generate a feature specification from a brief description.

## Usage

```
Use the plan skill to create a spec for: user authentication with email and OAuth
```

## Process

1. Ask 3-5 clarifying questions about:
   - Target users
   - Key workflows
   - Technical constraints
   - Out of scope items

2. Generate a feature spec:

```markdown
# Feature: [Name]

## Overview
[2-3 sentence description]

## User Stories
- As a [user], I want to [action] so that [benefit]
- ...

## Requirements
- [ ] [Specific requirement]
- [ ] [Specific requirement]

## Technical Notes
- Framework considerations
- Data models needed
- API endpoints

## Out of Scope
- [Explicitly excluded]

## Acceptance Criteria
- [ ] [Testable criterion]
```

3. Save to `docs/[feature-name].md`

4. Output: "Spec created. Run: mothership plan [feature-name]"
