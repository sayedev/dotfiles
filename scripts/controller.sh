# PS5 / DualSense controller tweaks.
function setup_controller
    set dotfiles_dir $DOTFILES_DIR

    # Stop the DualSense touchpad from acting as a mouse.
    sudo mkdir -p /etc/udev/rules.d
    sudo cp $dotfiles_dir/etc/udev/rules.d/72-ds4tm.rules /etc/udev/rules.d/
    reload_udev
end
