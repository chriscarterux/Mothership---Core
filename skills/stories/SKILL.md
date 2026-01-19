# Stories Skill

Convert a feature spec into executable stories.

## Usage

```
Use the stories skill to break down docs/user-auth.md into stories
```

## Process

1. Read the feature spec

2. Break into small, atomic stories:
   - Each story = ONE component/route/function
   - ~15-30 min of coding each
   - Clear acceptance criteria

3. Generate stories.json:

```json
{
  "feature": "User Authentication",
  "branch": "feat/user-auth",
  "stories": [
    {
      "id": "1",
      "title": "User can see login form",
      "priority": 1,
      "status": "ready",
      "ac": [
        "Form has email input",
        "Form has password input",
        "Form has submit button",
        "Accessible at /login"
      ],
      "files": ["app/login/page.tsx"]
    }
  ]
}
```

4. Save to `.mothership/stories.json`

5. Output: "Created [N] stories. Run: mothership build"

## Story Sizing

✅ Right-sized:
- Create one page/route
- Add one component
- Add one API endpoint
- Add form validation

❌ Too big (split):
- "Build the dashboard"
- "Add authentication"
- "Create the API"
