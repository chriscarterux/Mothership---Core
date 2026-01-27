# Mothership

**The autonomous loop that plans, builds, tests, and reviews. One story at a time. Ship it.**

```bash
./m plan "user authentication"    # Create stories
./m build                         # Build next story
./m quick-check                   # Verify it works
```

## Quick Start

```bash
# Clone
git clone https://github.com/chriscarterux/Mothership.git
cd Mothership

# Run
./m status                        # See current state
./m plan "your feature"           # Start planning
./m build                         # Build one story
```

## Entry Points

Choose your style:

| Command | Lines | Description |
|---------|-------|-------------|
| `./m` | 218 | Minimal CLI - quick commands |
| `./ship` | 260 | Structured flow with prompts |
| `./mothership` | 1473 | Full system with context generation |
| `./x` | 55 | Ultra-minimal (entire system in 55 lines) |

All entry points share the same core loop: **plan → build → test → review**.

## Core Workflow

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│   PLAN ──────► BUILD ──────► TEST ──────► REVIEW       │
│   (Cipher)    (Vector)      (Cortex)     (Sentinel)    │
│                                                         │
│   One story per iteration. Fresh context each time.    │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Commands

### Core Modes (AI-powered)

| Command | Agent | Description |
|---------|-------|-------------|
| `./m plan` | Cipher | Create atomic stories from feature description |
| `./m build` | Vector | Implement one story with verification |
| `./m test` | Cortex | Run tests, fix failures |
| `./m review` | Sentinel | Check quality, security, gaps |
| `./m status` | - | Show current progress |

### Verification Modes (Scripts)

| Command | Description |
|---------|-------------|
| `./m quick-check` | Fast build/lint sanity check |
| `./m verify [type]` | Runtime wiring check (ui/api/database) |
| `./m test-matrix` | 8-layer test coverage |
| `./m pre-deploy` | Pre-deployment verification |
| `./m health-check` | Test all integrations |

### Context Generation

```bash
./mothership onboard              # Generate context files
```

Creates:
- `CLAUDE.md` - Context for Claude Code
- `GEMINI.md` - Context for Gemini
- `CODEX.md` - Context for Codex
- `AGENTS.md` - All 10 agents documented
- `.mothership/skills/` - Stack-specific skills

## Verification Scripts

Built-in scripts catch issues before they reach production:

```
scripts/
├── check-api.sh           # API endpoint validation
├── check-database.sh      # Database connectivity & migrations
├── check-deploy.sh        # Pre-deployment checklist
├── check-integrations.sh  # Third-party service checks
├── check-wiring.sh        # UI handler verification
└── verify-all.sh          # Run everything
```

## Slash Commands (Claude Code)

If using Claude Code, these commands are available:

| Command | Description |
|---------|-------------|
| `/mothership-plan` | Create stories with Cipher |
| `/mothership-build` | Implement with Vector |
| `/mothership-test` | Test with Cortex |
| `/mothership-prd` | Research-driven PRD discovery |
| `/mothership-verify` | Runtime verification |
| `/mothership-quick-check` | Fast sanity check |

## File Structure

```
.mothership/
├── 1-prd.md         # Product requirements
├── 2-specs.md       # Technical specs
├── 3-stories.md     # Atomic stories
├── checkpoint.md    # Current state
└── codebase.md      # Project context

scripts/             # Verification scripts
skills/              # AI-agnostic skill files
adapters/            # Multi-AI adapter
```

## Agents

| Agent | Role | Signal |
|-------|------|--------|
| **Cipher** | Planning - decodes requirements into stories | `<cipher>PLANNED:N</cipher>` |
| **Vector** | Building - implements with verification | `<vector>BUILT:ID</vector>` |
| **Cortex** | Testing - runs tests, fixes failures | `<cortex>TESTED</cortex>` |
| **Sentinel** | Review - checks quality and security | `<sentinel>APPROVED</sentinel>` |

## Multi-AI Support

Works with any AI CLI tool:

- **Claude Code** (recommended)
- **Gemini**
- **Codex**
- **OpenCode**

The system auto-detects which tool is available.

## Token Efficiency

Verify token usage yourself:

```bash
./mothership benchmark

  mothership.md              898 tokens
  checkpoint.md               32 tokens
  codebase.md                156 tokens
  ─────────────────────────────────────
  TOTAL PER RUN            1,086 tokens
```

## GitHub Actions

Automated verification on every push:

```yaml
# .github/workflows/mothership-verify.yml
- Quick Check (build/lint)
- Test Matrix (unit/integration/e2e)
- Security Scan
- Docker Build
- Accessibility Check
```

## License

MIT

## Credits

Built on ideas from [Geoffrey Huntley](https://ghuntley.com/ralph/) and [Ryan Carson](https://github.com/snarktank/ralph).
