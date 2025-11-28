function install_rgb
    if not test -f /etc/modules-load.d/i2c.conf
        echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c.conf > /dev/null
    end

    echo 'KERNEL=="i2c-[0-99]*", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-i2c.rules > /dev/null

    if not test -d /etc/udev/rules.d
        sudo mkdir -p /etc/udev/rules.d
    end

    if not test -f /etc/modules-load.d/razer.conf
        echo "razerkbd" | sudo tee /etc/modules-load.d/razer.conf > /dev/null
        echo "razermouse" | sudo tee -a /etc/modules-load.d/razer.conf > /dev/null
    end

    sudo udevadm control --reload-rules
    sudo udevadm trigger
end
