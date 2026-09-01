---
description: Install DevPilot Studio, then set it up by answering a few questions in chat
allowed-tools: Bash(bash:*), Bash(dps:*), Bash(devpilot:*)
---

Set up the **DevPilot Studio** (`dps` / `devpilot`) status line for the user.

This runs in two parts: a headless install script, then a short set of
preference questions **asked in this chat** (the interactive `dps config`
wizard needs a real terminal and cannot run from a slash command, so do
**not** call it here).

## Step 1 — Run the install script (no questions)

Run it directly. It detects the platform, checks for `jq`, copies the
`devpilot` binary to `~/.local/bin/devpilot`, and wires it into
`~/.claude/settings.json` as the status line (merging with existing settings,
writing a `.bak` backup first). It does not need a TTY.

!bash `"${CLAUDE_PLUGIN_ROOT}/scripts/setup.sh"`

If that reports an error (e.g. `jq` missing, or `settings.json` not valid
JSON), relay it to the user and stop — the steps below assume it succeeded.

## Step 2 — Ask the user three questions, in one message

Post exactly one chat message containing this numbered list and ask them to
answer all three in a single reply:

> 1. **Color theme** — `default`, `mono`, or `vivid`?
> 2. **Show session cost** in the status bar — yes or no?
> 3. **Org / badge label** — short text to show at the front of the bar
>    (optional; reply "none" to skip).

Then wait for their reply. Do not guess answers or proceed until they respond.

## Step 3 — Apply their answers with `dps set` (one call per answer)

Use the non-interactive setter — it writes one config key at a time and
leaves every other setting alone. No TTY involved.

- Theme → `!bash `"${CLAUDE_PLUGIN_ROOT}/bin/devpilot" set DPS_THEME <their-theme>``
  (must be one of `default`, `mono`, `vivid`; if they typed something else,
  ask again rather than passing it through).
- Cost → map **yes → `1`**, **no → `0`**, then
  `!bash `"${CLAUDE_PLUGIN_ROOT}/bin/devpilot" set DPS_SHOW_COST <1-or-0>``
- Org label → only if they gave one (not blank / not "none"):
  `!bash `"${CLAUDE_PLUGIN_ROOT}/bin/devpilot" set DPS_ORG "<their label>"``
  Keep the surrounding quotes so a label with spaces is passed as one value.
  Skip this call entirely if they chose to skip.

## Step 4 — Show a preview in chat

Run the demo and show its output to the user directly in the chat so they
can see what they picked:

!bash `"${CLAUDE_PLUGIN_ROOT}/bin/devpilot" demo`

## Step 5 — Tell the user to restart

Tell them: **start a new Claude Code session** (or `/exit` and restart
`claude`) for the live status bar to appear. Changes to the config do not
take effect in the current session.

Later, from a normal terminal, they can run `dps config` for the full
interactive wizard, or `dps theme <name>` to switch themes quickly.

Do not modify any files other than what the install script and `dps set`
touch.
