function install_rgb
    if not test -f /etc/modules-load.d/i2c.conf
        echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c.conf > /dev/null
    end

    if not test -d /etc/udev/rules.d
        sudo mkdir -p /etc/udev/rules.d
    end

    sudo mv ./OpenRGB/60-openrgb.rules /usr/lib/udev/rules.d
    sudo udevadm control --reload-rules
    sudo udevadm trigger
end
