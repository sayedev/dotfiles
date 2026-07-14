function setup_services
    # OpenRGB udev rules hand device nodes to the plugdev group.
    if not getent group plugdev > /dev/null
        sudo groupadd -r plugdev
    end
    sudo gpasswd -a $USER plugdev
end
