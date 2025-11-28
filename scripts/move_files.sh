function deploy_config
    set script_dir (dirname (status --current-filename))
    set dotfiles_dir (dirname $script_dir)

    mkdir -p ~/.config
    mkdir -p ~/.themes
    cp -R $dotfiles_dir/hypr/. ~/.config/hypr
    cp -R $dotfiles_dir/rofi ~/.config/rofi
    cp -R $dotfiles_dir/swaync ~/.config/swaync
    cp -R $dotfiles_dir/waybar ~/.config/waybar
    cp -R $dotfiles_dir/OpenRGB ~/.config/OpenRGB
    cp -R $dotfiles_dir/themes/. ~/.themes

    cp $dotfiles_dir/apps/OpenRGB.AppImage ~/OpenRGB.AppImage
    chmod +x ~/OpenRGB.AppImage

    mkdir -p ~/.icons
    cp -R $dotfiles_dir/cursors/Bibata-Modern-Ice ~/.icons/

    sudo cp -R $dotfiles_dir/etc/greetd/. /etc/greetd
    sudo mkdir -p /usr/share/wallpapers
    sudo cp $dotfiles_dir/hypr/wallpapers/red-j.jpg /usr/share/wallpapers/
end
