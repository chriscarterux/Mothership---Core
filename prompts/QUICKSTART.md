# Mothership Linear Setup - Quick Start

## Prompt Templates

| Prompt | Use Case |
|--------|----------|
| [full-linear-setup-prompt.md](./full-linear-setup-prompt.md) | Generic project with existing feature docs |
| [camino-full-setup-prompt.md](./camino-full-setup-prompt.md) | Camino: Full workflow from content → features → Linear |
| [camino-quickstart.md](./camino-quickstart.md) | Camino: Condensed version |
| [docs-template.md](./docs-template.md) | Template for writing feature docs |

---

## Prerequisites Checklist

```bash
# 1. Linear CLI installed and authenticated
npm install -g @linear/cli
linear auth
linear whoami  # Should show your user info

# 2. Mothership installed
./mothership.sh doctor  # Should pass all checks

# 3. Get your team key
linear team list  # Note your team key (e.g., "ENG", "PROD")
```

---

## Step-by-Step Setup

### Step 1: Configure Mothership

Create `.mothership/config.json`:
```json
{
  "state": "linear",
  "linear": {
    "team": "YOUR_TEAM_KEY",
    "workspace": "your-workspace"
  },
  "commands": {
    "typecheck": "npx tsc --noEmit",
    "lint": "npm run lint",
    "test": "npm run test"
  }
}
```

### Step 2: Create Your Documentation

```bash
mkdir -p docs
```

Create `docs/your-feature.md` following the template in `prompts/docs-template.md`

**Minimum required:**
- H1 = Feature name (becomes Linear Project)
- H2 = Phases (become Milestones)
- Bullets = User stories (become Issues)
- Sub-bullets = Acceptance criteria

### Step 3: Onboard Your Codebase

```bash
./mothership.sh onboard
```

This creates `.mothership/codebase.md` with your project patterns.

### Step 4: Run Planning

Give Claude Code this prompt:

```
Read the file at prompts/full-linear-setup-prompt.md and execute it.
Read all docs in ./docs/ and create the complete Linear project structure.
```

Or run directly:
```bash
./mothership.sh plan "Your feature description"
```

### Step 5: Build

```bash
# Build up to 50 stories (loops automatically)
./mothership.sh build 50
```

### Step 6: Test

```bash
# Test all completed stories
./mothership.sh test 50
```

### Step 7: Review

```bash
./mothership.sh review
```

---

## The Complete Prompt (Copy This)

```
# Task: Set Up Complete Linear Project with Mothership

## Context
I have documentation in ./docs/ that describes the features I want to build.
I want you to use Mothership to create a complete Linear project structure.

## Instructions

1. **Verify Setup**
   - Run `linear whoami` to confirm authentication
   - Run `./mothership.sh doctor` to verify Mothership
   - Read `.mothership/config.json` for team settings

2. **Read Documentation**
   - Read ALL files in `./docs/`
   - Identify: Features, Phases, User Stories, Acceptance Criteria

3. **Create Linear Structure**
   - Create Project for the feature
   - Create Milestones for each phase
   - Create Issues for each user story with:
     - "User can [verb] [noun]" title format
     - Acceptance criteria as checkboxes
     - Expected file paths
     - Testing requirements
     - State: "Ready"
   - Create Quality Gate issue at end of each milestone

4. **Quality Gates Must Include**
   - TypeScript passes
   - Lint passes
   - Unit tests pass
   - Integration tests pass (per milestone)
   - Security audit passes
   - E2E tests pass (final milestone only)

5. **Update State**
   - Write checkpoint to `.mothership/checkpoint.md`
   - Log progress to `.mothership/progress.md`

6. **Signal Completion**
   - Output: `<mothership>PLANNED:[count]</mothership>`

## Requirements
- ONE deliverable per issue (one component, one function, one route)
- Keep issues small (20-30 min of work each)
- All acceptance criteria must be testable (pass/fail)
- Include quality gates at milestone boundaries
- Note dependencies between issues

## After Planning
I will run:
- `./mothership.sh build 50` to implement
- `./mothership.sh test 50` to add tests
- `./mothership.sh review` for final check
```

---

## Verify Your Setup

After planning completes, verify:

```bash
# Check project was created
linear project list --team YOUR_TEAM

# Check issues
linear issue list --project "Your Feature - v1" --state "Ready"

# Check checkpoint
cat .mothership/checkpoint.md

# Check progress log
cat .mothership/progress.md
```

---

## Common Issues

| Problem | Solution |
|---------|----------|
| `linear: command not found` | Run `npm install -g @linear/cli` |
| `Not authenticated` | Run `linear auth` |
| `Team not found` | Check team key with `linear team list` |
| `No docs found` | Create `./docs/feature.md` with your requirements |
| `BLOCKED signal` | Check `.mothership/progress.md` for error details |

---

## Files Reference

| File | Purpose |
|------|---------|
| `prompts/full-linear-setup-prompt.md` | Complete planning prompt |
| `prompts/docs-template.md` | Template for writing docs |
| `.mothership/config.json` | Your configuration |
| `.mothership/checkpoint.md` | Current state |
| `.mothership/codebase.md` | Project patterns |
| `.mothership/progress.md` | Execution log |
| `./docs/*.md` | Your feature documentation |
