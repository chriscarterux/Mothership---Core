# Camino Platform - Full Mothership Setup Prompt

> Give this entire prompt to Claude Code in your Camino repository (which has Mothership installed)

---

# Task: Analyze Content Docs → Create Feature Specs → Build Linear Project

You are setting up the Camino personal development platform. Your job is to:

1. **Explore** all content documentation to understand what the platform delivers
2. **Create** feature specification docs that describe what to BUILD
3. **Run Mothership** to create Linear issues from those specs

## IMPORTANT DISTINCTIONS

- **Content docs** (what you're reading): Philosophy, essays, prompts - these are USER-FACING CONTENT
- **Feature docs** (what you're creating): Technical specifications for building the APPLICATION that delivers that content

---

## Phase 1: Explore Content Documentation

### 1.1 Read Foundation Content
Read all files in `docs/foundation/`:
- Camino Core Beliefs
- One Deep Breath
- The Origin Story
- The Philosophical Foundations

**Extract:**
- What are the 6 core beliefs?
- What is the breathing practice?
- What is the 2,500-year tradition?
- How should this influence the app's tone/design?

### 1.2 Read Essay Content
Read files in `docs/essays/`:
- All 24 essays (E1-E25)

**Extract:**
- Essay titles and themes
- How users should access these (library, recommendations?)
- Reading time estimates
- Any categorization or ordering

### 1.3 Read Program Content
Read files in `docs/discover_journey_programs/`:
- TCM IDENTITY PROMPTS (28 prompts)
- TCM WORLDVIEW PROMPTS (28 prompts)
- TCM RELATIONSHIP PROMPTS (28 prompts)
- Program Structure Overview

**Extract:**
- Three dimensions: Identity, Worldview, Relationship
- Prompt structure per dimension
- Program tiers: Discover, Journey, The Camino Method
- Pricing and duration for each
- How prompts map to programs and days
- Depth levels: Notice, Examine, Transform

### 1.4 Read Any Existing Dev Docs
Check for existing documentation in:
- `docs/dev-site-guide/`
- `README.md`
- `package.json` (tech stack)
- Any existing `convex/` schema

**Extract:**
- Tech stack decisions already made
- Any existing implementation
- Design system or component library
- Authentication approach

### 1.5 Create Content Summary
Write a summary file at `.mothership/content-analysis.md`:

```markdown
# Camino Content Analysis

## Platform Overview
[What Camino is and does, based on content]

## Content Inventory
- Foundation docs: [count] files
- Essays: [count] essays
- Prompts: [count] prompts across [count] dimensions

## Three Dimensions
1. Identity - [description]
2. Worldview - [description]
3. Relationship - [description]

## Three Programs
| Program | Price | Duration | Depth | Description |
|---------|-------|----------|-------|-------------|
| Discover | $X | X days | Notice | ... |
| Journey | $X | X days | Examine | ... |
| The Camino Method | $X | X days | Transform | ... |

## Program Structure
- Days per dimension
- Rotation schedule
- Completion criteria

## Key Features Needed
Based on content analysis, the app needs:
1. [Feature 1]
2. [Feature 2]
...

## Tech Stack (from existing files)
- Framework: [X]
- Database: [X]
- Auth: [X]
- AI: [X]
- Payments: [X]
```

---

## Phase 2: Create Feature Specification Docs

Based on your content analysis, create feature specs in `docs/features/`.

### 2.1 Create Feature Index
Create `docs/features/README.md`:

```markdown
# Camino Platform - Feature Specifications

## Tech Stack
[From your analysis]

## Feature Index

### Phase 1: Foundation
1. [Data Layer](./01-data-layer.md)
2. [Authentication](./02-authentication.md)

### Phase 2: Core Platform
3. [Marketing Site](./03-marketing-site.md)
4. [Subscriptions](./04-subscriptions.md)
5. [Onboarding](./05-onboarding.md)

### Phase 3: Content Delivery
6. [Essay Library](./06-essay-library.md)
7. [Foundation Content](./07-foundation-content.md)

### Phase 4: Core Experience
8. [Program System](./08-program-system.md)
9. [AI Journaling](./09-ai-journaling.md)
10. [Progress Tracking](./10-progress-tracking.md)

### Phase 5: Administration
11. [Admin Dashboard](./11-admin-dashboard.md)

### Phase 6: Quality
12. [Testing & Security](./12-quality-gates.md)
```

### 2.2 Create Each Feature Doc

For EACH feature, create a doc following this template:

```markdown
# [Feature Name]

## Overview
[What this feature does and why it matters]

## Phase 1: [First Phase Name]

### [Story Title]
**As a** [user type]
**I want to** [action]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]

**Technical Requirements:**
- [Requirement based on content analysis]

**Files:**
- `path/to/expected/file.ts`

---

### [Next Story]
...

---

## Phase 2: [Second Phase Name]
...

---

## Testing Requirements

### Unit Tests
- [ ] [What to test]

### Integration Tests
- [ ] [What to test]

---

## Dependencies
- [Other feature docs this depends on]

## Blocks
- [Features that depend on this]
```

### 2.3 Feature-Specific Guidelines

**Data Layer (01-data-layer.md):**
- Define Convex schema for: users, subscriptions, enrollments, reflections, essays, prompts, foundation content, assessments
- Include indexes for common queries
- Define enums for: program types, dimensions, statuses

**Authentication (02-authentication.md):**
- Sign up, login, logout, password reset
- OAuth if needed
- Protected route middleware

**Marketing Site (03-marketing-site.md):**
- Landing page with three dimensions explained
- Pricing page with three programs
- About page with foundation content
- Essay previews (public)

**Subscriptions (04-subscriptions.md):**
- Stripe integration
- Three products (Discover monthly, Journey monthly, TCM one-time)
- Webhook handling
- Customer portal

**Onboarding (05-onboarding.md):**
- Welcome screen
- Assessment questions (from content analysis)
- First reflection experience
- Enrollment creation

**Essay Library (06-essay-library.md):**
- List all 24 essays
- Reading progress tracking
- Search/filter
- Public preview vs subscriber access

**Foundation Content (07-foundation-content.md):**
- Core beliefs display
- Philosophy page
- Origin story
- Breathing practice guide

**Program System (08-program-system.md):**
- Prompt delivery logic
- Dimension rotation (Identity → Worldview → Relationship)
- Day advancement
- Program completion

**AI Journaling (09-ai-journaling.md):**
- Reflection input
- AI response generation (Claude)
- Voice profiles per program depth
- Streaming responses
- Conversation history

**Progress Tracking (10-progress-tracking.md):**
- Dashboard with stats
- Streak tracking
- Dimension progress
- Export/download

**Admin Dashboard (11-admin-dashboard.md):**
- User management
- Content management (essays, prompts)
- Analytics

---

## Phase 3: Configure Mothership

### 3.1 Verify Mothership Installation
```bash
./mothership.sh doctor
```

### 3.2 Create/Update Config
Ensure `.mothership/config.json` exists:

```json
{
  "state": "linear",
  "linear": {
    "team": "[GET FROM: linear team list]",
    "workspace": "[YOUR_WORKSPACE]"
  },
  "commands": {
    "typecheck": "npx tsc --noEmit",
    "lint": "npm run lint",
    "test": "npm run test"
  }
}
```

### 3.3 Verify Linear Auth
```bash
linear whoami
# If fails: linear auth
```

### 3.4 Run Onboarding (if needed)
```bash
./mothership.sh onboard
```

---

## Phase 4: Create Linear Project

### 4.1 Run Mothership Planning
```bash
./mothership.sh plan "Camino Platform"
```

### 4.2 What Planning Does
Mothership will:
1. Read all docs in `docs/features/`
2. Create Linear Project: "Camino Platform - v1"
3. Create Milestones for each phase
4. Create Issues for each story with:
   - "User can [verb] [noun]" title
   - Acceptance criteria
   - File paths
   - State: "Ready"
5. Create Quality Gate issues at milestone boundaries

### 4.3 Verify Creation
```bash
linear project list --team [TEAM]
linear issue list --project "Camino Platform - v1" --state "Ready"
```

---

## Phase 5: Quality Gates

Ensure each milestone has a quality gate issue:

### Per-Issue Quality (during build)
- TypeScript passes
- Lint passes
- Unit tests pass

### Per-Milestone Quality
- Integration tests pass
- Security audit passes
- Code review complete

### Final Quality (Phase 6)
- E2E tests pass
- Performance audit passes
- Accessibility audit passes
- Full security review

---

## Execution Commands (After Planning)

```bash
# Build all stories (loops until complete)
./mothership.sh build 100

# Test all completed stories
./mothership.sh test 100

# Final review
./mothership.sh review

# Check status anytime
./mothership.sh status
```

---

## Signals Reference

| Signal | Meaning |
|--------|---------|
| `<mothership>PLANNED:N</mothership>` | Created N stories |
| `<mothership>BUILT:ID</mothership>` | Completed story, continue |
| `<mothership>BUILD-COMPLETE</mothership>` | No more stories |
| `<mothership>TESTED:ID</mothership>` | Tested story, continue |
| `<mothership>TEST-COMPLETE</mothership>` | All tested |
| `<mothership>APPROVED</mothership>` | Review passed |
| `<mothership>BLOCKED:reason</mothership>` | Blocked, needs help |

---

## Checklist

Before running `./mothership.sh plan`:

- [ ] Read all content docs (foundation, essays, programs)
- [ ] Created `.mothership/content-analysis.md`
- [ ] Created `docs/features/README.md`
- [ ] Created all feature spec docs (01-12)
- [ ] Each spec has phases with stories
- [ ] Each story has AC, files, dependencies
- [ ] `.mothership/config.json` configured
- [ ] `linear whoami` works
- [ ] `./mothership.sh doctor` passes

---

## Output

When complete, report:
1. Number of feature docs created
2. Total stories across all features
3. Linear project URL (if created)
4. Next steps for building
