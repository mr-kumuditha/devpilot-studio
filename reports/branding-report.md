# Branding Audit & Rebrand Verification Report

**Project:** DevPilot Studio (DPS)  
**Date:** 2026-08-04  
**Author & Maintainer:** Kumuditha Tharinda Liyanage (Kumuditha Labs)  

---

## 1. Brand Specification Matrix

| Metric | Target Specification |
| --- | --- |
| **Project Name** | DevPilot Studio |
| **Short Name** | DPS |
| **Application Name** | DevPilot Studio |
| **Description** | A professional desktop utility for managing Claude Code workflows, AI development sessions, project status, MCP servers, prompts, Git repositories, and developer productivity. |
| **Version** | 1.0.0 |
| **Release Channel** | Stable |
| **Author / Developer / Maintainer** | Kumuditha Tharinda Liyanage |
| **Company / Organization** | Kumuditha Labs |
| **Copyright** | © 2026 Kumuditha Tharinda Liyanage |
| **Repository Name** | devpilot-studio |
| **Executable Name** | devpilot |
| **CLI Command** | dps / devpilot |
| **Package Name** | devpilot-studio |
| **macOS Bundle Identifier** | com.kumuditha.devpilot |
| **Windows App ID** | com.kumuditha.devpilot |
| **Linux Package** | devpilot-studio |

---

## 2. Global Replacement Inventory

Every reference to `claude-control-center`, `ccb`, and `ccbar` across the repository has been updated according to the following mapping:

| Old Reference | New Rebranded Target | Status |
| --- | --- | --- |
| `claude-control-center` | `devpilot-studio` | Replaced |
| `ccb` (command) | `dps` / `devpilot` | Replaced |
| `~/.config/ccb` | `~/.config/devpilot-studio` (with fallback) | Replaced |
| `~/.cache/ccb` | `~/.cache/devpilot-studio` (with fallback) | Replaced |
| `~/.local/state/ccb` | `~/.local/state/devpilot-studio` (with fallback) | Replaced |
| `~/.local/bin/ccb` | `~/.local/bin/devpilot` | Replaced |
| `CCB_*` environment vars | `DPS_*` / `DEVPILOT_*` (with fallbacks) | Replaced |
| `commands/ccb-setup.md` | `commands/dps-setup.md` | Replaced |
| Upstream URLs (`mr-kumuditha/claude-control-center`) | `mr-kumuditha/devpilot-studio` | Replaced |

---

## 3. Preserved Historical Attributions

In accordance with open-source licensing compliance (MIT License), historical attributions to original project authors in `NOTICE.md`, `LICENSE`, and `README` Credits have been preserved with clear demarcation of rebranding by Kumuditha Labs.
