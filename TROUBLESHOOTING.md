# 🛸 Mothership Troubleshooting Guide

*"Houston, we have a problem" — but you're not in Houston, you're in orbit.*

---

## 👽 Identity Crisis Issues

### AI is building "agent infrastructure" instead of my feature

**Symptoms:** The Drone starts creating agent frameworks, coordination systems, or meta-tools instead of implementing your actual user stories.

**Diagnosis:** The identity lock failed. The AI has become confused about its role.

**Solution:**
> "Stop. You're confused. You ARE the Drone. Read the identity lock section again. You should be implementing user stories, not building agent systems."

**Prevention:** Always include the identity lock in prompts. The identity lock exists for a reason—AIs love building AI systems.

---

## 🌌 Navigation & State Issues

### Context lost mid-task

**Solution:**
```bash
mothership status
mothership continue
```

Checkpoint.md has recovery info. It's your flight recorder.

---

### Checkpoint.md is corrupted or missing

*The black box is gone. Don't panic.*

**Solution:**
```bash
mothership reset
```

1. Check Linear for current state
2. Resume manually from known point
3. The mission continues

---

### Wrong Linear states

**Cause:** Your team uses different state names than the defaults.

**Solution:** Update `config.json` linear_states mapping to match your team's actual state names.

---

## 📡 Communication Issues

### Can't find Linear project

**Checklist:**
1. Check `config.json` — does `linear_team` match exactly?
2. Verify Linear API access
3. Try: `Linear:list_teams` to see available teams

---

### Agent signals not being recognized

**Requirements:**
- Signals must be on their own line
- Format: `<agent>SIGNAL</agent>`
- Check for typos (aliens are picky about spelling)

---

## 🔬 Quality Control Issues

### Stories too big for one iteration

Oracle tries to size stories for ~15-20 minutes. If Drone gets stuck:

1. Mark as **Blocked** in Linear
2. Ask Oracle to split it

*Even motherships need to break large payloads into smaller deliveries.*

---

### Tests failing after Probe runs

1. Check if it's an implementation bug or test bug
2. Probe creates issues for bugs found
3. May need Drone to fix

---

### Overseer keeps rejecting code

*The code review overlord has standards.*

1. Check review comments for specific issues
2. Address each **CRITICAL** item
3. Re-request review

---

### Beacon deployment fails

**Checklist:**
1. Check quality commands pass locally
2. Verify deployment credentials
3. Check for migration issues

*Can't beam down broken code.*

---

## 🛠️ System Issues

### Codebase.md is outdated or wrong

**Solution:**
```bash
rm Codebase.md
mothership onboard
```

Or manually update patterns if you're feeling brave.

---

### Multiple agents trying to work simultaneously

**Rule:** Only one agent per iteration.

1. Use `mothership continue` to advance
2. Check checkpoint for current agent
3. Wait your turn—there's only one airlock

---

## 🆘 Emergency Procedures

If all else fails:
1. `mothership reset`
2. Check Linear for ground truth
3. Read the docs again
4. Ask a human (they built this thing)

*Remember: In space, no one can hear you scream at your AI.*
