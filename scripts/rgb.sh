function install_rgb
    set dotfiles_dir $DOTFILES_DIR

    # OpenRGB needs the i2c-dev module for motherboard/RAM SMBus access.
    if not test -f /etc/modules-load.d/i2c.conf
        echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c.conf > /dev/null
    end

    sudo mkdir -p /etc/udev/rules.d

    # OpenRGB device permissions (plugdev group, 0660).
    sudo cp $dotfiles_dir/OpenRGB/60-openrgb.rules /usr/lib/udev/rules.d/
    # Stop the DualSense touchpad from acting as a mouse.
    sudo cp $dotfiles_dir/etc/udev/rules.d/72-ds4tm.rules /etc/udev/rules.d/

    sudo udevadm control --reload-rules
    sudo udevadm trigger
end
