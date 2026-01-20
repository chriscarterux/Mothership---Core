# Complete Mothership Linear Project Setup Prompt

> Copy everything below the line to give to Claude Code

---

# Task: Create Complete Linear Project Structure with Mothership

You are setting up a comprehensive Linear project using Mothership. Follow these instructions precisely.

## Phase 0: Prerequisites Verification

Before doing anything else, verify the environment:

```bash
# 1. Verify Linear CLI authentication
linear whoami

# 2. If not authenticated, stop and tell user to run:
# linear auth

# 3. Verify Mothership is installed
./mothership.sh doctor

# 4. Check current state
cat .mothership/config.json 2>/dev/null || echo "No config found"
```

**STOP if Linear auth fails.** Tell the user to run `linear auth` first.

---

## Phase 1: Configuration Setup

### 1.1 Create/Update `.mothership/config.json`

```json
{
  "state": "linear",
  "linear": {
    "team": "[TEAM_KEY]",
    "workspace": "[WORKSPACE_NAME]"
  },
  "commands": {
    "typecheck": "npx tsc --noEmit",
    "lint": "npm run lint",
    "test": "npm run test",
    "test:unit": "npm run test:unit",
    "test:integration": "npm run test:integration",
    "test:e2e": "npm run test:e2e",
    "security": "npm audit --audit-level=moderate",
    "build": "npm run build"
  },
  "branch_prefix": "feat",
  "quality_gates": {
    "per_issue": ["typecheck", "lint", "test:unit"],
    "per_milestone": ["test:integration", "security"],
    "final": ["test:e2e", "build", "security"]
  }
}
```

Get the team key by running: `linear team list`

### 1.2 Run Onboarding (if codebase.md doesn't exist)

```bash
./mothership.sh onboard
```

This creates `.mothership/codebase.md` with project patterns.

---

## Phase 2: Read All Documentation

Read ALL files in the `./docs/` directory thoroughly:

```bash
find ./docs -name "*.md" -type f
```

For each document, extract:
- **Feature name** (H1 headers) → becomes Linear Project
- **Phases/Sections** (H2 headers) → becomes Milestones
- **User stories** (bullet points, requirements) → becomes Issues
- **Acceptance criteria** (sub-bullets, checkboxes) → becomes Issue description & Sub-issues
- **Technical requirements** → becomes Issue description
- **Dependencies** → determines issue priority order

---

## Phase 3: Create Linear Project Structure

### 3.1 Create the Project

```bash
linear project create \
  --name "[Feature Name] - v1" \
  --team [TEAM_KEY] \
  --description "[2-3 sentence summary from docs]"
```

### 3.2 Create Milestones

For EACH major phase identified in docs:

```bash
linear milestone create \
  --name "[Phase Name]" \
  --project "[Feature Name] - v1" \
  --description "[Phase objective]"
```

**Standard milestone structure:**
1. **Foundation** - Setup, schemas, base infrastructure
2. **Core Features** - Main functionality
3. **Integration** - Connect components, auth, external services
4. **Polish** - Error handling, edge cases, UX improvements
5. **Quality Gate** - Final testing, security, performance

### 3.3 Create Issues (User Stories)

For EACH user story, create an issue with this EXACT format:

```bash
linear issue create \
  --team [TEAM_KEY] \
  --project "[Feature Name] - v1" \
  --milestone "[Phase Name]" \
  --title "User can [verb] [noun]" \
  --description "$(cat <<'EOF'
## Acceptance Criteria
- [ ] [Specific, testable criterion 1]
- [ ] [Specific, testable criterion 2]
- [ ] [Specific, testable criterion 3]

## Technical Requirements
- [Requirement 1]
- [Requirement 2]

## Expected Files
- `path/to/file1.ts`
- `path/to/file2.tsx`

## Testing Requirements
- Unit tests: [what to test]
- Integration tests: [if applicable]

## Dependencies
- Depends on: [ISSUE-ID] (if any)
- Blocks: [ISSUE-ID] (if any)

## Out of Scope
- [What this issue does NOT include]
EOF
)" \
  --state "Ready" \
  --priority [1-4]
```

