# Noctalia ProtonVPN status widget: helper script, widget definition, and
# automatic placement onto the active bar.
function setup_vpn
    set dotfiles_dir $DOTFILES_DIR

    # curl powers the widget's public-IP tooltip lookup; python-tomlkit lets us
    # edit the Noctalia TOML config without clobbering comments/formatting.
    sudo pacman -S --needed --noconfirm curl python-tomlkit; or begin
        print_error "[vpn] can't install packages."
        exit 1
    end

    # Status script.
    mkdir -p ~/.config/noctalia/scripts
    cp $dotfiles_dir/noctalia/vpn-status.sh ~/.config/noctalia/scripts/vpn-status.sh
    chmod +x ~/.config/noctalia/scripts/vpn-status.sh

    # Widget definition drop-in (merged by Noctalia alongside your config).
    mkdir -p ~/.config/noctalia
    cp $dotfiles_dir/noctalia/vpn-widget.toml ~/.config/noctalia/vpn-widget.toml

    # Place "vpn" on the active bar (edits whichever layer actually wins).
    python3 $dotfiles_dir/noctalia/install-vpn-widget.py

    # Apply immediately if Noctalia is running.
    if command -v noctalia > /dev/null
        noctalia msg config-reload 2>/dev/null; or true
    end
end
