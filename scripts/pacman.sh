source (dirname (status --current-filename))/_.sh


function install_pacman
    sudo pacman -S --needed --noconfirm \
        yay \
        blueberry \
        discord \
        linux-headers \
        signal-desktop \
        cachyos-gaming-meta \
        nwg-look \
        protonup-qt \
        rofi \
        rofi-calc \
        swaync \
        waybar \
        docker \
        docker-compose \
        xclip \
        ttf-hack-nerd \
        ttf-jetbrains-mono-nerd \
        qemu \
        virt-manager \
        libvirt \
        thunar \
        tumbler \
        font-manager \
        xarchiver \
        alacritty \
        vlc; or begin
        print_error "[pacman] can't install packages."
        exit 1
    end
end
