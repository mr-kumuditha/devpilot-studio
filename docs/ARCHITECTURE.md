# DevPilot Studio — Technical Architecture Specification

This document provides an overview of the core architectural components of **DevPilot Studio**.

---

## Technical Stack & Principles

1. **Core Execution**: POSIX Bash (`bin/devpilot`) + Node.js CLI wrapper (`cli.js`).
2. **Data Parser**: `jq` streaming JSON processor.
3. **Storage Engine**: Zero database overhead — uses plain-text TSV format for history logging and standard JSON for last-render caching.
4. **Performance Targets**: `< 15ms` execution time per status bar redraw cycle.

---

## File System Locations

- **Config**: `${XDG_CONFIG_HOME:-~/.config}/devpilot-studio/config`
- **Cache**: `${XDG_CACHE_HOME:-~/.cache}/devpilot-studio/last.json`
- **State & History**: `${XDG_STATE_HOME:-~/.local/state}/devpilot-studio/history.tsv`
- **Installed Executable**: `$HOME/.local/bin/devpilot`

---

## Subsystem Architecture

```
                  +-----------------------------------+
                  |         DevPilot Studio           |
                  |         Unified Engine            |
                  +-----------------------------------+
                                    |
     +-------------------+----------+----------+-------------------+
     |                   |                     |                   |
     v                   v                     v                   v
+----------+      +------------+        +------------+      +------------+
| AI Provider|    | MCP Server |        |  Prompt    |      |  Session   |
| Router   |    | Manager    |        |  Library   |      |  Analytics |
+----------+      +------------+        +------------+      +------------+
| Claude   |      | Active MCP |        | Templates  |      | Cost Logs  |
| OpenAI   |      | Tools      |        | Custom     |      | Token Use  |
| Gemini   |      | Status     |        | Snippets   |      | Local LLM  |
| Ollama   |      +------------+        +------------+      +------------+
+----------+
```
