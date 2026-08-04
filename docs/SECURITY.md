# Security & Privacy Audit Report

**Project:** DevPilot Studio (`dps` / `devpilot`)  
**Maintainer:** Kumuditha Labs (Kumuditha Tharinda Liyanage)  

DevPilot Studio is engineered with a strict **privacy-first architecture**. Developer tools should not leak code context, telemetry, or API keys. 

## 1. Zero Outbound Network Requests

DevPilot Studio is **100% offline**. 
The core rendering engine (`bin/devpilot`), which executes continuously as you work in Claude Code, does not contain any code capable of making HTTP requests.
- No `curl`
- No `wget`
- No telemetry SDKs
- No update-check pingbacks
- No tracking pixels

*Note: The only network request involved in DevPilot Studio is when you explicitly invoke the `curl` installer or use `/plugin install`, which downloads the scripts from GitHub.*

## 2. No Embedded Secrets

All code in this repository is open-source POSIX bash and Javascript. There are no compiled binary blobs (aside from image assets), no obfuscated code, and no embedded secrets.

## 3. Data Isolation

DevPilot Studio stores settings and history data strictly within your local user profile, adhering to XDG Base Directory specifications:

- **Configuration:** `${XDG_CONFIG_HOME:-~/.config}/devpilot-studio/config`
- **History Logs:** `${XDG_STATE_HOME:-~/.local/state}/devpilot-studio/history.tsv`

No conversation content, prompts, or repository data from Claude Code is stored on disk by DevPilot Studio.

## 4. Environment Variable Security

DevPilot Studio does not read or export sensitive environment variables like `ANTHROPIC_API_KEY`. It only reads its own `DPS_*` namespace variables for UI configuration.

## 5. Shell Execution Safety

Claude Code invokes the plugin via secure slash commands defined in the `.claude-plugin` manifest. The commands explicitly define `allowed-tools: Bash(bash:*), Bash(dps:*)` to restrict execution to approved script paths. DevPilot Studio passes the `shellcheck` linter on every commit to prevent shell injection vulnerabilities.
