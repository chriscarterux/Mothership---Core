# Contributing to Mothership 🛸

Thanks for wanting to contribute! Here's how to help.

## Ways to Contribute

### 🐛 Report Bugs
- Open an issue with reproduction steps
- Include: OS, AI tool used, error message

### 💡 Suggest Features
- Open an issue with the feature request
- Explain the use case and expected behavior

### 🔧 Submit PRs
1. Fork the repo
2. Create a branch: `git checkout -b feat/your-feature`
3. Make changes
4. Test with shard, array, and matrix tiers
5. Submit PR

## Development Setup

```bash
git clone https://github.com/chriscarterux/Mothership.git
cd Mothership

# Test shard tier
cp shard/mothership.md test-project/.mothership/

# Test array tier
cp -r array/* test-project/.mothership/

# Test matrix tier
cp -r matrix/* test-project/.mothership/
```

## Code Style

- Keep prompts concise (target ~30 lines per agent)
- Trust the LLM - don't over-explain
- Maintain alien humor 🛸
- Test with multiple AI tools if possible

## Areas Needing Help

- [ ] More state backend adapters (Asana, Monday, markdown files)
- [ ] Language-specific optimizations (Rust, Go, Python patterns)
- [ ] Web Dashboard (future SaaS feature)
- [ ] Team features (multi-dev, conflict resolution)
- [ ] Documentation translations
- [ ] Record the 2-min demo video (script ready)

## Questions?

Open an issue or reach out. The Mothership welcomes all species.
