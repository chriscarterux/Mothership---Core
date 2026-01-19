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
| Amp-only | Works with any AI tool |
| Linear/Jira not supported | 6 state backend adapters |
| No smart onboarding | ASSIMILATE.md auto-configures |

---

## Critical Improvements Needed

### 🔴 P0: Must Have (Blocking Adoption)

#### 1. Interactive Flowchart/Demo
**Why:** Ralph's flowchart is a key differentiator. People understand visually.

**Action:**
- Create `flowchart/` with interactive visualization
- Host at chriscarterux.github.io/Mothership
- Show: ASSIMILATE → plan → build → test → review → ship

#### 2. One-Command Install
**Why:** Ralph has simple copy instructions. We have ASSIMILATE but it's complex.

**Action:**
```bash
npx create-mothership
# or
curl -fsSL https://mothership.dev/install.sh | bash
```

#### 3. Video Demo
**Why:** Ryan's Twitter thread drove massive adoption.

**Action:**
- 2-minute video: "Watch Mothership build a feature"
- Show the alien theming, the signals, the loop
- Post on Twitter/X, LinkedIn, Reddit

#### 4. Skills for Easy PRD Creation
**Why:** Ralph has skills/prd/ and skills/ralph/. We don't.

**Action:**
- Create `skills/plan/` - generates feature spec from description
- Create `skills/stories/` - converts spec to stories
- Works with Amp skills system (and generic for other tools)

---

### 🟡 P1: High Value (Competitive Edge)

#### 5. Browser Verification Mode
**Why:** Ralph uses dev-browser skill. We should too.

**Action:**
- Add browser verification step to Drone
- For UI stories: navigate, screenshot, confirm
- Integrate with Playwright or similar

#### 6. GitHub Actions Integration
**Why:** Run Mothership in CI/CD.

**Action:**
```yaml
- uses: chriscarterux/mothership-action@v1
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
| Interactive demo | ✅ Yes | ❌ No | 🔴 **Critical** |
| Video demo | ✅ Yes | ❌ No | 🔴 **Critical** |
| One-command install | ⚠️ Copy | ❌ ASSIMILATE | 🟡 Improve |
| Skills/templates | ✅ 2 skills | ❌ No | 🔴 **Add** |
| Planning | ❌ Manual | ✅ Oracle | ✅ **Advantage** |
| Testing | ⚠️ Afterthought | ✅ Probe | ✅ **Advantage** |
| Review | ❌ None | ✅ Overseer | ✅ **Advantage** |
| State backends | 1 (JSON) | 6 | ✅ **Advantage** |
| AI tools | 1 (Amp) | 5+ | ✅ **Advantage** |
| Browser testing | ✅ dev-browser | ❌ No | 🟡 Add |

---

## 30-Day Sprint Plan

### Week 1: Visual & Discoverability
- [ ] Create interactive flowchart (like Ralph's)
- [ ] Record 2-min demo video
- [ ] Write Twitter/X launch thread
- [ ] Add GitHub topics and social preview

### Week 2: Onboarding & Skills
- [ ] Create `npx create-mothership` or install script
- [ ] Build skills/plan/ for PRD generation
- [ ] Simplify ASSIMILATE.md flow
- [ ] Add prd.json.example like Ralph

### Week 3: Features & Polish
- [ ] Add browser verification to Drone
- [ ] Create GitHub Action
- [ ] Add archiving (like Ralph)
- [ ] Improve error messages

### Week 4: Launch & Community
- [ ] Post to Hacker News
- [ ] Post to Reddit (r/programming, r/artificial)
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
Ralph works with Amp. Mothership works with everything.

*"Ralph is a loop. Mothership is a fleet."* 🛸
