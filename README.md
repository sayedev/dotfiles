# dotfiles (CachyOS x Hyprland x Noctalia)

> The full rice lives in [Noctalia](https://github.com/noctalia-dev/noctalia),
> which covers the bar, launcher, notifications, lock screen and theming.
> This repo carries what Noctalia does **not** do, plus a reference copy of
> the Hyprland config itself.

## What's here

- **OpenRGB** — device udev rule (`OpenRGB/60-openrgb.rules`) and the
  `i2c-tools` dependency it needs for motherboard/RAM lighting.
- **PS5 / DualSense** — udev rule (`etc/udev/rules.d/72-ds4tm.rules`) that stops
  the controller touchpad from acting as a mouse.
- **Packages** — everyday apps from the official repos (`scripts/pacman.sh`)
  and the AUR via yay (`scripts/yay.sh`).
- **Hyprland config** — a cold copy of `~/.config/hypr` (`hypr/`), kept here
  for reference/backup. `SETUP.sh` does **not** install it — copy it in
  yourself if you want it: `cp -r hypr/. ~/.config/hypr/`.

## Install

```bash
git clone https://github.com/sayedev/dotfiles.git ~/.cache/dotfiles && ~/.cache/dotfiles/SETUP.sh
```

`SETUP.sh` installs the udev rules, adds you to the `plugdev` group, and
installs the package lists in `scripts/pacman.sh` / `scripts/yay.sh`. It
does not touch `hypr/` — see above.

## Re-running SETUP.sh

`SETUP.sh` is safe to re-run — it converges instead of duplicating: packages
use `pacman --needed` / `yay --needed`, and group/udev steps are guarded or
idempotent.

## Reference

- Noctalia docs: https://docs.noctalia.dev/v5/
