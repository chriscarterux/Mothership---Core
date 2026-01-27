# AI Tool Adapters

Mothership works with **any AI coding assistant** that can:
1. Accept a text prompt
2. Execute code/commands
3. Output text (including signals)

## Supported Tools

| Tool | Status | Installation |
|------|--------|--------------|
| Claude Code | ✅ Full support | `npm install -g @anthropic-ai/claude-code` |
| AMP | ✅ Full support | `npm install -g @anthropic-ai/amp` |
| Aider | ✅ Full support | `pip install aider-chat` |
| Cursor | ⚠️ CLI only | Download from cursor.sh |
| Codex | ⚠️ Experimental | OpenAI CLI |
| Gemini | ⚠️ Experimental | Google Cloud CLI |
| Cody | ⚠️ Experimental | Sourcegraph CLI |
| Continue | ⚠️ Experimental | continue.dev |
| OpenCode | ⚠️ Experimental | Custom CLI |

## Usage

### Auto-detect (Recommended)
```bash
./mothership.sh build 20
```
Mothership will auto-detect the first available AI tool.

### Specify Tool
```bash
AI_TOOL=aider ./mothership.sh build 20
AI_TOOL=claude ./mothership.sh build 20
```

### Custom Tool
```bash
CUSTOM_AI_CMD=my-ai-cli \
CUSTOM_PROMPT_FLAG=--prompt \
AI_TOOL=custom \
./mothership.sh build 20
```

## Adding a New AI Tool

### 1. Add to adapter.sh

Edit `adapters/ai/adapter.sh` and add your tool to the `AI_TOOLS` array:

```bash
declare -A AI_TOOLS=(
    # ... existing tools ...
    ["mytool"]="mytool-cli|--prompt|--file|My Custom AI Tool"
)
```

Format: `"command|prompt_flag|file_flag|description"`

### 2. Add Invocation Logic (if special)

If your tool has a unique invocation pattern, add a case in `invoke_ai()`:

```bash
case "$tool" in
    # ... existing cases ...
    mytool)
        $cmd --special-flag "$prompt"
        ;;
esac
```

### 3. Test It

```bash
AI_TOOL=mytool ./mothership.sh status
```

## Tool Requirements

For full Mothership compatibility, your AI tool must:

### Required
- [ ] Accept text prompts
- [ ] Execute shell commands (for builds, tests)
- [ ] Read/write files
- [ ] Output text that includes signals like `<mothership>BUILT:ID</mothership>`

### Recommended
- [ ] Support streaming output (for progress visibility)
- [ ] Support file context (for reading codebase.md)
- [ ] Support git operations (for commits)

### Optional
- [ ] MCP server support (for enhanced tools)
- [ ] Session persistence (for context between runs)

## Prompts Location

Mothership prompts are AI-agnostic and located in:

```
.mothership/
├── mothership.md      # Main agent prompt (copy to project)
├── config.json        # Project configuration
├── checkpoint.md      # Current state
└── codebase.md        # Project context

# OR for Claude Code specifically:
.claude/commands/      # Claude Code slash commands
```

## Making Prompts Work Across Tools

### Claude Code
Prompts work as slash commands in `.claude/commands/`:
```
/mothership:build
/mothership:test
```

### Aider
Add prompts to `.aider.conf.yml` or use directly:
```bash
aider --message "$(cat .mothership/mothership.md) Run: build"
```

### Cursor
Add to `.cursorrules`:
```
@import .mothership/mothership.md
```

### Generic CLI
```bash
cat .mothership/mothership.md | my-ai-cli --stdin
```

## Signal Detection

All AI tools must output signals in the format:
```
<agent>SIGNAL</agent>
```

Examples:
```
<mothership>BUILT:STORY-001</mothership>
<mothership>BUILD-COMPLETE</mothership>
<mothership>VERIFIED:STORY-001</mothership>
```

The `mothership.sh` loop detects these signals using regex:
```bash
grep -qE "<(mothership|vector|cortex|...)>($COMPLETE_SIGNALS)</"
```

This works regardless of which AI tool produces the output.

## Troubleshooting

### Tool Not Detected
```bash
# Check if tool is in PATH
which claude
which aider

# Override detection
AI_TOOL=claude ./mothership.sh build
```

### Signals Not Detected
Ensure your AI tool outputs the exact signal format:
```
<mothership>BUILT:STORY-001</mothership>
```

Not:
```
Built story STORY-001  # Wrong - no tags
<MOTHERSHIP>BUILT</MOTHERSHIP>  # Wrong - uppercase
```

### Prompts Not Loading
```bash
# Check prompt file exists
cat .mothership/mothership.md

# For Claude Code, check commands
ls -la .claude/commands/
```
