# universal-modder for Antigravity

This toolkit enables AI agents in Antigravity to mod games systematically.
Start with the `mod-any-game` skill and follow its loop:
intake → recon → route → lab → source of truth → vertical slice → assets → verify in game → publish.

## Tools
- `um` on PATH (or `bin/um.ps1` in the repo / `~/.gemini/config/plugins/universal-modder/bin/um.ps1`) is the CLI. Every group has `--help`:
  - `scan`: detect installed games (Steam/Epic/Xbox), engines, mod loaders, save locations, routes.
  - `kb`: search the knowledge base of reverse-engineering field notes and game teardowns (`um kb search "<game>"`).
  - `sprite`: 2D spritesheet packing, background cutout, fitting, pixelation, and palette snapping.
  - `render3d`: render 3D models into multi-angle 2D sprite frames (`um render3d`).
  - `comfy`: local ComfyUI image/texture generation.
  - `win`: Windows game window management, screenshot capture, process inspection, exact-PID control.
  - `video`: contact sheets, video compilation, and audio muxing for showcase clips (`um video`).
  - `backup`: snapshot and restore save folders before launching modded sessions (`um backup create`).
  - `publish`: lint mod folders before sharing.
- Assets: Use Antigravity's built-in image generation (`image-generator` subagent) or local offline tools (`um comfy`, `um render3d`, `um sprite`).

## Modding Guidelines
- **Save Backups:** Run `um backup create` before launching modded games or modifying saves. Record restore paths in `MODLOG.md`.
- **Local Caching:** Save decompiled game code locally on disk (in the `DecompiledSource` folder) to save time and tokens in future chats.
- **Process Hygiene:** Manage processes by exact PID (`um win kill <pid>`).
- **Auto-Control & Auto-Install:** Emulate keyboard/mouse input during game testing and install mod loaders directly into game directories automatically.
- **Context Resumption:** At the start of any conversation, search for and read `MODLOG.md` and the `DecompiledSource` directory to instantly regain full project context.
- **Journal:** Maintain a `MODLOG.md` file in the mod folder documenting addresses, IDs, engine findings, and reproduction steps.
