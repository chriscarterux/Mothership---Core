# AMP Adapter

AMP is the default AI tool for Mothership. It integrates seamlessly with the orchestration loop.

## CLI Usage

```bash
# Basic execution
amp "Read .mothership/mothership.md and run: build"

# With context
amp --context .mothership/codebase.md "Read .mothership/mothership.md and run: plan user authentication"
```

## Mothership Integration

AMP is auto-detected first in `mothership.sh`. Simply run:

```bash
./mothership.sh build 20
./mothership.sh plan "new feature"
./mothership.sh test
./mothership.sh review
```

## Environment Setup

```bash
# Set AMP as your AI tool (optional - auto-detected)
export AI_TOOL=amp

# Run Mothership
./mothership.sh build
```

## API Usage

```python
import amp

# Load Mothership prompt
with open(".mothership/mothership.md") as f:
    prompt = f.read()

# Execute
response = amp.run(f"{prompt}\n\nRun: build")

# Check for completion
if "COMPLETE" in response:
    print("Build cycle finished")
```

## Loop Pattern

```python
from amp import Agent

agent = Agent()

while True:
    response = agent.run("Read .mothership/mothership.md and run: build")
    if "<vector>COMPLETE</vector>" in response:
        break
    if "BLOCKED" in response:
        print("Agent blocked - manual intervention needed")
        break
```

## Tips

- AMP auto-detects project context from `.mothership/codebase.md`
- For enterprise (Matrix) tier, AMP supports multi-agent coordination
- AMP excels at maintaining context across long iteration loops
- Use `--verbose` flag for detailed signal output
