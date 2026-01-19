# Signal Reference

Compressed signals for token efficiency. Format: `<agent>SIG:data</agent>`

## Core Agents
| Agent | Signal | Meaning |
|-------|--------|---------|
| cipher | `P:N` | Planned N stories |
| vector | `B:ID` | Built story ID |
| vector | `C` | Complete (no stories) |
| vector | `X:ID:R` | Blocked on ID, reason R |
| cortex | `T:ID` | Tested story ID |
| cortex | `C` | Complete (all tested) |
| sentinel | `A` | Approved |
| sentinel | `NW` | Needs work |

## Optional Extras
| Agent | Signal | Meaning |
|-------|--------|---------|
| pulse | `D` | Deployed |
| pulse | `F:R` | Failed, reason R |
| nexus | `P:N` | Prioritized N stories |
| vigil | `H` | Healthy |
| vigil | `!:I` | Alert, issue I |
| archive | `D:F` | Documented files F |
| purge | `K:S` | Cleaned, summary S |

## Enterprise (Matrix)
| Agent | Signal | Meaning |
|-------|--------|---------|
| arbiter | `R:IDs` | Resolved conflicts |
| arbiter | `E:R` | Escalated, reason R |
| arbiter | `OK` | Clear, no conflicts |
| conductor | `D:S` | Deployed services S |
| conductor | `RB:S:R` | Rollback service S, reason R |
| coalition | `C:T` | Coordinated teams T |
| coalition | `W:T:D` | Waiting on team T for dep D |
| vault | `S:N` | Secured N files |
| vault | `X:F` | Blocked on file F |
| telemetry | `R:P` | Report for period P |
| telemetry | `!:M:V` | Alert metric M at value V |
