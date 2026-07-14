# Everything OpenRGB: dependencies, profile, the bundled AppImage, and the
# device permissions it needs (udev rule + plugdev group).
function setup_openrgb
    set dotfiles_dir $DOTFILES_DIR

    # i2c-tools provides the SMBus access OpenRGB uses for motherboard/RAM.
    sudo pacman -S --needed --noconfirm i2c-tools; or begin
        print_error "[openrgb] can't install packages."
        exit 1
    end

    if not test -f /etc/modules-load.d/i2c.conf
        echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c.conf > /dev/null
    end

    # Profile / settings.
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

    # Device access: udev rule hands nodes to the plugdev group.
    if not getent group plugdev > /dev/null
        sudo groupadd -r plugdev
    end
    sudo gpasswd -a $USER plugdev

    sudo mkdir -p /etc/udev/rules.d
    sudo cp $dotfiles_dir/OpenRGB/60-openrgb.rules /usr/lib/udev/rules.d/
    reload_udev
end
