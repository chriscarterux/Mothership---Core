# Linear Adapter

## Setup

### Authentication
```bash
# Option 1: Linear CLI (recommended)
npm install -g @linear/cli
linear auth

# Option 2: API Key (for scripts)
# Get from: Linear → Settings → API → Personal API keys
export LINEAR_API_KEY="lin_api_..."
```

### Config
In `config.json`:
```json
{
  "state": "linear",
  "linear": {
    "team": "ENG",
    "workspace": "your-workspace"
  }
}
```

## Hierarchy Mapping

| Docs Structure | Linear Entity | Purpose |
|----------------|---------------|---------|
| Feature/Epic | **Project** | Groups related work |
| Major section | **Milestone** | Release target |
| User story | **Issue** | Deliverable unit |
| Acceptance criteria | **Sub-issue** | Testable task |

## CLI Commands

### Create Project
```bash
linear project create \
  --name "User Authentication" \
  --team ENG \
  --description "OAuth, sessions, password reset"
```

### Create Milestone
```bash
linear milestone create \
  --name "v1.0 - Core Auth" \
  --project "User Authentication" \
  --targetDate "2024-02-01"
```

### Create Issue (Story)
```bash
linear issue create \
  --team ENG \
  --project "User Authentication" \
  --milestone "v1.0 - Core Auth" \
  --title "User can log in with email/password" \
  --description "## Acceptance Criteria
- [ ] Form accepts email + password
- [ ] Invalid credentials show error
- [ ] Valid credentials redirect to dashboard

## Files
- src/routes/login.tsx
- src/api/auth.ts" \
  --state "Ready" \
  --priority 2
```

### Create Sub-issue (AC item)
```bash
linear issue create \
  --team ENG \
  --parent "AUTH-123" \
  --title "Form accepts email + password" \
  --state "Ready"
```

### List Issues
```bash
# By project
linear issue list --project "User Authentication" --state "Ready"

# By milestone
linear issue list --milestone "v1.0 - Core Auth"

# Get next ready issue
linear issue list --state "Ready" --limit 1 --json
```

### Update Issue Status
```bash
# Start work
linear issue update AUTH-123 --state "In Progress"

# Complete
linear issue update AUTH-123 --state "Done"

# Block
linear issue update AUTH-123 --state "Blocked" \
  --comment "Blocked: waiting on API design"
```

### Add Comment
```bash
linear comment create AUTH-123 \
  --body "Implemented login form. Tests passing."
```

## API Alternative

If CLI unavailable, use GraphQL API:

### Create Issue
```bash
curl -X POST https://api.linear.app/graphql \
  -H "Authorization: $LINEAR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "mutation { issueCreate(input: { teamId: \"TEAM_ID\", title: \"User can log in\", description: \"AC here\", stateId: \"STATE_ID\", projectId: \"PROJECT_ID\" }) { issue { id identifier } } }"
  }'
```

### Get Team/State IDs
```bash
# Get teams
curl -X POST https://api.linear.app/graphql \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{"query": "{ teams { nodes { id name key } } }"}'

# Get workflow states
curl -X POST https://api.linear.app/graphql \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{"query": "{ workflowStates { nodes { id name } } }"}'
```

## Doc → Linear Flow

When Cipher reads `./docs/`:

1. **Identify feature** → Create Project
2. **Find milestones/phases** → Create Milestones
3. **Extract user stories** → Create Issues under Milestone
4. **Parse AC items** → Create Sub-issues (optional)

### Example Mapping

**Input doc:**
```markdown
# User Authentication

## Phase 1: Basic Login
- User can log in with email/password
- User can reset password via email

## Phase 2: OAuth
- User can log in with Google
- User can log in with GitHub
```

**Output in Linear:**
```
Project: User Authentication
├── Milestone: Phase 1 - Basic Login
│   ├── Issue: User can log in with email/password
│   └── Issue: User can reset password via email
└── Milestone: Phase 2 - OAuth
    ├── Issue: User can log in with Google
    └── Issue: User can log in with GitHub
```

## Status Mapping

| Mothership | Linear State |
|------------|--------------|
| ready | Ready / Backlog |
| in_progress | In Progress |
| done | Done / Completed |
| blocked | Blocked |

## Labels (Optional)

```bash
# Add labels for categorization
linear issue update AUTH-123 --label "frontend"
linear issue update AUTH-123 --label "auth"
```

## Verification

Check auth and team access:
```bash
linear whoami
linear team list
linear project list --team ENG
```
