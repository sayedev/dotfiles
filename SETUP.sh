#!/usr/bin/env fish

###############################################################################
#                        DOTFILES INSTALLATION SCRIPT                         #
#                                (minimal)                                    #
#                                                                             #
# The desktop is now handled by Noctalia. This branch only carries the bits   #
# Noctalia does not: OpenRGB (lighting), the PS5/DualSense udev rule, and a    #
# ProtonVPN status widget for the Noctalia bar.                               #
#                                                                             #
# OS: CachyOS / Arch Linux                                                    #
# Shell: fish                                                                 #
###############################################################################

set -g DOTFILES_DIR (dirname (status --current-filename))

# _.sh defines the shared colors/helpers and must be sourced first.
for module in _ packages deploy rgb services
    source $DOTFILES_DIR/scripts/$module.sh
end


###############################################################################
print_header "INSTALLING PACKAGES"
###############################################################################
install_packages


###############################################################################
print_header "DEPLOYING OPENRGB + VPN WIDGET"
###############################################################################
deploy_config


###############################################################################
print_header "SETTING UP RGB SUPPORT"
###############################################################################
install_rgb


###############################################################################
print_header "CONFIGURING GROUPS"
###############################################################################
setup_services


###############################################################################
print_header "DONE"
###############################################################################
print_info "Log out/in (or reboot) so the plugdev group and udev rules apply."
print_info "Add the VPN widget: merge noctalia/vpn-widget.toml into"
print_info "~/.config/noctalia/config.toml, then run: noctalia msg config-reload"
