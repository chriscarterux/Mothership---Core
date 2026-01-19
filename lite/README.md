# 🛸 Mothership Lite

**One prompt. All modes. ~150 lines.**

```
"Read .mothership/mothership.md and run: build"
```

---

## Why Lite?

| | Ralph | Mothership (Full) | Mothership Lite |
|---|-------|-------------------|-----------------|
| Lines | ~100 | ~5,000 | ~150 |
| Files | 3 | 15+ | 1 |
| Agents | 1 | 9 | 1 (with modes) |
| State | prd.json | Linear + checkpoint | Linear + checkpoint |
| Planning | Manual | Oracle agent | Built-in mode |
| Testing | Optional | Probe agent | Built-in mode |
| Review | None | Overseer agent | Built-in mode |

**Lite = Ralph's simplicity + integrated planning/testing/review**

---

## Quick Start

```bash
# Install
mkdir -p .mothership
cp /path/to/mothership-lite/mothership.md .mothership/

# Onboard (first time)
"Read .mothership/mothership.md and run: onboard"

# Plan a feature
"Read .mothership/mothership.md and run: plan user authentication"

# Build stories (one at a time)
"Read .mothership/mothership.md and run: build"

# Test completed work
"Read .mothership/mothership.md and run: test"

# Review before merge
"Read .mothership/mothership.md and run: review"
```

---

## Modes

| Mode | What It Does | Output |
|------|--------------|--------|
| `plan [feature]` | Read docs → create Linear stories | `PLANNED:12` |
| `build` | Implement ONE story → commit | `BUILT:ENG-42` |
| `test` | Write tests for ONE story | `TESTED:ENG-42` |
| `review` | Check branch quality | `APPROVED` or `NEEDS-WORK` |
| `status` | Show current state | Summary |
| `onboard` | Analyze codebase | Creates codebase.md |

---

## Loop It

```bash
# Build all stories
while true; do
  OUTPUT=$(echo "Read .mothership/mothership.md and run: build" | amp 2>&1)
  echo "$OUTPUT"
  if echo "$OUTPUT" | grep -q "BUILD-COMPLETE"; then break; fi
  sleep 2
done

# Test all stories
while true; do
  OUTPUT=$(echo "Read .mothership/mothership.md and run: test" | amp 2>&1)
  echo "$OUTPUT"
  if echo "$OUTPUT" | grep -q "TEST-COMPLETE"; then break; fi
  sleep 2
done
```

---

## What's Better Than Ralph?

1. **Integrated planning** - `plan` mode creates Linear stories (Ralph needs separate PRD skill)
2. **Integrated testing** - `test` mode writes tests (Ralph does it as afterthought)
3. **Integrated review** - `review` mode checks quality (Ralph has none)
4. **Linear state** - Team visibility (Ralph uses local prd.json)
5. **Identity lock** - Prevents "building agent systems" confusion
6. **Codebase memory** - `codebase.md` persists patterns across features

---

## Files

```
.mothership/
├── mothership.md   # The one prompt (150 lines)
├── checkpoint.md   # 4-line state file
└── codebase.md     # Project patterns (generated)
```

---

## Checkpoint Format

```
phase: build
project: User Auth - v1
branch: feat/user-auth
story: ENG-42
```

That's it. 4 lines. No YAML frontmatter complexity.

---

## Credits

- [Geoffrey Huntley](https://ghuntley.com/ralph/) - Original Ralph concept
- [Ryan Carson](https://github.com/snarktank/ralph) - Ralph implementation

Lite keeps Ralph's genius (simple loop, fresh context, one task) and adds what it lacked (planning, testing, review).

---

*"I come in peace. I leave with features."* 🛸
