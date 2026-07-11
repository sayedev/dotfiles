
function setup_services
    if not getent group plugdev > /dev/null
        sudo groupadd -r plugdev
    end

    sudo gpasswd -a $USER plugdev
    sudo gpasswd -a $USER libvirt
    sudo gpasswd -a $USER docker
    sudo gpasswd -a $USER openrazer 2>/dev/null; or true
    sudo systemctl enable libvirtd
    sudo systemctl enable docker
    sudo systemctl disable sddm 2>/dev/null
    # Boot to a plain TTY login on tty1; Hyprland is started manually with
    # `start-hyprland` after login, once the GPU has settled at boot.
    sudo systemctl enable getty@tty1 2>/dev/null
end
