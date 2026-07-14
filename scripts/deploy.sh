function deploy_config
    set dotfiles_dir $DOTFILES_DIR

    # OpenRGB profile / settings.
    mkdir -p ~/.config/OpenRGB
    cp $dotfiles_dir/OpenRGB/OpenRGB.json ~/.config/OpenRGB/

    # Extract the bundled OpenRGB AppImage into ~/OpenRGB.
    cp $dotfiles_dir/apps/OpenRGB.AppImage $HOME/OpenRGB.AppImage
    chmod +x $HOME/OpenRGB.AppImage
    rm -rf $HOME/OpenRGB $HOME/squashfs-root
    pushd $HOME
    ./OpenRGB.AppImage --appimage-extract >/dev/null
    popd
    mv $HOME/squashfs-root $HOME/OpenRGB
    rm $HOME/OpenRGB.AppImage

    # Noctalia VPN widget helper script.
    mkdir -p ~/.config/noctalia/scripts
    cp $dotfiles_dir/noctalia/vpn-status.sh ~/.config/noctalia/scripts/vpn-status.sh
    chmod +x ~/.config/noctalia/scripts/vpn-status.sh
end
