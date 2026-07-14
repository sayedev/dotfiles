#!/usr/bin/env python3
"""Place the "vpn" widget on the active Noctalia bar.

The widget *definition* is shipped as a drop-in (vpn-widget.toml). This script
only handles bar placement: it inserts "vpn" into the correct lane of the layer
that actually wins.

Noctalia merges config in this order (later wins):
  1. built-in defaults
  2. every *.toml in ~/.config/noctalia/ (alphabetical)
  3. GUI state in ~/.local/state/noctalia/settings.toml

So if the GUI state defines the bar, editing config.toml would be ignored; we
edit whichever layer defines the bar last. Formatting/comments are preserved.
"""
import os
import sys
from pathlib import Path

try:
    import tomlkit
except ModuleNotFoundError:
    sys.exit("error: python-tomlkit is not installed (pacman -S python-tomlkit)")

WIDGET = "vpn"
LANES = ("end", "center", "start")


def config_dir() -> Path:
    base = os.environ.get("XDG_CONFIG_HOME") or (Path.home() / ".config")
    return Path(base) / "noctalia"


def state_settings() -> Path:
    base = os.environ.get("XDG_STATE_HOME") or (Path.home() / ".local" / "state")
    return Path(base) / "noctalia" / "settings.toml"


def load(path: Path):
    try:
        return tomlkit.parse(path.read_text())
    except Exception as exc:  # noqa: BLE001 - report and skip unreadable files
        print(f"  ! skipping {path}: {exc}")
        return None


def bar_tables(doc):
    """Yield (name, table) for every [bar.<name>] definition table."""
    bar = doc.get("bar")
    if not hasattr(bar, "items"):
        return
    for name, value in bar.items():
        if name != "order" and hasattr(value, "get"):
            yield name, value


def has_lanes(table) -> bool:
    return any(lane in table for lane in LANES)


def already_present(table) -> bool:
    return any(WIDGET in list(table.get(lane, [])) for lane in LANES)


def main() -> int:
    # Merge order low -> high priority (last wins).
    ordered = sorted(config_dir().glob("*.toml"))
    if state_settings().exists():
        ordered.append(state_settings())

    parsed = [(p, doc) for p in ordered if (doc := load(p)) is not None]

    # Target bar: prefer "main", else the first bar defined anywhere.
    target = None
    for _, doc in parsed:
        names = [n for n, _ in bar_tables(doc)]
        if "main" in names:
            target = "main"
            break
        if names and target is None:
            target = names[0]

    if target is None:
        print("No [bar.*] layout found in your config or GUI state.")
        print(f"'{WIDGET}' is installed; add it from Settings -> Bar -> Bar Widgets.")
        return 0

    # Edit the last (highest-priority) layer that defines the target bar's lanes.
    edit = None  # (path, doc, table)
    for path, doc in parsed:
        for name, table in bar_tables(doc):
            if name == target and has_lanes(table):
                edit = (path, doc, table)

    if edit is None:
        print(f"Bar '{target}' uses Noctalia's default lanes (none set in your files).")
        print(f"'{WIDGET}' is installed; add it from Settings -> Bar -> Bar Widgets.")
        return 0

    path, doc, table = edit
    if already_present(table):
        print(f"'{WIDGET}' already on bar '{target}' ({path}). Nothing to do.")
        return 0

    lane = next(lane for lane in LANES if lane in table)
    table[lane].append(WIDGET)
    path.write_text(tomlkit.dumps(doc))
    print(f"Added '{WIDGET}' to [bar.{target}].{lane} in {path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
