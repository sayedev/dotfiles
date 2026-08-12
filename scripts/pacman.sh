# Everyday packages installed from the official repos (edit freely).
function setup_pacman_packages
    set packages

    # terminals
    set -a packages kitty
    # browsers
    set -a packages librewolf brave-bin
    # communication
    set -a packages signal-desktop
    # system monitoring
    set -a packages btop rocm-smi-lib
    # VPN client
    set -a packages proton-vpn-gtk-app
    # virtualization
    set -a packages qemu-desktop libvirt virt-manager virt-viewer edk2-ovmf swtpm dnsmasq
    # gaming | proton
    set -a packages cachyos-gaming-meta cachyos-gaming-applications protonup-qt

    sudo pacman -S --needed --noconfirm $packages; or begin
        print_error "[pacman] can't install packages."
        exit 1
    end
end
