# 🛸 Mothership Roadmap

## Oracle Analysis: What Makes Ralph Successful (4.9k ⭐)

### Ralph's Winning Formula

| Factor | Why It Works |
|--------|--------------|
| **Extreme simplicity** | 3 core files: ralph.sh, prompt.md, prd.json |
| **Visual flowchart** | Interactive demo at snarktank.github.io/ralph |
| **Skills system** | PRD skill + Ralph skill = easy onboarding |
| **Clear workflow** | 1. Create PRD → 2. Convert → 3. Run |
| **Browser verification** | dev-browser skill for UI testing |
| **Archiving** | Auto-saves previous runs |
| **Ryan Carson's reach** | Twitter thread with 100k+ views |

### What Ralph Lacks (Our Opportunity)

| Gap | Mothership Advantage |
|-----|---------------------|
| Planning is manual | Oracle auto-creates stories from docs |
| No dedicated testing | Probe writes chaos tests |
| No code review | Overseer reviews before merge |
| Single tool only | Works with any AI tool |
| Linear/Jira not supported | 6 state backend adapters |
| No smart onboarding | ASSIMILATE.md auto-configures |

---

## Critical Improvements Needed

### 🔴 P0: Must Have (Blocking Adoption)

#### 1. Interactive Flowchart/Demo ✅ DONE
- `docs/flowchart/` with interactive visualization
- Landing page at `docs/index.html`
- GitHub Pages workflow configured

#### 2. One-Command Install ✅ DONE
```bash
curl -fsSL https://raw.githubusercontent.com/chriscarterux/Mothership/main/install.sh | bash
```

#### 3. Video Demo 📋 SCRIPT READY
- Video script in VIDEO_SCRIPT.md
- Need to record 2-minute walkthrough

#### 4. Skills for Easy PRD Creation ✅ DONE
- `skills/plan/` - generates feature spec from description
- `skills/stories/` - converts spec to stories
- Works with skills system (and generic for other tools)

---

### 🟡 P1: High Value (Competitive Edge)

#### 5. Browser Verification Mode ✅ DONE
- Added browser verification step to Drone (step 6b in full/agents/drone.md)
- For UI stories: navigate, verify elements, run Playwright tests
- Notes verification in commit message

#### 6. GitHub Actions Integration ✅ DONE
- `action.yml` composite action
- `docs/github-actions.md` documentation
- Supports all modes: plan, build, test, review

```yaml
- uses: chriscarterux/Mothership@main
  with:
    mode: build
    max-iterations: 20
```

#### 7. Web Dashboard (Future SaaS)
**Why:** Visualize progress across projects.

**Action:**
- Simple web UI showing: stories, status, history
- Connect to Linear/GitHub/Jira APIs
- Track velocity, completion rates

---

### 🟢 P2: Nice to Have (Polish)

#### 8. More State Backends
- Asana
- Monday.com
- Basecamp
- Plain markdown files

#### 9. Language-Specific Optimizations
- Rust: cargo check patterns
- Go: go test patterns
- Python: pytest patterns

#### 10. Team Features
- Multiple developers
- Conflict resolution
- Parallel work streams

---

## Comparison: Current State

| Feature | Ralph | Mothership | Gap |
|---------|-------|------------|-----|
| Core files | 3 | 5 (lite) / 10 (full) | ✅ Comparable |
| Line count | ~200 | ~200 (lite) / ~600 (full) | ✅ Comparable |
| Interactive demo | ✅ Yes | ✅ Yes | ✅ **Matched** |
| Video demo | ✅ Yes | ⚠️ Script ready | 🟡 Record |
| One-command install | ⚠️ Copy | ✅ `curl \| bash` | ✅ **Advantage** |
| Skills/templates | ✅ 2 skills | ✅ 2 skills | ✅ **Matched** |
| Planning | ❌ Manual | ✅ Oracle | ✅ **Advantage** |
| Testing | ⚠️ Afterthought | ✅ Probe | ✅ **Advantage** |
| Review | ❌ None | ✅ Overseer | ✅ **Advantage** |
| State backends | 1 (JSON) | 6 | ✅ **Advantage** |
| AI tools | 1 | 5+ | ✅ **Advantage** |
| Browser testing | ✅ dev-browser | ✅ Drone step | ✅ **Matched** |
| GitHub Action | ❌ No | ✅ Yes | ✅ **Advantage** |
| Archiving | ✅ Yes | ✅ Yes | ✅ **Matched** |

---

## 30-Day Sprint Plan

### Week 1: Visual & Discoverability
- [x] Create interactive flowchart (like Ralph's)
- [ ] Record 2-min demo video (script ready in VIDEO_SCRIPT.md)
- [ ] Write Twitter/X launch thread (draft in LAUNCH.md)
- [ ] Add GitHub topics and social preview

### Week 2: Onboarding & Skills
- [x] Create `curl | bash` install script
- [x] Build skills/plan/ for PRD generation
- [x] Build skills/stories/ for story breakdown
- [x] Simplify ASSIMILATE.md flow
- [x] Add example stories.json

### Week 3: Features & Polish
- [x] Add browser verification to Drone
- [x] Create GitHub Action
- [x] Add archiving (like Ralph)
- [x] Improve error messages

### Week 4: Launch & Community
- [ ] Post to Hacker News (draft in LAUNCH.md)
- [ ] Post to Reddit (draft in LAUNCH.md)
- [ ] Engage with Ralph/Geoffrey community
- [ ] Collect feedback, iterate

---

## Success Metrics

| Metric | Target (90 days) |
|--------|------------------|
| GitHub Stars | 1,000 |
| Forks | 100 |
| Twitter impressions | 50,000 |
| Active users (installs) | 500 |

---

## The Ultimate Goal

**Ralph:** "Run until PRD complete"
**Mothership:** "Tell me what to build, I'll handle the rest"

Ralph requires you to write a PRD. Mothership reads your docs and creates one.
Ralph implements. Mothership implements, tests, AND reviews.
Ralph works with one tool. Mothership works with everything.

*"Ralph is a loop. Mothership is a fleet."* 🛸
