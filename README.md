# 

```
    ███╗   ███╗ ██████╗ ████████╗██╗  ██╗███████╗██████╗ ███████╗██╗  ██╗██╗██████╗ 
    ████╗ ████║██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗██╔════╝██║  ██║██║██╔══██╗
    ██╔████╔██║██║   ██║   ██║   ███████║█████╗  ██████╔╝███████╗███████║██║██████╔╝
    ██║╚██╔╝██║██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗╚════██║██╔══██║██║██╔═══╝ 
    ██║ ╚═╝ ██║╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║███████║██║  ██║██║██║     
    ╚═╝     ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝     
                                    👽 v1.0.0
```

> **"I come in peace. I leave with features."**

---

## What Is This?

Mothership is an **AI agent orchestration system** that plans and builds features autonomously. Point it at a feature request, and a coordinated fleet of specialized agents will analyze your codebase, decompose the work into stories, implement changes, write tests, review code, and deploy—all while you grab coffee or contemplate humanity's place in the universe.

---

## How It Works

```
                           "Build feature X"
                                  │
                                  ▼
                          ┌──────────────┐
                          │  MOTHERSHIP  │
                          │    👽 🛸     │
                          └──────┬───────┘
                                 │
       ┌─────────┬───────┬───────┼───────┬───────┬─────────┐
       │         │       │       │       │       │         │
       ▼         ▼       ▼       ▼       ▼       ▼         ▼
      🧠        🔮      🛠️      🔬      👁️      📡        ...
   Hivemind  Oracle   Drone   Probe  Overseer Beacon    
   
                    ┌─────────────────────┐
                    │   Feature Complete  │
                    │        ✨ 🎉        │
                    └─────────────────────┘
```

---

## 👽 The Agents

| Agent | Role | Catchphrase | Purpose |
|-------|------|-------------|---------|
| 🧠 **Hivemind** | Prioritizer | *"Calculates optimal targets"* | Analyzes backlog, prioritizes stories, decides what to abduct first |
| 🔮 **Oracle** | Planner | *"Foresees your architecture"* | Decomposes features into stories, predicts implementation paths |
| 🛠️ **Drone** | Implementer | *"Resistance is futile"* | Writes the actual code. Tireless. Relentless. Obedient. |
| 🔬 **Probe** | Tester | *"Probing for weaknesses"* | Writes tests, finds edge cases, exposes vulnerabilities |
| 👁️ **Overseer** | Reviewer | *"Always watching"* | Reviews code, enforces standards, judges without mercy |
| 📡 **Beacon** | Deployer | *"Signals Earth"* | Handles deployment, notifies humans, bridges worlds |
| 👀 **Watcher** | Monitor | *"Silent vigilance"* | Monitors systems post-deployment, detects anomalies |
| 📜 **Scribe** | Documentarian | *"Records for future civilizations"* | Writes docs, updates READMEs, preserves knowledge |
| ♻️ **Recycler** | Cleanup | *"Consumes dead code for fuel"* | Removes unused code, refactors cruft, tidies the ship |

---

## 🚀 Quick Start

### Installation

```bash
# Clone the mothership
git clone https://github.com/your-org/mothership.git
cd your-project

# Initialize the invasion
mothership init
```

### Configuration

Create `.mothership/config.json`:

```json
{
  "project": "your-project-name",
  "linearTeamId": "TEAM-123",
  "agents": {
    "hivemind": { "enabled": true },
    "oracle": { "enabled": true },
    "drone": { "enabled": true },
    "probe": { "enabled": true },
    "overseer": { "enabled": true },
    "beacon": { "enabled": true },
    "watcher": { "enabled": false },
    "scribe": { "enabled": true },
    "recycler": { "enabled": false }
  },
  "preferences": {
    "testFramework": "vitest",
    "deployTarget": "staging",
    "autoMerge": false
  }
}
```

### First Contact

```bash
# Check mothership status
mothership status

# Build a feature (the fun part)
mothership build "Add user authentication with OAuth2"

# Watch the invasion unfold
mothership status --watch
```

---

## 📟 Commands

| Command | Description |
|---------|-------------|
| `mothership status` | Display current mission status and agent states |
| `mothership build [feature]` | Initiate full autonomous build cycle for a feature |
| `mothership plan [feature]` | Have Oracle decompose feature into stories (no implementation) |
| `mothership implement` | Resume implementation from current checkpoint |
| `mothership test` | Run Probe to test current implementation |
| `mothership review` | Invoke Overseer for code review |
| `mothership deploy` | Signal Beacon to deploy current build |
| `mothership continue` | Resume mission from last checkpoint |
| `mothership reset` | Abort mission and reset all agent states |
| `mothership onboard` | Generate codebase analysis for new projects |

---

## 🔧 How It Works (For The Curious)

### State Management

Mothership uses **Linear as a state machine**. Each story represents a state, and agents transition stories through statuses:

