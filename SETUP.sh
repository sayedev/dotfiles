#!/usr/bin/env fish

###############################################################################
#                        DOTFILES INSTALLATION SCRIPT                         #
#                                (minimal)                                    #
#                                                                             #
# The desktop is now handled by Noctalia. This branch only carries the bits   #
# Noctalia does not: OpenRGB (lighting), the PS5/DualSense udev rule, and     #
# the pacman/yay package lists. Each script under scripts/ owns one category  #
# end-to-end (deps + config + permissions).                                  #
#                                                                             #
# OS: CachyOS / Arch Linux                                                    #
# Shell: fish                                                                 #
###############################################################################

set -g DOTFILES_DIR (dirname (status --current-filename))

# lib.sh defines the shared colors/helpers and must be sourced first.
for module in lib openrgb controller pacman yay
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
print_header "PACMAN PACKAGES"
###############################################################################
setup_pacman_packages


###############################################################################
print_header "YAY PACKAGES"
###############################################################################
setup_yay_packages


###############################################################################
print_header "DONE"
###############################################################################
