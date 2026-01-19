[![GitHub stars](https://img.shields.io/github/stars/chriscarterux/Mothership?style=social)](https://github.com/chriscarterux/Mothership)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/chriscarterux/Mothership/pulls)

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
- **AI tools:** Any CLI (auto-detects claude, cursor, aider)
- **Projects:** New or existing codebases

---

## ✨ Features

- **🔮 Auto-Planning** - Oracle reads your docs, creates stories automatically
- **🔁 Loop Until Done** - Fresh context each iteration, never loses track
- **🔬 Chaos Testing** - Probe finds edge cases you'd never think of
- **👁️ Code Review** - Overseer checks before merge
- **🌐 Browser Verification** - Drone validates UI with Playwright
- **🔌 Any AI Tool** - Works with Claude, Cursor, GPT-4, and more
- **📊 Any Tracker** - Linear, Jira, GitHub Issues, Notion, Trello, or JSON
- **⚡ One-Line Install** - `curl | bash` and you're ready
- **🤖 GitHub Action** - Run in CI/CD pipelines
- **📋 Skills** - plan/ and stories/ skills for easy onboarding

---

## 💰 Token Economics

Mothership prompts are **obsessively optimized**. Every line earns its place.

| Metric | Lite | Full | Verbose Alternative |
|--------|------|------|---------------------|
| **Tokens/run** | ~1,100 | ~1,000 | ~4,000+ |
| **Cost/run*** | $0.003 | $0.003 | $0.012+ |
| **20 iterations** | $0.06 | $0.06 | $0.24+ |
| **100 iterations** | $0.30 | $0.30 | $1.20+ |

<sub>*Based on Claude Sonnet input pricing ($3/1M tokens). Output costs additional.</sub>

**How we do it:**
- Symbol compression (`∅` = empty, `→` = then)
- Zero redundancy (LLMs already know how to code)
- Dynamic loading (only the agent you need)
- Shared state reference (one `STATE.md`, not duplicated everywhere)

**Your savings over 1,000 builds: ~$9** (or mass with GPT-4/Claude Opus)

---

## Choose Your Version

| | [Lite](./lite/) | [Full](./full/) |
|---|-----------------|-----------------|
| **Files** | 1 | 5 |
| **Lines** | ~180 | ~250 |
| **Tokens/run** | ~1,100 | ~1,000 |
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

~180 lines, ~1,100 tokens. Modes: plan, build, test, review.

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

4 specialized agents, ~30 lines each. ~1,000 tokens per run.

**[→ Full Docs](./full/README.md)**

---

## What's Better Than Ralph?

[Ralph](https://github.com/snarktank/ralph) is brilliant: one prompt, one loop, ship code.

Mothership keeps that simplicity and adds:

| Ralph Lacks | Mothership Has |
|-------------|----------------|
| Planning | `plan` mode/Oracle creates stories |
| Testing | `test` mode/Probe writes chaos tests |
| Review | `review` mode/Overseer checks quality |
| Recovery | Checkpoint for context loss |
| Patterns | codebase.md persists learnings |
| GitHub Action | CI/CD integration out of the box |
| Multi-backend | 6 state adapters (not just JSON) |

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

## Contributing

PRs welcome. See [CONTRIBUTING.md](./CONTRIBUTING.md).

**Marketing & Launch:** See [marketing/](./marketing/) for launch materials, video script, and roadmap.

---

## License

MIT - Use it, modify it, ship it.

---

*"I come in peace. I leave with features."* 🛸
