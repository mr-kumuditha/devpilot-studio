# Dependency & Asset Audit Report — DevPilot Studio

**Project:** DevPilot Studio (`dps` / `devpilot`) v1.0.0  
**Date:** 2026-08-04  

---

## 1. Runtime Dependencies

DevPilot Studio maintains a zero-dependency design in `package.json` for maximum portability, security, and instantaneous startup.

```json
{
  "dependencies": {},
  "devDependencies": {}
}
```

### System CLI Dependencies

| Dependency | Required Version | Purpose | Fallback Behavior |
| --- | --- | --- | --- |
| **Node.js** | `>=14.0.0` | CLI package entry (`cli.js`) | Required for `npx devpilot-studio` / `dps` |
| **Bash** | `>=3.2` | Shell script execution (`bin/devpilot`) | Required on macOS/Linux |
| **jq** | Any standard version | Processing status JSON stdin | Warns and provides installation instructions if missing |
| **awk / date** | POSIX standard | History calculation & countdowns | Built into macOS & Linux systems |

---

## 2. Asset & Binary Inventory

The `assets/` folder contains high-resolution icons and branding vectors:

| Asset File | Format | Purpose | Status |
| --- | --- | --- | --- |
| `dps-icon.svg` | SVG Vector | Rebranded icon vector | Maintained & Rebranded |
| `dps-icon-monochrome.svg` | SVG Vector | Monochrome icon vector | Maintained & Rebranded |
| `dps-icon-512.png` | PNG Image | 512x512 PNG app icon | Maintained |
| `dps-icon-1024.png` | PNG Image | 1024x1024 PNG app icon | Maintained |
| `dps-logo-horizontal.png` | PNG Image | Horizontal branded logo | Maintained |
| `dps-logo-horizontal.svg` | SVG Vector | Horizontal branded vector | Maintained |
| `dps-preview.png` | PNG Image | Preview screenshot | Maintained |

---

## 3. Dependency Cleanup Recommendations

- Keep runtime dependencies at zero to avoid security vulnerabilities and installation latency.
- Include `jq` check and automated install guidance across macOS (Homebrew) and Linux package managers (`apt`, `dnf`, `pacman`, `apk`).
