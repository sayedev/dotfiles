function install_packages
    # Minimal deps: i2c-tools for OpenRGB SMBus support, curl for the VPN
    # widget's public-IP tooltip lookup. OpenRGB itself ships as the bundled
    # AppImage extracted in deploy.sh.
    sudo pacman -S --needed --noconfirm \
        i2c-tools \
        curl; or begin
        print_error "[pacman] can't install packages."
        exit 1
    end
end
