# Architecture Report — DevPilot Studio (DPS)

**Date:** 2026-08-04  
**Project:** DevPilot Studio (`dps` / `devpilot`) v1.0.0  
**Author / Developer:** Kumuditha Tharinda Liyanage (Kumuditha Labs)  

---

## 1. Executive Architecture Summary

**DevPilot Studio (DPS)** is a zero-dependency, ultra-lightweight desktop utility and CLI engine designed to streamline Claude Code workflows, AI development sessions, project status tracking, MCP server configurations, prompt templates, Git repository monitoring, and developer productivity metrics.

The runtime architecture consists of a high-performance shell rendering engine (`bin/devpilot`), a cross-platform Node.js installation & wrapper interface (`cli.js`), and a Claude Code plugin integration layer (`.claude-plugin/`).

```
+-------------------------------------------------------------------------+
|                          Claude Code CLI Session                         |
+-------------------------------------------------------------------------+
                                     |
                                     | Status JSON on stdin
                                     v
+-------------------------------------------------------------------------+
|                  DevPilot Studio Engine (bin/devpilot)                   |
|                                                                         |
|  +---------------------+  +--------------------+  +------------------+  |
|  | Config & Theme      |  | Real-Time Status   |  | Stats & History  |  |
|  | Loader              |  | Bar Renderer       |  | Logging Subsystem|  |
|  +---------------------+  +--------------------+  +------------------+  |
+-------------------------------------------------------------------------+
         |                                |                        |
         v                                v                        v
 ~/.config/devpilot-studio       Terminal Output          ~/.local/state/
     /config                   (2-line status bar)        devpilot-studio
                                                             /history.tsv
```

---

## 2. Component & Subsystem Analysis

### 2.1 Core CLI Executable (`bin/devpilot`)
- **Language**: Pure POSIX/Bash with standard Unix utilities (`jq`, `awk`, `date`, `sed`).
- **Role**: Renders terminal status lines, displays detailed usage metrics panels, tracks usage history over time, and manages interactive terminal configuration.
- **Key Modules**:
  1. `load_config`: Resolves configuration with hierarchical fallbacks (`DPS_*` -> `CCB_*` -> `CCBAR_*`).
  2. `apply_theme`: Dynamically injects ANSI color palettes (`default`, `mono`, `vivid`).
  3. `render_bar` & `render_reset`: Mathematical generation of unicode/ASCII progress bars and human-readable countdowns.
  4. `_history_log`: Asynchronous throttled append of session metrics (timestamp, model, cost, context window, rate limits) to TSV state storage.
  5. `cmd_stats`: Instant expanded usage dashboard reading from live stdin pipe or cached JSON payload (`~/.cache/devpilot-studio/last.json`).
  6. `cmd_history`: Calculates 7-day sparklines, peak utilization, and estimated cost rollups using `awk` without external dependencies.
  7. `cmd_config`: Interactive TTY setup wizard for customizing theme, bar style, segment visibility, and organizational badges.

### 2.2 Cross-Platform CLI Entry Wrapper (`cli.js`)
- **Language**: Node.js (CommonJS, zero NPM runtime dependencies).
- **Role**: Acts as the `npx devpilot-studio` or `dps` executable entry point.
- **Key Functions**:
  - `installScript()`: Installs `bin/devpilot` into `~/.local/bin/devpilot`.
  - `wireSettings()`: Merges status line command configuration safely into `~/.claude/settings.json`.
  - `forward()`: Passes commands (`stats`, `history`, `config`, `gallery`, `demo`, `install`, `uninstall`) directly to `bin/devpilot`.

### 2.3 Plugin Integration Layer (`.claude-plugin/` & `commands/`)
- Contains `plugin.json` and `marketplace.json` manifest specifications.
- Exposes `commands/dps-setup.md` to enable automated setup directly inside Claude Code sessions.

---

## 3. Data Flow & Lifecycles

### 3.1 Status Line Redraw Cycle (Passive Execution)
1. Claude Code generates status JSON payload (containing model name, workspace directory, effort level, context usage %, 5h/7d rate limit %, and session cost).
2. Claude Code pipes payload into `~/.local/bin/devpilot render`.
3. `bin/devpilot` loads config, caches payload to `~/.cache/devpilot-studio/last.json`, appends throttled metrics to `~/.local/state/devpilot-studio/history.tsv`, and outputs formatted ANSI color status lines to terminal.
4. Execution completes in under 15ms.

### 3.2 Interactive Management Cycle (Active Execution)
1. Developer runs `dps stats`, `dps history`, `dps config`, or `dps gallery`.
2. `cli.js` (or direct shell executable) dispatches subcommand to `bin/devpilot`.
3. Commands execute interactively on `/dev/tty` or render analytical visual tables.

---

## 4. Claude Code & Git Integration Details

- **Claude Code Integration**: Registered as a custom command status bar via `statusLine` block in `~/.claude/settings.json`:
  ```json
  "statusLine": {
    "type": "command",
    "command": "$HOME/.local/bin/devpilot render",
    "padding": 0
  }
  ```
- **Git Integration**: Extracts current directory basename from workspace payload (`workspace.current_dir`), displaying active project repository context in real time.

---

## 5. Future Extensibility Architecture

To support upcoming versions with **Multi-AI Providers**, **MCP Server Manager**, **Prompt Library**, **Workspace Profiles**, **Git Dashboard**, **Cost Tracking**, and **Local Model Support**, the architecture has been prepared as follows:

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

1. **Multi-AI Provider Abstraction**: JSON schema normalization layer for Anthropic, OpenAI, Gemini, DeepSeek, and Ollama status payloads.
2. **Modular Subcommand Dispatch**: Architecture allows plugging in `dps mcp`, `dps prompts`, `dps git`, and `dps models` subcommands without breaking legacy rendering.
3. **Pluggable Config Architecture**: `config` file structured with extensible key-value namespace supporting multi-provider profiles.
