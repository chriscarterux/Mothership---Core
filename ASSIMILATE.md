# 🛸 ASSIMILATE

> Quick setup for any project. Just answer 3 questions.

---

## Quick Start

Tell your AI:
```
Read https://raw.githubusercontent.com/chriscarterux/Mothership/main/ASSIMILATE.md and integrate Mothership
```

Or run the installer:
```bash
curl -fsSL https://raw.githubusercontent.com/chriscarterux/Mothership/main/install.sh | bash
```

---

## What Happens

### 1. Scan (Automatic)

Mothership detects your environment:
- **Project type:** Node.js, Rust, Go, Python
- **AI tool:** AMP, Claude, Cursor, Aider
- **State system:** Linear, Jira, GitHub Issues

### 2. Configure (3 Questions)

Only asks what it can't detect:

| Question | Options | Default |
|----------|---------|---------|
| **State backend** | linear, jira, github, notion, trello, json | json |
| **Tier** | shard (1 file), array (4 agents), matrix (enterprise) | shard |
| **Docs path** | Where are feature docs? | ./docs |

**Example response:** `json, shard, ./docs`

### 3. Setup (Automatic)

Creates:
```
.mothership/
├── mothership.md    # Agent instructions
├── config.json      # Your settings
└── codebase.md      # Detected patterns
```

---

## Defaults

Say "use defaults" to skip questions:
- State: `json` (local file)
- Tier: `shard` (simplest)
- Docs: `./docs`

---

## State Backends

| Backend | Best For | Setup Required |
|---------|----------|----------------|
| **json** | Solo devs, quick start | None |
| **github** | Open source projects | Repo detected |
| **linear** | Teams, sprints | Team ID |
| **jira** | Enterprise | Project + URL |
| **notion** | Documentation-heavy | Database ID |
| **trello** | Visual boards | Board ID |

---

## After Setup

```bash
# Plan a feature
./mothership.sh plan "user authentication"

# Build it (loops until done)
./mothership.sh build 20

# Run tests
./mothership.sh test

# Review code
./mothership.sh review
```

---

## Troubleshooting

**"No AI tool found"**
→ Install amp, claude, cursor, or aider CLI, or set `AI_TOOL=your-cli`

**"No .mothership/ directory"**
→ Run the installer or create manually

**"Stories not updating"**
→ Check config.json has correct state backend credentials

---

*"Your project has been assimilated."* 🛸
