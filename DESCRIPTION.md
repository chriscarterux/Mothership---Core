# Mothership

## One-Liner

**Autonomous AI development orchestration that plans, builds, tests, and reviews your code.**

## Short Description

Mothership Core is an AI-powered development loop that transforms feature descriptions into production-ready code. It wraps any AI CLI tool (Claude, Cursor, Aider) in a structured workflow that automatically plans stories, implements features one at a time, writes comprehensive tests, and reviews code quality—all while maintaining fresh context and transparent token costs.

## Full Description

Mothership Core is an autonomous development orchestration system that manages the complete software development lifecycle through specialized AI agents. Unlike simple code generation tools, Mothership operates as a full workflow engine: it reads your documentation, breaks features into actionable stories, implements them one iteration at a time, writes tests, and performs code reviews—all automatically.

The system is built on a simple principle: **one story per iteration, fresh context each time**. This approach keeps token usage minimal (typically ~1,086 tokens per run, or about $0.003 with Claude Sonnet) while ensuring focused, high-quality output. Every claim is verifiable through the built-in `benchmark` command.

Mothership is tool-agnostic by design. It works with Claude, Cursor, Aider, or any AI CLI tool you prefer. State can be managed locally via JSON files or integrated with Linear for team workflows. The entire core loop is auditable—roughly 150 lines of shell script that you can inspect and trust.

### Key Capabilities

- **Plan**: Decode feature requirements into small, actionable stories
- **Build**: Implement one story at a time following existing code patterns
- **Test**: Generate comprehensive test coverage for completed work
- **Review**: Verify code quality and acceptance criteria before merge
- **Deploy**: Orchestrate blue-green and canary deployments (enterprise)

### Why Mothership?

- **Transparent costs**: Verify exact token usage with `./mothership.sh benchmark`
- **Pattern-aware**: Analyzes your codebase and follows existing conventions
- **Fresh context**: Each iteration starts clean, reducing confusion and errors
- **Full lifecycle**: Not just building—planning, testing, and reviewing too
- **Minimal footprint**: Auditable shell scripts, no black boxes
- **Flexible state**: Local JSON for solo devs, Linear for teams

## Taglines

- "The autonomous loop that plans, builds, tests, and reviews."
- "AI development orchestration with transparent token costs."
- "From feature description to production-ready code, automatically."
- "One story. One iteration. Full workflow."

## Target Audience

- Development teams accelerating feature delivery
- Solo developers managing multiple projects
- DevOps engineers integrating AI into CI/CD pipelines
- Startups where speed and cost efficiency matter
- Enterprise teams requiring compliance and audit trails

## Comparison Positioning

Mothership Core extends beyond simple build loops (like Ralph) to provide a complete development workflow. If you need a build loop, use Ralph. If you want planning, building, testing, and reviewing in one system with verifiable token costs, use Mothership Core.
