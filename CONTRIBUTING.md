# Contributing to Zinco

First off, thank you for considering contributing to **Zinco**! It's people like you that make Zinco a great tool for the community.

## How Can I Contribute?

### Reporting Bugs
- Check the [Issues](https://github.com/carlos/zinco/issues) to see if it's already been reported.
- If not, open a new issue. Include a clear title, a description, and steps to reproduce the bug.

### Suggesting Enhancements
- Open an issue with the tag "enhancement".
- Explain why this feature would be useful and how it fits the project's vision.

### Pull Requests
1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. Ensure the test suite passes (`pnpm run check`).
4. Make sure your code follows the existing style (Oxlint/Oxfmt).
5. Open the Pull Request!

## Development Setup

Zinco is a monorepo using **Turborepo** and **pnpm**.

```bash
pnpm install
pnpm run dev
```

The core is written in **Zig**, so you'll need the Zig compiler installed to work on the orchestration engine.

## Style Guide
- Use TypeScript for application logic and SDKs.
- Use Zig for the core engine and performance-critical parts.
- Follow the linting rules defined in the project.
