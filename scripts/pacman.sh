function install_pacman
    sudo pacman -S --needed --noconfirm \
        nm-connection-editor \
        blueberry \
        yay \
        linux-headers \
        cachyos-gaming-meta \
        protonup-qt \
        rofi \
        rofi-calc \
        swaync \
        waybar \
        xclip \
        docker \
        docker-compose \
        ttf-hack-nerd \
        ttf-jetbrains-mono-nerd \
        qemu virt-manager libvirt \
        thunar tumbler thunar-volman gvfs \
        signal-desktop \
        proton-vpn-gtk-app \
        xarchiver \
        alacritty \
        nwg-look \
        rocm-smi-lib \
        hyprlock \
        hyprpaper \
        hyprpolkitagent \
        hyprpicker \
        obs-studio \
        network-manager-applet \
        qt6ct \
        adwaita-qt6 \
        gnome-themes-extra \
        gnome-keyring \
        libsecret \
        gnome-calculator \
        wlogout \
        mpv; or begin
        print_error "[pacman] can't install packages."
        exit 1
    end
end
