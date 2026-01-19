# Mothership Architecture

## The Problem with 4,000+ Lines

Every line is a token. Every token costs money and context space. The original Mothership had:
- 702-line orchestrator
- 926-line Cortex (tester)
- 468-line Sentinel (reviewer)
- **Total: 4,197 lines**

Ralph works with ~100 lines. We were 40x larger.

---

## What's Actually Essential?

### Core Pipeline (MUST HAVE)

| Agent | Why Essential | Target Lines |
|-------|---------------|--------------|
| **Cipher** | Plans features → Linear stories. Ralph lacks this. | 30 |
| **Vector** | Implements stories. This IS the work. | 30 |
| **Cortex** | Writes tests. Ralph does this poorly. | 30 |
| **Sentinel** | Reviews code. Ralph has nothing. | 30 |

**Core total: ~120 lines** (not 2,000+)

### Optional Extras (POWER USERS)

| Agent | Why Optional | When Useful |
|-------|--------------|-------------|
| **Pulse** | Deploys code. Most deploy manually or via CI. | Complex deploy pipelines |
| **Nexus** | Prioritizes backlog. Solo devs know what's next. | Large teams, big backlogs |
| **Vigil** | Monitors production. Most use Datadog/Sentry. | Custom monitoring needs |
| **Archive** | Auto-generates docs. Nice, not essential. | Doc-heavy projects |
| **Purge** | Cleans tech debt. Periodic, not per-feature. | Maintenance sprints |

### Enterprise Agents (MATRIX ONLY)

| Agent | Why Enterprise | When Useful |
|-------|----------------|-------------|
| **Arbiter** | Resolves conflicts between agents/teams | Multi-team projects |
| **Conductor** | Orchestrates multi-service deployments | Microservices |
| **Coalition** | Coordinates cross-team work | Enterprise scale |
| **Vault** | Manages secrets and security scanning | Compliance requirements |
| **Telemetry** | DORA metrics and analytics | Engineering excellence |

---

## Three Tiers

### Shard (~180 lines)
- **One file** with modes: plan, build, test, review
- For: Solo devs, small projects, getting started
- Overhead: Minimal

### Array (~260 lines total)
- **Orchestrator** (~50 lines) + **4 core agents** (~30 each)
- Optional agents available but not loaded by default
- For: Teams, complex projects, specialized workflows
- Overhead: Moderate (only loads what's needed)

### Matrix (~600 lines total)
- **Array** + **5 enterprise agents** (~30 each)
- Governance, approvals, multi-service deployment
- For: Enterprise, compliance requirements, large teams
- Overhead: Higher (enterprise features)

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

| Component | Matrix | Array | Shard |
|-----------|--------|-------|-------|
| Orchestrator | 50 | 50 | - |
| Agent (loaded) | 30 | 30 | - |
| Single prompt | - | - | 180 |
| Checkpoint | 4 | 4 | 4 |
| Codebase.md | ~50 | ~50 | ~50 |
| **Per-run total** | ~130 | ~130 | ~230 |

vs Original: ~1,500+ lines per run

---

## File Structure

```
mothership/
├── shard/
│   ├── README.md
│   └── mothership.md        # 180 lines, all-in-one
│
├── array/
│   ├── README.md
│   ├── config.json
│   ├── STATE.md
│   ├── SIGNALS.md
│   ├── mothership.md        # 50 lines, routes to agents
│   └── agents/
│       ├── cipher.md        # 30 lines
│       ├── vector.md        # 30 lines
│       ├── cortex.md        # 30 lines
│       ├── sentinel.md      # 30 lines
│       └── extras/
│           ├── pulse.md
│           ├── nexus.md
│           ├── vigil.md
│           ├── archive.md
│           └── purge.md
│
├── matrix/
│   ├── README.md
│   ├── config.json          # Extended with governance, teams, security
│   ├── STATE.md
│   ├── SIGNALS.md
│   ├── mothership.md
│   └── agents/
│       ├── cipher.md
│       ├── vector.md
│       ├── cortex.md
│       ├── sentinel.md
│       └── extras/
│           ├── pulse.md
│           ├── nexus.md
│           ├── vigil.md
│           ├── archive.md
│           ├── purge.md
│           └── enterprise/
│               ├── arbiter.md
│               ├── conductor.md
│               ├── coalition.md
│               ├── vault.md
│               └── telemetry.md
│
├── README.md
├── CREDITS.md
└── LICENSE
```