```
Backlog → In Progress → In Review → Done
   │           │            │         │
   └── Hivemind picks ──────┘         │
               └── Drone implements ──┘
                          └── Overseer approves
```

Stories in Linear are the **source of truth**. The AI doesn't hallucinate state—it reads it.

### Context Recovery

Every agent writes to `.mothership/checkpoint.md` before signing off:

```markdown
## Last Checkpoint
- **Agent**: Drone
- **Story**: AUTH-42
- **Status**: Implementation 60% complete
- **Next Step**: Add token refresh logic
- **Files Modified**: src/auth/oauth.ts, src/api/middleware.ts
```

New sessions read the checkpoint and resume seamlessly. No context? No problem—the checkpoint remembers.

### Identity Lock

Agents have **identity lock**: they only do their job. Drone won't review code. Overseer won't write tests. This prevents the classic AI failure mode of *"Let me build you an entire agent infrastructure instead of your feature."*

Each agent prompt begins with:

```
You are [AGENT]. You ONLY do [SPECIFIC TASK]. 
You do NOT do anything else. When done, signal [NEXT_AGENT].
```

---

## 📁 File Structure

```
your-project/
├── .mothership/
│   ├── mothership.md          # Main orchestrator prompt
│   ├── config.json            # Agent configuration
│   ├── checkpoint.md          # Current mission state
│   ├── codebase.md            # Generated codebase analysis
│   └── agents/
│       ├── hivemind.md        # Prioritizer prompt
│       ├── oracle.md          # Planner prompt
│       ├── drone.md           # Implementer prompt
│       ├── probe.md           # Tester prompt
│       ├── overseer.md        # Reviewer prompt
│       ├── beacon.md          # Deployer prompt
│       ├── watcher.md         # Monitor prompt
│       ├── scribe.md          # Documentarian prompt
│       └── recycler.md        # Cleanup prompt
└── docs/
    └── ...
```

---

## 🛸 Workflow Example

```
Human: "Build a notification system"

🧠 Hivemind: "Scanning backlog... Notification system has highest 
              value/effort ratio. Target acquired."
              
🔮 Oracle:   "Decomposing into 4 stories:
              1. Notification data model
              2. Email provider integration  
              3. In-app notification component
              4. User preference settings"
              
🛠️ Drone:    "Story 1: Implementing Notification model...
              [writes code]
              Resistance is futile. Story complete."
              
🔬 Probe:    "Probing Notification model...
              Found edge case: null recipient handling.
              Test coverage: 94%. Weakness documented."
              
🛠️ Drone:    "Patching weakness... Done."

👁️ Overseer: "Reviewing changes... 
              Style: ✓ | Types: ✓ | Tests: ✓
              Approved. Proceed to next story."
              
[...continues until all stories complete...]

📡 Beacon:   "All stories complete. Deploying to staging...
              Signal sent. Humans notified. 
              The invasion was successful."
              
📜 Scribe:   "Documenting notification system...
              README updated. API docs generated.
              Future civilizations will understand."
```

---

## ⚙️ Agent Configuration

Enable or disable agents based on your workflow:

```json
{
  "agents": {
    "hivemind": { 
      "enabled": true,
      "autoSelect": true,
      "maxStoriesPerCycle": 5
    },
    "oracle": { 
      "enabled": true,
      "maxStoriesPerFeature": 10
    },
    "drone": { 
      "enabled": true,
      "maxFilesPerCommit": 20
    },
    "probe": { 
      "enabled": true,
      "coverageThreshold": 80
    },
    "overseer": { 
      "enabled": true,
      "strictMode": false
    },
    "beacon": { 
      "enabled": true,
      "autoDeployTo": "staging"
    },
    "watcher": { 
      "enabled": false 
    },
    "scribe": { 
      "enabled": true,
      "autoUpdateReadme": true
    },
    "recycler": { 
      "enabled": false,
      "aggressiveness": "conservative"
    }
  }
}
```

---

## 📡 Signal Reference

Agents communicate via **signals**—specific phrases that trigger handoffs:

