# Camino Setup - Quick Start Prompt

> Condensed version - give this to Claude Code in your Camino repo

---

# Task: Create Feature Specs from Content Docs, Then Build Linear Project

## Step 1: Analyze Content

Read ALL docs in these directories:
- `docs/foundation/` - Core beliefs, philosophy, origin story
- `docs/essays/` - All 24 educational essays
- `docs/discover_journey_programs/` - Program prompts and structure

Write findings to `.mothership/content-analysis.md`:
- What are the three dimensions? (Identity, Worldview, Relationship)
- What are the three programs? (Discover, Journey, TCM)
- How many prompts per dimension?
- What's the program structure (days, rotation)?

## Step 2: Create Feature Docs

Create `docs/features/` with specs for building the APPLICATION:

| Doc | Covers |
|-----|--------|
| `01-data-layer.md` | Convex schema for users, subscriptions, enrollments, reflections, essays, prompts |
| `02-authentication.md` | Sign up, login, password reset, protected routes |
| `03-marketing-site.md` | Landing, pricing (3 programs), about |
| `04-subscriptions.md` | Stripe integration, webhooks, customer portal |
| `05-onboarding.md` | Welcome, assessment, first reflection |
| `06-essay-library.md` | 24 essays, reading progress, search |
| `07-foundation-content.md` | Core beliefs, philosophy, breathing |
| `08-program-system.md` | Prompt delivery, dimension rotation, day advancement |
| `09-ai-journaling.md` | Reflection input, Claude AI responses, history |
| `10-progress-tracking.md` | Dashboard, streaks, stats |
| `11-admin-dashboard.md` | User management, content management |

Each doc must have:
- User stories: "As a [user] I want to [action] so that [benefit]"
- Acceptance criteria: Testable checkboxes
- Expected files: Path to implementation
- Dependencies: What it needs before it can be built

## Step 3: Configure Mothership

```bash
# Verify setup
./mothership.sh doctor

# Ensure config exists with Linear settings
cat .mothership/config.json
# Should have: "state": "linear", "linear": { "team": "...", "workspace": "..." }

# Verify Linear auth
linear whoami
```

## Step 4: Run Planning

```bash
./mothership.sh plan "Camino Platform"
```

This creates:
- Linear Project: "Camino Platform - v1"
- Milestones for each phase
- Issues for each story
- Quality gates at milestone boundaries

## Step 5: Build

```bash
./mothership.sh build 100   # Build all stories
./mothership.sh test 100    # Test all stories
./mothership.sh review      # Final review
```

---

## Key Reminders

1. **Content docs ≠ Feature docs**
   - Content = what users see (essays, prompts)
   - Features = what to BUILD (components, APIs, database)

2. **One story = one deliverable**
   - One component OR one route OR one function
   - Small enough for ~30 min of work

3. **Quality gates at each milestone**
   - TypeScript, lint, tests must pass
   - Security audit at end

4. **Signal when done**
   - `<mothership>PLANNED:N</mothership>` after creating N issues
