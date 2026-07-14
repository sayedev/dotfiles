# dotfiles — minimal (CachyOS x Noctalia)

> The full Hyprland rice moved to [Noctalia](https://github.com/noctalia-dev/noctalia),
> which now covers the bar, launcher, notifications, lock screen and theming.
> This `minimal` branch only keeps what Noctalia does **not** do.

## What's here

- **OpenRGB** — bundled AppImage (`apps/OpenRGB.AppImage`), profile
  (`OpenRGB/OpenRGB.json`) and device udev rules (`OpenRGB/60-openrgb.rules`).
- **PS5 / DualSense** — udev rule (`etc/udev/rules.d/72-ds4tm.rules`) that stops
  the controller touchpad from acting as a mouse.
- **VPN widget** — a ProtonVPN status indicator for the Noctalia bar
  (`noctalia/`), built on Noctalia's `custom_button` widget.

## Install

```bash
git clone -b minimal https://github.com/sayedev/dotfiles.git ~/.cache/dotfiles && ~/.cache/dotfiles/SETUP.sh
```

`SETUP.sh` extracts OpenRGB to `~/OpenRGB`, deploys the OpenRGB profile, installs
the udev rules, adds you to the `plugdev` group, and sets up the VPN widget end
to end (script + definition + bar placement).

## Noctalia VPN widget

Noctalia has no native VPN module, so the indicator rides on the `custom_button`
widget in dynamic-text mode: it runs `vpn-status.sh` every few seconds and
renders the JSON it prints (label, glyph, theme color, tooltip).

The `vpn` step wires this up automatically:

1. copies `vpn-status.sh` to `~/.config/noctalia/scripts/`,
2. drops the widget definition (`vpn-widget.toml`) into `~/.config/noctalia/`,
3. runs `install-vpn-widget.py`, which inserts `"vpn"` into your active bar —
   editing the layer that actually wins (GUI state `settings.toml` if it defines
   the bar, otherwise your hand-written config) while preserving formatting,
4. reloads Noctalia if it's running.

If no bar layout is found in your files (bar uses Noctalia's built-in defaults),
the widget is still installed — add it from **Settings → Bar → Bar Widgets**.
To re-run just the placement step later:

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

## Reference

- Noctalia docs: https://docs.noctalia.dev/v5/
- Bar widgets: https://docs.noctalia.dev/v5/bar/widgets/
