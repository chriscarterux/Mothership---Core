# Amp Adapter

## Invocation

```bash
# Single command
echo "Read .mothership/mothership.md and run: build" | amp

# With all permissions (for autonomous work)
echo "Read .mothership/mothership.md and run: build" | amp --dangerously-allow-all
```

## Loop Script

```bash
./mothership.sh build 20
```

## Tips

- Use `amp --continue` to resume previous sessions
- Check `amp --help` for more options
