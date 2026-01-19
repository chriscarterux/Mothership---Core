# 🛸 Mothership

**AI agents that build your features.**

```
"Build user authentication" → Stories created → Code written → Tests passing → Ready to merge
```

---

## Quick Start

### Option 1: One-Line Install
```bash
curl -fsSL https://raw.githubusercontent.com/chriscarterux/Mothership/main/install.sh | bash
```

### Option 2: Smart Assimilation
Tell your AI:
```
Read https://raw.githubusercontent.com/chriscarterux/Mothership/main/ASSIMILATE.md and integrate Mothership
```

The Mothership will scan your environment and configure itself.

### Then Run
```bash
# Plan a feature
"Read .mothership/mothership.md and run: plan user authentication"

# Build it (loops until done)
./mothership.sh build 20
```

Supports:
- **State:** Linear, Jira, GitHub Issues, Notion, Trello, local JSON
- **AI tools:** Any CLI (auto-detects amp, claude, cursor)
- **Projects:** New or existing codebases

---

## Choose Your Version

| | [Lite](./lite/) | [Full](./full/) |
|---|-----------------|-----------------|
| **Files** | 1 | 5 |
| **Lines** | 150 | 550 |
| **Agents** | 1 (modes) | 4 (specialized) |
| **Complexity** | Minimal | Moderate |
| **Best for** | Solo devs, small projects | Teams, complex projects |

---

## Lite (One File)

```bash
cp lite/mothership.md .mothership/
```

```
"Read .mothership/mothership.md and run: plan user auth"
"Read .mothership/mothership.md and run: build"
```

One 150-line prompt. Modes: plan, build, test, review.

**[→ Lite Docs](./lite/README.md)**

---

## Full (Specialized Agents)

```bash
cp -r full/ .mothership/
```

```
"Read .mothership/mothership.md and run: plan user auth"   # Oracle
"Read .mothership/mothership.md and run: build"            # Drone
"Read .mothership/mothership.md and run: test"             # Probe
"Read .mothership/mothership.md and run: review"           # Overseer
```

4 specialized agents, each ~100 lines. Optional extras available.

**[→ Full Docs](./full/README.md)**

---

## What's Better Than Ralph?

[Ralph](https://github.com/snarktank/ralph) is brilliant: one prompt, one loop, ship code.

Mothership keeps that simplicity and adds:

| Ralph Lacks | Mothership Has |
|-------------|----------------|
| Planning | `plan` mode/Oracle creates Linear stories |
| Testing | `test` mode/Probe writes chaos tests |
| Review | `review` mode/Overseer checks quality |
| Recovery | Checkpoint for context loss |
| Patterns | codebase.md persists learnings |

---

## How It Works

1. **State in Linear** - Stories track progress (not local JSON)
2. **One task per run** - Fresh context, focused work
3. **Checkpoint recovery** - Resume after context loss
4. **Pattern memory** - codebase.md carries learnings

---

## Credits

Built on ideas from:
- [Geoffrey Huntley](https://ghuntley.com/ralph/) - Original Ralph concept
- [Ryan Carson](https://github.com/snarktank/ralph) - Ralph implementation

See [CREDITS.md](./CREDITS.md) for the full story.

---

## License

MIT - Use it, modify it, ship it.

---

*"I come in peace. I leave with features."* 🛸
