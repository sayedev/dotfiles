function deploy_config
    set dotfiles_dir $DOTFILES_DIR

    mkdir -p ~/.config
    mkdir -p ~/.themes
    cp -R $dotfiles_dir/hypr/. ~/.config/hypr
    cp -R $dotfiles_dir/rofi ~/.config/rofi
    cp -R $dotfiles_dir/swaync ~/.config/swaync
    cp -R $dotfiles_dir/waybar ~/.config/waybar
    cp -R $dotfiles_dir/wlogout ~/.config/wlogout
    cp -R $dotfiles_dir/OpenRGB ~/.config/OpenRGB
    cp -R $dotfiles_dir/themes/. ~/.themes

    cp $dotfiles_dir/apps/OpenRGB.AppImage $HOME/OpenRGB.AppImage
    chmod +x $HOME/OpenRGB.AppImage
    rm -rf $HOME/OpenRGB $HOME/squashfs-root
    pushd $HOME
    ./OpenRGB.AppImage --appimage-extract >/dev/null
    popd
    mv $HOME/squashfs-root $HOME/OpenRGB
    rm $HOME/OpenRGB.AppImage

    mkdir -p ~/.icons
    cp -R $dotfiles_dir/cursors/Bibata-Modern-Ice ~/.icons/

    sudo mkdir -p /etc/udev/rules.d
    sudo cp $dotfiles_dir/etc/udev/rules.d/72-ds4tm.rules /etc/udev/rules.d/
end
