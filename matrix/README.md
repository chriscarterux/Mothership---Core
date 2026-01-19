# Mothership Matrix (Enterprise)

> *The interconnected grid. Enterprise-grade orchestration.*

Matrix extends Array with enterprise capabilities: multi-agent conflict resolution, complex deployment orchestration, multi-team coordination, secrets management, and advanced analytics.

## When to Use Matrix

| Scenario | Use Matrix? |
|----------|-------------|
| Multi-service deployments | Yes |
| Team approval workflows | Yes |
| Compliance/audit requirements | Yes |
| Secret rotation on deploy | Yes |
| Multi-agent parallel work | Yes |
| Solo developer, single service | Use Shard |
| Small team, simple deployments | Use Array |

## Enterprise Agents

### Core (inherited from Array)
| Agent | Role |
|-------|------|
| **Cipher** | Planning - decodes requirements into stories |
| **Vector** | Building - constructs code from stories |
| **Cortex** | Testing - analyzes behavior with chaos tests |
| **Sentinel** | Review - guards code quality |

### Enterprise-Only
| Agent | Role |
|-------|------|
| **Arbiter** | Conflict resolution - detects/resolves multi-agent conflicts |
| **Conductor** | Deployment orchestration - multi-service blue-green/canary |
| **Coalition** | Multi-team coordination - assignments, approvals, cross-team deps |
| **Vault** | Secrets management - scanning, rotation, environment promotion |
| **Telemetry** | Analytics & metrics - DORA metrics, velocity, compliance |

## Directory Structure

```
.mothership/
├── mothership.md           # Matrix orchestrator
├── config.json             # Extended enterprise config
├── checkpoint.md           # State (4 lines)
├── codebase.md             # Patterns (generated)
└── agents/
    ├── cipher.md           # Planner
    ├── vector.md           # Builder
    ├── cortex.md           # Tester
    ├── sentinel.md         # Reviewer
    └── extras/
        ├── pulse.md        # Deployment
        ├── nexus.md        # Prioritization
        ├── vigil.md        # Monitoring
        ├── archive.md      # Documentation
        ├── purge.md        # Tech debt
        └── enterprise/     # Enterprise-only
            ├── arbiter.md
            ├── conductor.md
            ├── coalition.md
            ├── vault.md
            └── telemetry.md
```

## Configuration

Matrix uses an extended `config.json`:

```json
{
  "version": "matrix",
  "state": "linear",

  "governance": {
    "require_approval": true,
    "approval_chain": ["tech-lead", "team-lead"]
  },

  "deployment": {
    "strategy": "blue-green",
    "services": [
      {"name": "api", "health": "/api/health", "order": 1},
      {"name": "web", "health": "/health", "order": 2}
    ]
  },

  "teams": {
    "backend": {"members": ["alice", "bob"], "max_stories": 3},
    "frontend": {"members": ["charlie"], "max_stories": 2}
  },

  "security": {
    "scan_secrets": true,
    "rotate_on_deploy": true
  },

  "audit": {
    "enabled": true,
    "retention_days": 90
  }
}
```

## Signals

### Enterprise Signals
```
<arbiter>RESOLVED:[story-ids]</arbiter>
<arbiter>ESCALATED:[reason]</arbiter>
<conductor>DEPLOYED:[services]</conductor>
<conductor>ROLLBACK:[service]:[reason]</conductor>
<coalition>COORDINATED:[teams]</coalition>
<vault>SECURED:[count]</vault>
<telemetry>REPORT:[summary]</telemetry>
```

## Usage

```bash
# Plan with enterprise governance
./mothership.sh plan "payment processing"

# Build with conflict resolution
./mothership.sh build 20

# Deploy with multi-service orchestration
./mothership.sh deploy

# Generate compliance report
./mothership.sh report
```

## Enterprise Flow

```
Feature Request
      ↓
   Cipher (plan) → Coalition (assign teams)
      ↓
   Arbiter (check conflicts) → Vector (build)
      ↓
   Vault (secure secrets) → Cortex (test)
      ↓
   Sentinel (review) → Arbiter (deployment conflicts?)
      ↓
   Conductor (multi-service deploy) → Vigil (health)
      ↓
   Telemetry (report metrics)
```

---

*Matrix: The interconnected grid for enterprise development.*
