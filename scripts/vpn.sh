# Noctalia ProtonVPN status widget helper.
function setup_vpn
    set dotfiles_dir $DOTFILES_DIR

    # curl powers the widget's public-IP tooltip lookup.
    sudo pacman -S --needed --noconfirm curl; or begin
        print_error "[vpn] can't install packages."
        exit 1
    end

    mkdir -p ~/.config/noctalia/scripts
    cp $dotfiles_dir/noctalia/vpn-status.sh ~/.config/noctalia/scripts/vpn-status.sh
    chmod +x ~/.config/noctalia/scripts/vpn-status.sh
end
