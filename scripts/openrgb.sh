# Everything OpenRGB: dependencies (i2c-tools) and the device permissions
# it needs (udev rule + plugdev group).
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

    # Device access: udev rule hands nodes to the plugdev group.
    if not getent group plugdev > /dev/null
        sudo groupadd -r plugdev
    end
    sudo gpasswd -a $USER plugdev

    sudo mkdir -p /etc/udev/rules.d
    sudo cp $dotfiles_dir/OpenRGB/60-openrgb.rules /etc/udev/rules.d/
    reload_udev
end
