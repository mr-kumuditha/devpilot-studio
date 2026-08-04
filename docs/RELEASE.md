# DevPilot Studio — Release & Distribution Guide

This document describes the release workflow and versioning policy for **DevPilot Studio**.

---

## Release Channels

- **Stable Channel (`v1.0.0`)**: Production releases published to NPM registry (`devpilot-studio`) and GitHub Releases.

---

## Release Checklist

1. Update `version` in `package.json`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, and `DPS_VERSION` in `bin/devpilot`.
2. Update `CHANGELOG.md`.
3. Verify syntax and test suite:
   ```bash
   bash -n bin/devpilot install.sh
   node --check cli.js
   node cli.js demo
   ```
4. Tag release commit:
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin main --tags
   ```
5. Publish npm package:
   ```bash
   npm publish --access public
   ```
