# Contributing Guidelines

First off, thank you for considering contributing to **DevPilot Studio**! We want to make contributing to this project as easy and transparent as possible.

## Code of Conduct

By participating in this project, you are expected to uphold standard open-source professional conduct. Be respectful in pull requests, issue discussions, and code reviews.

## How to Contribute

### 1. Reporting Bugs

If you find a bug, please open an issue on the [GitHub repository](https://github.com/mr-kumuditha/devpilot-studio/issues). Include:
- Your OS and version (e.g., macOS Sequoia).
- Your Claude Code version.
- Steps to reproduce the issue.
- The expected behavior vs. actual behavior.

### 2. Suggesting Enhancements

We love new ideas! If you have a feature request:
- Open an issue explaining the feature and why it would be useful.
- If it involves UI changes to the status bar, providing a mockup (even in plain text ASCII) is highly encouraged.

### 3. Pull Requests

1. **Fork the repo** and create your branch from `main`. (`git checkout -b feat/my-awesome-feature`)
2. **Implement your changes**. Keep the POSIX bash constraints in mind (see [DEVELOPMENT.md](DEVELOPMENT.md)).
3. **Test your changes** using the local fixtures (`cat test/sample-input.json | bin/devpilot render`).
4. **Ensure the CI passes**. Run `shellcheck` locally on `bin/devpilot` and `scripts/setup.sh` to ensure there are no POSIX compliance warnings.
5. **Commit your changes** using Conventional Commits.
6. **Push and open a PR**.

## Commit Message Conventions

We use standard Conventional Commits to automatically trigger semantic versioning releases.

Format: `<type>(<scope>): <subject>`

**Examples:**
- `feat(ui): add vivid neon color theme`
- `fix(parser): prevent jq crash on missing usage keys`
- `docs: update troubleshooting section in FAQ`
- `chore(release): bump version to 1.1.5`

Allowed types:
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code (white-space, formatting)
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process or auxiliary tools

## Coding Standards

- **Bash Scripting**:
  - Must be POSIX compliant (`#!/usr/bin/env bash`).
  - Always quote variables (`"$VAR"`) to prevent word splitting and globbing.
  - Avoid using external dependencies like `python` or `ruby`; stick to standard unix tools (`awk`, `sed`, `grep`, `jq`).
  - Ensure execution speed of `bin/devpilot render` remains under 50ms, as it blocks terminal redrawing.

Thank you for helping make DevPilot Studio better for everyone!