| Agent | Outbound Signal | Triggers |
|-------|-----------------|----------|
| 🧠 Hivemind | `SIGNAL:ORACLE:PLAN` | Oracle to plan selected story |
| 🧠 Hivemind | `SIGNAL:COMPLETE:NO_TARGETS` | No stories to process |
| 🔮 Oracle | `SIGNAL:DRONE:IMPLEMENT` | Drone to start implementation |
| 🔮 Oracle | `SIGNAL:HIVEMIND:NEEDS_DECOMP` | Story too large, needs breakdown |
| 🛠️ Drone | `SIGNAL:PROBE:TEST` | Probe to write/run tests |
| 🛠️ Drone | `SIGNAL:OVERSEER:REVIEW` | Ready for code review |
| 🛠️ Drone | `SIGNAL:DRONE:BLOCKED` | Implementation blocked, needs help |
| 🔬 Probe | `SIGNAL:DRONE:FIX` | Tests failed, Drone must fix |
| 🔬 Probe | `SIGNAL:OVERSEER:READY` | Tests pass, ready for review |
| 👁️ Overseer | `SIGNAL:DRONE:REVISE` | Code needs changes |
| 👁️ Overseer | `SIGNAL:BEACON:DEPLOY` | Approved, ready to deploy |
| 👁️ Overseer | `SIGNAL:HIVEMIND:NEXT` | Story complete, get next target |
| 📡 Beacon | `SIGNAL:WATCHER:MONITOR` | Deployed, start monitoring |
| 📡 Beacon | `SIGNAL:SCRIBE:DOCUMENT` | Document the changes |
| 📡 Beacon | `SIGNAL:COMPLETE:DEPLOYED` | Mission accomplished |
| 👀 Watcher | `SIGNAL:DRONE:HOTFIX` | Anomaly detected, needs fix |
| 📜 Scribe | `SIGNAL:COMPLETE:DOCUMENTED` | Documentation complete |
| ♻️ Recycler | `SIGNAL:PROBE:VERIFY` | Verify cleanup didn't break anything |

---

## 🔧 Troubleshooting

### "AI is building agent infrastructure instead of my feature"

**Symptom**: You asked for a login page. AI is creating `AgentOrchestrator.ts`.

**Cause**: Identity lock failure or unclear instructions.

**Fix**: 
```bash
mothership reset
# Edit .mothership/agents/drone.md to reinforce:
# "You implement THE FEATURE, not agent tooling."
mothership continue
```

### Context lost mid-task

**Symptom**: New session doesn't know what was happening.

**Fix**:
```bash
# Check the checkpoint
cat .mothership/checkpoint.md

# If empty or stale, manually update:
echo "## Last Checkpoint
- Agent: Drone  
- Story: AUTH-42
- Status: In Progress
- Next Step: Continue OAuth implementation" > .mothership/checkpoint.md

mothership continue
```

### Stories are too big / AI is overwhelmed

**Symptom**: Oracle created a 47-point story. Drone is crying.

**Fix**:
```json
// In config.json, limit story scope:
{
  "oracle": {
    "maxStoriesPerFeature": 5,
    "maxPointsPerStory": 3,
    "enforceAtomicStories": true
  }
}
```

Then re-plan:
```bash
mothership plan "Your feature" --decompose
```

### Agent stuck in loop

**Symptom**: Drone and Probe keep signaling each other forever.

**Fix**:
```bash
# Check for conflicting requirements
cat .mothership/checkpoint.md

# Force advance to next stage
mothership review --force
```

---

## 🌌 Philosophy

Traditional development:
```
Human thinks → Human plans → Human codes → Human tests → Human reviews → Human deploys
              ↑_______________________________________________|
                        (repeat until mass extinction)
```

Mothership development:
```
Human thinks → Mothership does everything else → Human approves → 🎉
```

I believe developers should focus on **what** to build, not **how** to build it. The Mothership handles the how. You handle the what and the why.

---

## 🤝 Contributing

I welcome contributions from all species. Please read the [Contributing Guide](./CONTRIBUTING.md) before submitting pull requests.

```bash
# Run tests before submitting
mothership test --self

# The Probe will judge you
```

---

## 📜 License

MIT License - See [LICENSE](./LICENSE)

*Use freely. Build boldly. Phone home occasionally.*

---

## 👽 Credits & Inspiration

Mothership evolved from the **Ralph pattern** pioneered by brilliant minds in the AI coding community:

### 🎩 Geoffrey Huntley
Creator of the original [Ralph concept](https://ghuntley.com/ralph/) - the insight that a simple bash loop running an AI agent repeatedly can accomplish complex tasks through "eventual consistency." His philosophy that "LLMs are mirrors of operator skill" shaped my approach.

### 🚀 Ryan Carson  
Built the popular [snarktank/ralph](https://github.com/snarktank/ralph) implementation that made the pattern accessible. His prd.json + progress.txt + prompt.md architecture proved the concept works in production.

### Why Mothership?

After using Ralph extensively, I loved the core loop but wanted:
- **Specialized agents** (not one agent doing everything)
- **Linear integration** (not local JSON files)
- **Structured checkpoints** (for precise recovery)
- **Identity locks** (AI kept trying to "build Ralph" instead of being Ralph)
- **10X capabilities** (security scans, chaos tests, staged deploys)

**Ralph = one brilliant agent in a loop.**
**Mothership = a fleet of specialized agents in a pipeline.**

See [CREDITS.md](./CREDITS.md) for the full story of what I learned and how Mothership differs.

---

<div align="center">

**🛸 The truth is out there. The code is in here. 🛸**

[Documentation](./docs) · [Report Bug](./issues) · [Request Feature](./issues)

*"In space, no one can hear you `git push --force`"*

</div>
