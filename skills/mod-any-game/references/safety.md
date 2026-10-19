# Technical stability and workspace hygiene

These practices ensure safe local testing, reliable backups, and clean environment state throughout the modding lifecycle.

## Workspace and file management
- **Local Caching:** Save decompiled code into the gitignored `DecompiledSource/` folder to preserve context across agent sessions and eliminate repeated decompilation costs.
- **Save Backups:** Before running modified code or changing configs, always run `um backup create` to snapshot save folders. Record restore paths in `MODLOG.md`.
- **Modded Launchers:** When installing loaders or proxy DLLs (`winhttp.dll`, `version.dll`, `dinput8.dll`, `dxgi.dll`), note added files in `MODLOG.md` for clean tracking and removal.

## Process hygiene
- **Process Management:** Manage game processes by exact PID (`um win kill <pid>`). Avoid broad wildcard terminations.
- **Crash Reporters:** When a game encounters an unhandled exception or crash dialog (BugSplat, WerFault), terminate the reporter dialog by PID to free file handles before relaunching.
- **Topmost Windows:** When using automated test drivers, avoid leaving topmost windows stuck above other desktop applications.

## Input automation and driving
- **Window Targeting:** Input automation (`um win drive`) sends inputs directly to the targeted game client area.
- **Idle Checks:** Use `um win drive --proc <game> idle` to confirm input state and avoid collisions with user activity.

## Publication linting
- Run `um publish check` to verify mod archives and directories before release, confirming all necessary assets and install instructions are present.