**Priority Guide:**
- 1 = Urgent (blockers, critical path)
- 2 = High (core features)
- 3 = Medium (enhancements)
- 4 = Low (nice-to-have)

### 3.4 Create Quality Gate Issues

At the END of each milestone, create a quality gate issue:

```bash
linear issue create \
  --team [TEAM_KEY] \
  --project "[Feature Name] - v1" \
  --milestone "[Phase Name]" \
  --title "[Milestone Name] - Quality Gate" \
  --description "$(cat <<'EOF'
## Quality Checklist

### Code Quality
- [ ] All issues in milestone marked Done
- [ ] TypeScript strict mode passes (`npx tsc --noEmit`)
- [ ] Lint passes with zero warnings (`npm run lint`)
- [ ] No `any` types introduced
- [ ] No `console.log` or debug code

### Testing
- [ ] All unit tests pass (`npm run test:unit`)
- [ ] Integration tests pass (`npm run test:integration`)
- [ ] Test coverage meets threshold (>80%)

### Security
- [ ] `npm audit` passes (no high/critical vulnerabilities)
- [ ] No secrets or API keys in code
- [ ] Input validation on all user inputs
- [ ] Auth checks on protected routes/functions

### Documentation
- [ ] New functions have JSDoc comments
- [ ] README updated if needed
- [ ] API changes documented

## Commands to Run
```bash
npm run typecheck
npm run lint
npm run test
npm audit --audit-level=high
```

## Sign-off
- [ ] Code review completed
- [ ] QA verification (if applicable)
EOF
)" \
  --state "Ready" \
  --priority 2 \
  --label "quality-gate"
```

### 3.5 Create Sub-issues (Optional - for complex stories)

For issues with complex acceptance criteria, create sub-issues:

```bash
linear issue create \
  --team [TEAM_KEY] \
  --parent "[PARENT-ISSUE-ID]" \
  --title "[AC item as task]" \
  --description "[Details if needed]" \
  --state "Ready"
```

---

## Phase 4: Convex-Specific Issues (If Applicable)

If the project uses Convex, ensure these patterns are followed:

### 4.1 Schema Issues
```bash
linear issue create \
  --team [TEAM_KEY] \
  --project "[Feature Name] - v1" \
  --milestone "Foundation" \
  --title "Define Convex schema for [entity]" \
  --description "$(cat <<'EOF'
## Acceptance Criteria
- [ ] Schema defined in `convex/schema.ts`
- [ ] All fields have proper types (no `v.any()`)
- [ ] Indexes defined for query patterns
- [ ] Relations properly linked

## Expected Files
- `convex/schema.ts`

## Testing Requirements
- Schema validates with `npx convex dev`
EOF
)" \
  --state "Ready"
```

### 4.2 Function Issues
```bash
linear issue create \
  --team [TEAM_KEY] \
  --project "[Feature Name] - v1" \
  --milestone "Core Features" \
  --title "User can [action] via Convex [mutation/query]" \
  --description "$(cat <<'EOF'
## Acceptance Criteria
- [ ] Function defined in `convex/[domain].ts`
- [ ] Input validation with `v.object()`
- [ ] Proper error handling
- [ ] Auth check if protected

## Expected Files
- `convex/[domain].ts`
- `convex/_generated/` (auto-generated)

## Testing Requirements
- Unit test function logic
- Test auth scenarios
- Test error cases
EOF
)" \
  --state "Ready"
```

### 4.3 Real-time Subscription Issues
```bash
linear issue create \
  --team [TEAM_KEY] \
  --project "[Feature Name] - v1" \
  --milestone "Integration" \
  --title "User sees real-time updates for [entity]" \
  --description "$(cat <<'EOF'
## Acceptance Criteria
- [ ] Query uses `useQuery` hook
- [ ] UI updates automatically on data change
- [ ] Loading state handled
- [ ] Error state handled

## Expected Files
- `components/[Entity]List.tsx`
- `convex/[entity].ts` (query)

## Testing Requirements
- Test loading state renders
- Test data renders correctly
- Test real-time update (manual verification)
EOF
)" \
  --state "Ready"
```

