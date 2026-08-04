# Changelog

All notable changes to DevPilot Studio are documented here. This project adheres to [Semantic Versioning](https://semver.org/).

## [1.0.0] - 2026-08-04

Initial release of **DevPilot Studio (DPS)** by **Kumuditha Labs (Kumuditha Tharinda Liyanage)**.

### Features
- **Real-Time Status Bar**: Renders active model name, effort level, workspace repository context, and progress bars for context window, 5-hour, and 7-day rate limits.
- **Velocity Warning (`⚠`)**: Real-time velocity warning when usage speed projects hitting quotas before reset countdowns.
- **Detailed Usage Metrics (`dps stats`)**: Terminal usage panel showing token counts, reset countdowns, and session spending.
- **7-Day Sparkline Trends (`dps history`)**: Analytical sparklines and daily peak rollups.
- **Preset Gallery & Setup Wizard (`dps gallery`, `dps config`)**: Themes (`default`, `mono`, `vivid`) and customizable bar styles.
- **Zero Runtime Dependencies**: Ultra-lightweight POSIX Bash and Node.js implementation with 100% offline local privacy.
