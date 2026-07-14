# Noctalia ProtonVPN status widget: status script + Luau plugin, enabled and
# placed on the active bar automatically.
function setup_vpn
    set dotfiles_dir $DOTFILES_DIR

    # curl powers the widget's public-IP tooltip lookup; python-tomlkit lets us
    # edit the Noctalia TOML config without clobbering comments/formatting.
    sudo pacman -S --needed --noconfirm curl python-tomlkit; or begin
        print_error "[vpn] can't install packages."
        exit 1
    end

    # Status script used by the plugin.
    mkdir -p ~/.config/noctalia/scripts
    cp $dotfiles_dir/noctalia/vpn-status.sh ~/.config/noctalia/scripts/vpn-status.sh
    chmod +x ~/.config/noctalia/scripts/vpn-status.sh

    # Bar-widget plugin (Noctalia discovers plugins under this dir as a local source).
    set plugin_dir ~/.local/share/noctalia/plugins/diver/vpn
    mkdir -p $plugin_dir
    cp $dotfiles_dir/noctalia/plugins/vpn/plugin.toml $plugin_dir/
    cp $dotfiles_dir/noctalia/plugins/vpn/vpn.luau $plugin_dir/

    # Alias the widget as "vpn", enable the plugin, and place it on the bar.
    mkdir -p ~/.config/noctalia
    cp $dotfiles_dir/noctalia/vpn-widget.toml ~/.config/noctalia/vpn-widget.toml
    python3 $dotfiles_dir/noctalia/install-vpn-widget.py

    # Apply immediately if Noctalia is running.
    if command -v noctalia > /dev/null
        noctalia msg plugins enable diver/vpn 2>/dev/null; or true
        noctalia msg config-reload 2>/dev/null; or true
    end
end
