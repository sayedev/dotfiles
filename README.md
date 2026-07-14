# dotfiles — minimal (CachyOS x Noctalia)

> The full Hyprland rice moved to [Noctalia](https://github.com/noctalia-dev/noctalia),
> which now covers the bar, launcher, notifications, lock screen and theming.
> This `minimal` branch only keeps what Noctalia does **not** do.

## What's here

- **OpenRGB** — bundled AppImage (`apps/OpenRGB.AppImage`), profile
  (`OpenRGB/OpenRGB.json`) and device udev rules (`OpenRGB/60-openrgb.rules`).
- **PS5 / DualSense** — udev rule (`etc/udev/rules.d/72-ds4tm.rules`) that stops
  the controller touchpad from acting as a mouse.
- **VPN widget** — a ProtonVPN status indicator for the Noctalia bar, shipped as
  a Noctalia plugin (`noctalia/plugins/vpn/`) driven by `vpn-status.sh`.

## Install

```bash
git clone -b minimal https://github.com/sayedev/dotfiles.git ~/.cache/dotfiles && ~/.cache/dotfiles/SETUP.sh
```

`SETUP.sh` extracts OpenRGB to `~/OpenRGB`, deploys the OpenRGB profile, installs
the udev rules, adds you to the `plugdev` group, and sets up the VPN widget end
to end (script + definition + bar placement).

## Noctalia VPN widget

Noctalia v5 has no native VPN widget, and its native widgets can't poll a
command (the v5 `custom_button` is static — that's why hand-rolled configs show a
default heart glyph). The supported way to get a live widget is a **plugin**, so
this ships one: `diver/vpn`, a Luau bar widget that runs `vpn-status.sh`, parses
its JSON, and renders the server label, a shield glyph, a theme color and a
tooltip. Left-click opens `nm-connection-editor`.

The `vpn` setup step wires it up automatically:

1. copies `vpn-status.sh` to `~/.config/noctalia/scripts/`,
2. installs the plugin to `~/.local/share/noctalia/plugins/vpn/` (Noctalia's local
   source scans one level deep; the `diver/vpn` id lives in `plugin.toml`),
3. drops `vpn-widget.toml` into `~/.config/noctalia/` (aliases the widget as `vpn`),
4. runs `install-vpn-widget.py`, which enables the plugin in `config.toml` and
   inserts `"vpn"` into your active bar — editing the layer that actually wins
   (GUI state `settings.toml` if it defines the bar, else your config),
5. enables the plugin and reloads Noctalia if it's running.

If no bar layout is found in your files (bar uses Noctalia's built-in defaults),
the plugin is still installed/enabled — add the widget from
**Settings → Bar → Bar Widgets**. To re-run just the enable/placement step:

```bash
python3 ~/.cache/dotfiles/noctalia/install-vpn-widget.py && noctalia msg config-reload
```

State → glyph / color:

| State | Glyph | Color role |
| --- | --- | --- |
| Connected, advanced kill switch | `shield-check` | primary |
| Connected, standard kill switch | `shield-half-filled` | tertiary |
| Connected, no kill switch | `shield` | error |
| Disconnected, kill switch blocking | `shield-lock` | secondary |
| Disconnected (public IP) | `shield-off` | error |

Colors are Noctalia theme roles, so the widget follows your active palette.

## Re-running SETUP.sh

`SETUP.sh` is safe to re-run — it converges instead of duplicating:

- packages use `pacman --needed`; group/udev/module steps are guarded or idempotent;
- the OpenRGB profile and the extracted `~/OpenRGB` are **kept** if present (delete
  them to redeploy the bundled versions);
- the VPN script/plugin are refreshed (so updates land), and the installer only
  enables the plugin / adds the bar widget if they aren't already there.

Coming from an earlier version whose bar shows a heart glyph? Pull the latest,
re-run `SETUP.sh` (installs + enables the plugin). If you had manually added a
`custom_button` VPN widget via the GUI, remove that one from
**Settings → Bar → Bar Widgets** — the plugin widget replaces it.

## Reference

- Noctalia docs: https://docs.noctalia.dev/v5/
- Bar widgets: https://docs.noctalia.dev/v5/bar/widgets/
