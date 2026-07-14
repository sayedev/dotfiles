#!/usr/bin/env fish

###############################################################################
#                        DOTFILES INSTALLATION SCRIPT                         #
#                                (minimal)                                    #
#                                                                             #
# The desktop is now handled by Noctalia. This branch only carries the bits   #
# Noctalia does not: OpenRGB (lighting), the PS5/DualSense udev rule, and a    #
# ProtonVPN status widget for the Noctalia bar. Each script under scripts/     #
# owns one category end-to-end (deps + config + permissions).                 #
#                                                                             #
# OS: CachyOS / Arch Linux                                                    #
# Shell: fish                                                                 #
###############################################################################

set -g DOTFILES_DIR (dirname (status --current-filename))

# lib.sh defines the shared colors/helpers and must be sourced first.
for module in lib openrgb controller vpn
    source $DOTFILES_DIR/scripts/$module.sh
end


###############################################################################
print_header "OPENRGB"
###############################################################################
setup_openrgb


###############################################################################
print_header "PS5 CONTROLLER"
###############################################################################
setup_controller


###############################################################################
print_header "NOCTALIA VPN WIDGET"
###############################################################################
setup_vpn


###############################################################################
print_header "DONE"
###############################################################################
print_info "Log out/in (or reboot) so the plugdev group and udev rules apply."
print_info "Add the VPN widget: merge noctalia/vpn-widget.toml into"
print_info "~/.config/noctalia/config.toml, then run: noctalia msg config-reload"
