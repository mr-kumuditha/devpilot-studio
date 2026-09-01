# Architecture Specification

DevPilot Studio is designed with an extremely lightweight, dependency-free architecture. To ensure 100% offline privacy and maximum speed without bogging down the terminal, the core engine is written entirely in POSIX-compliant Bash.

## Execution Flow

Claude Code periodically executes a command defined in its `statusLine` configuration block. It passes a JSON payload representing the current state of the AI session via `stdin` to that command.

DevPilot Studio intercepts this payload and renders a formatted status bar string back to `stdout`.

```mermaid
sequenceDiagram
    participant C as Claude Code
    participant D as DevPilot Engine (bash)
    participant J as jq (parser)
    participant H as History Subsystem
    
    C->>D: Execute `devpilot render` (sends JSON via stdin)
    activate D
    D->>D: Load configuration (`~/.config/devpilot/config`)
    D->>J: Parse stdin JSON payload
    J-->>D: Extracted metrics (Model, Tokens, Quotas)
    
    alt History Logging Enabled
        D->>H: Append daily rollup to `~/.local/state/devpilot/history.tsv`
    end
    
    D->>D: Theme & Format strings
    D-->>C: Rendered ANSI string via stdout
    deactivate D
    C->>C: Paint string to terminal bottom row
```

## Core Components

The primary logic lives in a single monolithic script: `bin/devpilot`.

### 1. Payload Parser
Uses `jq` to traverse the incoming JSON object from Claude Code. It safely extracts deeply nested values such as rate limit thresholds, reset timestamps, and context window utilization, falling back to empty strings if properties are missing (e.g., when the user has API keys instead of Claude Pro limits).

### 2. Rendering Engine
- **Bar Generation**: Converts percentage integers (`0-100`) into visual progress bars using the `DPS_BAR_WIDTH`, `DPS_BAR_FILLED`, and `DPS_BAR_EMPTY` constants.
- **Velocity Subsystem**: Calculates if the current token utilization pace will result in hitting 100% before the reset timer expires.
- **Cost Subsystem**: Multiplies token counts by current Anthropic API prices to estimate session cost.

### 3. State & History (TSV)
To avoid the overhead of a database (like SQLite), DevPilot Studio uses a simple append-only Tab-Separated Value (TSV) file located at `~/.local/state/devpilot/history.tsv`.

The structure is:
`TIMESTAMP \t TYPE \t VALUE \t METADATA`

When a user runs `dps history`, the script parses this TSV using `awk` to extract daily maximums and generates terminal sparklines based on the extracted data.

### 4. Setup Hooks
`hooks/hooks.json` registers a `Setup` hook that runs `scripts/setup.sh`. Claude
Code only fires `Setup` hooks when it is launched with `--init` or
`--maintenance` — **not** automatically after `/plugin install` or on a normal
session start. For the usual install flow, run `/devpilot-studio:setup` (which
invokes the same script) once by hand.

The shared wiring logic lives in `scripts/lib/wire-statusline.sh` and is sourced
by both `scripts/setup.sh` and `install.sh`. It reads `~/.claude/settings.json`,
validates it as JSON, writes a `.bak` backup, and merges the `statusLine`
injection while preserving every other key.
