# Documentation Template for Mothership Planning

> Use this template to structure your `./docs/` folder before running Mothership planning

---

## File Structure

```
docs/
├── README.md           # Overview and navigation
├── feature-name.md     # Main feature spec
├── technical-spec.md   # Technical requirements (optional)
└── api-spec.md         # API contracts (optional)
```

---

## Template: docs/README.md

```markdown
# [Project Name] Documentation

## Overview
[2-3 sentences describing what this project/feature does and why it exists]

## Tech Stack
- **Framework:** [e.g., Next.js 14 App Router]
- **Database:** [e.g., Convex]
- **Auth:** [e.g., Convex Auth, Clerk, NextAuth]
- **Styling:** [e.g., Tailwind CSS + shadcn/ui]
- **Testing:** [e.g., Vitest, Jest, Playwright]

## Features
- [Feature 1](./feature-1.md)
- [Feature 2](./feature-2.md)

## Architecture Decisions
- [Decision 1]: [Rationale]
- [Decision 2]: [Rationale]
```

---

## Template: docs/[feature-name].md

```markdown
# [Feature Name]

## Overview
[What this feature does, who it's for, and why it matters]

## User Journey
1. User [first action]
2. System [responds with]
3. User [next action]
4. ...

---

## Phase 1: [Foundation/Setup]

### [Story 1 Title]
**As a** [user type]
**I want to** [action]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]

**Technical Notes:**
- [Implementation hint]
- [Pattern to follow]

**Files:**
- `path/to/expected/file.ts`

---

### [Story 2 Title]
**As a** [user type]
**I want to** [action]
**So that** [benefit]

**Acceptance Criteria:**
- [ ] [Criterion]
- [ ] [Criterion]

**Dependencies:**
- Requires: [Story 1 Title]

---

## Phase 2: [Core Features]

### [Story 3 Title]
...

---

## Phase 3: [Integration]

### [Story N Title]
...

---

## Phase 4: [Polish & Quality]

### Integration Testing
- [ ] [Integration test scenario 1]
- [ ] [Integration test scenario 2]

### Security Review
- [ ] Auth checks on all protected routes
- [ ] Input validation on all forms
- [ ] No secrets in client code

### E2E Testing
- [ ] Complete user journey works
- [ ] Error states handled gracefully
- [ ] Loading states display correctly

---

## Out of Scope
- [What we're explicitly NOT building]
- [Feature that might seem related but isn't included]

## Future Considerations
- [Things to think about for v2]
- [Known limitations to address later]

## Open Questions
- [ ] [Question that needs answering before/during implementation]
```

---

## Template: Convex-Specific Feature Doc

```markdown
# [Convex Feature Name]

## Overview
[Description]

---

## Phase 1: Data Layer

### Define [Entity] Schema
**Acceptance Criteria:**
- [ ] Schema defined in `convex/schema.ts`
- [ ] Fields: [list all fields with types]
- [ ] Indexes: [list required indexes]
- [ ] Relations: [list foreign keys / references]

**Schema Definition:**
```typescript
// convex/schema.ts
export default defineSchema({
  [entity]: defineTable({
    field1: v.string(),
    field2: v.number(),
    userId: v.id("users"),
    createdAt: v.number(),
  })
    .index("by_user", ["userId"])
    .index("by_created", ["createdAt"]),
});
```

---

## Phase 2: Backend Functions

### Create [Entity] Mutation
**Acceptance Criteria:**
- [ ] Mutation in `convex/[entity].ts`
- [ ] Input validation with Convex validators
- [ ] Auth check: user must be logged in
- [ ] Returns created entity ID

**Function Signature:**
```typescript
export const create = mutation({
  args: {
    field1: v.string(),
    field2: v.number(),
  },
  handler: async (ctx, args) => {
    // Implementation
  },
});
```

---

### List [Entity] Query
**Acceptance Criteria:**
- [ ] Query in `convex/[entity].ts`
- [ ] Filters by current user
- [ ] Ordered by [field] descending
- [ ] Supports pagination (optional)

---

### Update [Entity] Mutation
**Acceptance Criteria:**
- [ ] Mutation in `convex/[entity].ts`
- [ ] Validates entity exists
- [ ] Validates user owns entity
- [ ] Partial update support

---

### Delete [Entity] Mutation
**Acceptance Criteria:**
- [ ] Mutation in `convex/[entity].ts`
- [ ] Validates entity exists
- [ ] Validates user owns entity
- [ ] Soft delete vs hard delete: [specify]

---

## Phase 3: Frontend Components

### [Entity] List Component
**Acceptance Criteria:**
- [ ] Uses `useQuery` for real-time data
- [ ] Shows loading skeleton while fetching
- [ ] Shows empty state when no data
- [ ] Shows error state on failure
- [ ] Each item shows: [list fields]

**File:** `components/[Entity]List.tsx`

---

### [Entity] Form Component
**Acceptance Criteria:**
- [ ] Form fields for: [list fields]
- [ ] Client-side validation
- [ ] Submit uses `useMutation`
- [ ] Shows loading state during submit
- [ ] Shows success/error feedback
- [ ] Clears form on success

**File:** `components/[Entity]Form.tsx`

---

### [Entity] Detail View
**Acceptance Criteria:**
- [ ] Fetches single entity by ID
- [ ] Shows all entity fields
- [ ] Edit button (if owner)
- [ ] Delete button with confirmation

**File:** `components/[Entity]Detail.tsx`

---

## Phase 4: Integration & Polish

### Real-time Updates
**Acceptance Criteria:**
- [ ] List updates automatically when data changes
- [ ] No manual refresh needed
- [ ] Optimistic updates for better UX (optional)

### Error Handling
**Acceptance Criteria:**
- [ ] Network errors show retry option
- [ ] Validation errors show field-level messages
- [ ] Auth errors redirect to login

### Loading States
**Acceptance Criteria:**
- [ ] Skeleton loaders for lists
- [ ] Spinner for mutations
- [ ] Disabled buttons during loading

---

## Testing Requirements

### Unit Tests
- [ ] Schema validation tests
- [ ] Mutation logic tests
- [ ] Query filter tests

### Integration Tests
- [ ] CRUD flow end-to-end
- [ ] Auth scenarios (logged in, logged out)
- [ ] Error scenarios

### E2E Tests
- [ ] Complete user journey
- [ ] Real-time update verification
```

---

## Tips for Writing Good Docs

1. **Be Specific**: "User can log in" is vague. "User can log in with email/password and see dashboard" is specific.

2. **Make AC Testable**: Every criterion should be verifiable as pass/fail.

3. **Include Files**: Listing expected file paths helps the AI follow patterns.

4. **Note Dependencies**: If Story B needs Story A, say so explicitly.

5. **Define Scope**: "Out of Scope" prevents feature creep.

6. **One Thing Per Story**: Each story = one component OR one function OR one route.

7. **Think in Phases**: Foundation → Core → Integration → Polish is a natural flow.

8. **Include Error Cases**: Don't just describe happy path. What happens when things fail?

---

## Quick Checklist Before Planning

- [ ] README.md exists with project overview
- [ ] At least one feature doc exists
- [ ] Each phase has 3-8 stories (not too few, not too many)
- [ ] Each story has clear acceptance criteria
- [ ] Dependencies between stories are noted
- [ ] Out of scope is defined
- [ ] Technical requirements are specified
- [ ] Testing requirements are included
