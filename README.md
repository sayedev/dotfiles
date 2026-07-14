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

`SETUP.sh` installs `i2c-tools` + `curl`, extracts OpenRGB to `~/OpenRGB`,
deploys the OpenRGB profile, installs the udev rules, copies the VPN script to
`~/.config/noctalia/scripts/`, and adds you to the `plugdev` group.

## Noctalia VPN widget

Noctalia has no native VPN module, so the indicator rides on the `custom_button`
widget in dynamic-text mode: it runs `vpn-status.sh` every few seconds and
renders the JSON it prints (label, glyph, theme color, tooltip).

To enable it, merge `noctalia/vpn-widget.toml` into
`~/.config/noctalia/config.toml` (add `"vpn"` to a bar section), then:

```bash
noctalia msg config-reload
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
