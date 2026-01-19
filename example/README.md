# Example: Camino Journaling App

This example shows Mothership building a feature for a journaling/personal development app.

## The Project

**Camino** is a personal development platform with:
- 3 programs: Discover ($9.95/mo), Journey ($39.95/mo), The Camino Method ($1,997)
- AI-guided reflections
- Daily prompts across Identity, Worldview, Relationship dimensions

## The Feature

We'll build: **User Onboarding Flow**

The user should be able to:
1. See a welcome screen explaining the programs
2. Choose a program tier
3. Complete initial assessment
4. Start their first reflection

## Try It

### Using Shard (simplest)

```bash
cd example
cp ../shard/mothership.md .mothership/

# Plan the feature
"Read .mothership/mothership.md and run: plan user onboarding flow"

# Build stories one at a time
./mothership.sh build 10

# Test
./mothership.sh test 10

# Review
"Read .mothership/mothership.md and run: review"
```

### Using Array (specialized agents)

```bash
cd example
cp -r ../array/* .mothership/

# Plan
"Read .mothership/mothership.md and run: plan user onboarding flow"

# Build
./mothership.sh build 10

# Test
./mothership.sh test 10

# Review
"Read .mothership/mothership.md and run: review"
```

### Using Matrix (enterprise)

```bash
cd example
cp -r ../matrix/* .mothership/

# Plan
"Read .mothership/mothership.md and run: plan user onboarding flow"

# Build
./mothership.sh build 10

# Test
./mothership.sh test 10

# Review
"Read .mothership/mothership.md and run: review"
```

## Files

```
example/
├── .mothership/
│   ├── mothership.md    # (copy from shard/, array/, or matrix/)
│   ├── config.json      # (if using array/ or matrix/)
│   └── checkpoint.md    # (created automatically)
├── docs/
│   └── onboarding.md    # Feature requirements
├── package.json         # Project config
└── README.md            # This file
```

## Expected Output

After `plan`:
- 4-6 stories created in Linear (or stories.json)
- Checkpoint updated to `phase: build`

After `build` (repeat until COMPLETE):
- Each story implemented
- Code committed to branch
- Stories marked Done

After `test`:
- Tests written for each story
- Edge cases covered

After `review`:
- APPROVED or NEEDS-WORK signal
- Ready to merge
