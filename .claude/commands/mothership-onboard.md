---
description: Scan project and create codebase.md for Mothership context
tags: [mothership, onboarding, setup]
---

# Onboard Mode

Scan the current project and create `.mothership/codebase.md` with comprehensive project understanding.

## Usage

```
/onboard
```

## Your Task

1. **Scan project structure**
   - Map directory structure
   - Identify key files and patterns
   - Detect tech stack

2. **Analyze codebase**
   - Identify entry points
   - Map component/module structure
   - Document API endpoints
   - Note database schemas

3. **Document patterns**
   - Coding conventions
   - File naming patterns
   - State management approach
   - Testing patterns

4. **Create codebase.md**
   - Write comprehensive documentation
   - Include file references
   - Note important dependencies

5. **Initialize checkpoint** (if needed)
   - Create `.mothership/checkpoint.md`
   - Set initial phase to `plan`

## Output: codebase.md Template

```markdown
# [Project Name] - Codebase Overview

## Tech Stack
- **Frontend:** [framework, styling, state management]
- **Backend:** [runtime, framework, database]
- **Infrastructure:** [hosting, CI/CD]

## Directory Structure
```
project/
├── src/
│   ├── components/    # [description]
│   ├── pages/         # [description]
│   ├── api/           # [description]
│   └── lib/           # [description]
├── tests/
└── ...
```

## Entry Points
- **App:** `src/index.ts`
- **API:** `src/api/index.ts`
- **Config:** `config/`

## Key Patterns

### Component Pattern
[Description of how components are structured]

### API Pattern
[Description of API conventions]

### State Management
[Description of state approach]

## Database Schema
[Key tables/collections and relationships]

## Commands
```bash
npm run dev      # Start development
npm run build    # Build for production
npm run test     # Run tests
npm run lint     # Lint code
```

## Environment Variables
- `DATABASE_URL` - Database connection
- `API_KEY` - External API key
- ...

## Dependencies (Key)
- [package]: [purpose]
- ...

## Notes for AI Agents
- [Important context]
- [Gotchas to watch for]
- [Patterns to follow]
```

## Signal

When onboarding is complete:
```
<mothership>ONBOARD-COMPLETE</mothership>
```

## Example

Running `/onboard` in a Next.js project:

1. Scans `src/`, `pages/`, `components/`, etc.
2. Identifies Next.js, React, TypeScript
3. Documents API routes in `pages/api/`
4. Notes Tailwind CSS patterns
5. Creates detailed `codebase.md`
6. Initializes checkpoint if missing

## Tips

- Run this when starting on a new codebase
- Re-run after major refactors
- Keep codebase.md updated with significant changes
