# Network Activity & Endpoint Audit — DevPilot Studio

**Project:** DevPilot Studio (`dps` / `devpilot`) v1.0.0  
**Date:** 2026-08-04  
**Audit Scope:** All network primitives (`curl`, `wget`, `nc`, `fetch`, `http`) across the repository.

---

## 1. Network Activity Summary

DevPilot Studio is designed with a **privacy-first, offline-by-default architecture**. During normal usage (status line rendering, stats dashboard display, usage history computation, configuration wizard execution), DevPilot Studio initiates **zero network requests**.

---

## 2. Exhaustive Network Call Catalog

| Script / Component | Command | URL / Destination | Purpose | Trigger Condition | Can Be Disabled? |
| --- | --- | --- | --- | --- | --- |
| `install.sh` | `curl -fsSL` | `https://raw.githubusercontent.com/mr-kumuditha/devpilot-studio/main/bin/devpilot` | Fetches `bin/devpilot` script during initial installation | User manually runs `curl ... \| bash` | Yes (use local source `DPS_SRC=./bin/devpilot bash install.sh`) |
| `bin/devpilot` | None | N/A | Status line rendering & CLI dashboard | None (Zero network calls) | N/A (Already offline) |
| `cli.js` | None | N/A | NPX entry point & command forwarder | None (Zero network calls) | N/A (Already offline) |

---

## 3. Remote Configuration & Telemetry Verification

- **Remote Configuration Servers**: None.
- **Update Checking Pings**: None.
- **Crash Reporting Endpoints**: None.
- **Analytics / Tracking**: None.
