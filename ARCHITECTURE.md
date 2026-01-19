# Mothership Architecture

## The Problem with 4,000+ Lines

Every line is a token. Every token costs money and context space. The original Mothership had:
- 702-line orchestrator
- 926-line Probe (tester)
- 468-line Overseer (reviewer)
- **Total: 4,197 lines**

Ralph works with ~100 lines. We were 40x larger.

---

## What's Actually Essential?

### Core Pipeline (MUST HAVE)

| Agent | Why Essential | Target Lines |
|-------|---------------|--------------|
| **Oracle** | Plans features → Linear stories. Ralph lacks this. | 100 |
| **Drone** | Implements stories. This IS the work. | 100 |
| **Probe** | Writes tests. Ralph does this poorly. | 100 |
| **Overseer** | Reviews code. Ralph has nothing. | 100 |

**Core total: ~400 lines** (not 2,000+)

### Optional Extras (POWER USERS)

| Agent | Why Optional | When Useful |
|-------|--------------|-------------|
| **Beacon** | Deploys code. Most deploy manually or via CI. | Complex deploy pipelines |
| **Hivemind** | Prioritizes backlog. Solo devs know what's next. | Large teams, big backlogs |
| **Watcher** | Monitors production. Most use Datadog/Sentry. | Custom monitoring needs |
| **Scribe** | Auto-generates docs. Nice, not essential. | Doc-heavy projects |
| **Recycler** | Cleans tech debt. Periodic, not per-feature. | Maintenance sprints |

---

## Two Versions

### Mothership Lite (~150 lines)
- **One file** with modes: plan, build, test, review
- For: Solo devs, small projects, getting started
- Overhead: Minimal

### Mothership Full (~600 lines total)
- **Orchestrator** (~150 lines) + **4 core agents** (~100 each)
- Optional agents available but not loaded by default
- For: Teams, complex projects, specialized workflows
- Overhead: Moderate (only loads what's needed)

---

## Design Principles

### 1. Every Line Must Earn Its Place
- If the LLM knows it, don't write it
- If it's obvious, don't explain it
- If it's rare, make it optional

### 2. Trust the LLM
- Don't over-specify. LLMs know how to code.
- Focus on: what to do, constraints, signals
- Skip: how to write functions, basic patterns

### 3. Load Only What's Needed
- Orchestrator routes to ONE agent per run
- Agent prompts are standalone
- No agent needs to know about other agents

### 4. State is Simple
- Checkpoint: 4 lines, not YAML frontmatter
- Linear is the source of truth for stories
- Git is the source of truth for code

---

## Token Budget

| Component | Full | Lite |
|-----------|------|------|
| Orchestrator | 150 | - |
| Agent (loaded) | 100 | - |
| Single prompt | - | 150 |
| Checkpoint | 4 | 4 |
| Codebase.md | ~50 | ~50 |
| **Per-run total** | ~300 | ~200 |

vs Original: ~1,500+ lines per run

---

## File Structure

```
mothership/
├── lite/
│   ├── README.md
│   └── mothership.md        # 150 lines, all-in-one
│
├── full/
│   ├── README.md
│   ├── config.json
│   ├── install.sh
│   ├── mothership.md        # 150 lines, routes to agents
│   └── agents/
│       ├── oracle.md        # 100 lines
│       ├── drone.md         # 100 lines
│       ├── probe.md         # 100 lines
│       ├── overseer.md      # 100 lines
│       └── extras/          # Optional, load explicitly
│           ├── beacon.md
│           ├── hivemind.md
│           ├── watcher.md
│           ├── scribe.md
│           └── recycler.md
│
├── README.md                 # Choose your version
├── CREDITS.md
└── LICENSE
```