---

## Phase 5: Final Verification

After creating all issues:

### 5.1 Verify Project Structure
```bash
# List all issues
linear issue list --project "[Feature Name] - v1" --json | head -50

# Count by milestone
linear issue list --project "[Feature Name] - v1" --state "Ready" --json | jq 'length'
```

### 5.2 Update Checkpoint
Write to `.mothership/checkpoint.md`:
```markdown
phase: build
project: [Feature Name] - v1
branch: feat/[feature-slug]
story: null
```

### 5.3 Log Progress
Append to `.mothership/progress.md`:
```markdown
## [TIMESTAMP] - Planning Complete

### Summary
- Project: [Feature Name] - v1
- Milestones: [count]
- Issues: [count]
- Quality Gates: [count]

### Structure
1. Milestone: [name] - [X issues]
2. Milestone: [name] - [X issues]
...

### Next Steps
Run: `./mothership.sh build [max-iterations]`
```

---

## Phase 6: Output Signal

When complete, output:

```
<mothership>PLANNED:[total_issue_count]</mothership>
```

---

## Issue Creation Checklist

For EVERY issue, verify:

- [ ] Title follows "User can [verb] [noun]" format
- [ ] Acceptance criteria are specific and testable
- [ ] Expected files are listed
- [ ] Testing requirements specified
- [ ] Dependencies noted
- [ ] State set to "Ready"
- [ ] Assigned to correct milestone
- [ ] Priority set appropriately

---

## Standard Issue Categories

Include issues for each of these categories:

### Data Layer
- [ ] Schema definitions
- [ ] Migrations (if applicable)
- [ ] Seed data (if needed)

### API/Backend
- [ ] CRUD operations
- [ ] Business logic
- [ ] Validation
- [ ] Error handling

### Frontend
- [ ] Pages/Routes
- [ ] Components
- [ ] Forms
- [ ] State management

### Integration
- [ ] Auth flows
- [ ] External APIs
- [ ] Real-time features

### Quality
- [ ] Unit test coverage
- [ ] Integration tests
- [ ] E2E tests (final milestone)
- [ ] Security audit
- [ ] Performance check

---

## Example Complete Project Structure

```
Project: User Authentication - v1
├── Milestone: Foundation
│   ├── Issue: Define user schema in Convex
│   ├── Issue: Set up auth configuration
│   └── Issue: Foundation - Quality Gate
│
├── Milestone: Core Auth
│   ├── Issue: User can sign up with email/password
│   ├── Issue: User can log in with email/password
│   ├── Issue: User can log out
│   ├── Issue: User can reset password
│   └── Issue: Core Auth - Quality Gate
│
├── Milestone: OAuth Integration
│   ├── Issue: User can sign up with Google
│   ├── Issue: User can sign up with GitHub
│   ├── Issue: User can link multiple auth providers
│   └── Issue: OAuth - Quality Gate
│
├── Milestone: Session Management
│   ├── Issue: User session persists across browser refresh
│   ├── Issue: User can view active sessions
│   ├── Issue: User can revoke other sessions
│   └── Issue: Session Management - Quality Gate
│
└── Milestone: Final Polish
    ├── Issue: Add rate limiting to auth endpoints
    ├── Issue: Add audit logging for auth events
    ├── Issue: E2E test complete auth flows
    └── Issue: Final Release - Quality Gate
```

---

## After Planning: Execution Commands

```bash
# Build all issues (one at a time, looped)
./mothership.sh build 50

# Test all completed issues
./mothership.sh test 50

# Final review
./mothership.sh review

# Check status anytime
./mothership.sh status
```

---

**Remember:**
- ONE deliverable per issue
- Keep issues small (20-30 min of work)
- Acceptance criteria must be testable (pass/fail)
- Always include quality gates at milestone boundaries
- Set ALL issues to "Ready" state initially
