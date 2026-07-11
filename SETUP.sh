#!/usr/bin/env fish

###############################################################################
#                         DOTFILES INSTALLATION SCRIPT                        #
#                                                                             #
# This script automates the installation and configuration of a custom       #
# Hyprland desktop environment with all necessary dependencies and configs.  #
#                                                                             #
# OS: Arch Linux                                                              #
# Shell: fish                                                                 #
###############################################################################

set -g DOTFILES_DIR (dirname (status --current-filename))

# _.sh defines the shared colors/helpers and must be sourced first.
for module in _ pacman yay cleanup move_files rgb fish remove systemctl
    source $DOTFILES_DIR/scripts/$module.sh
end



###############################################################################
print_header "RANKING MIRRORS"
###############################################################################
sudo cachyos-rate-mirrors
sudo pacman -Syy


###############################################################################
print_header "INSTALLING PACMAN PACKAGES"
###############################################################################
install_pacman


###############################################################################
print_header "INSTALLING AUR PACKAGES"
###############################################################################
install_yay


###############################################################################
print_header "DEPLOYING CONFIGURATION FILES"
###############################################################################
deploy_config


###############################################################################
print_header "SETTING UP RGB SUPPORT"
###############################################################################
install_rgb


###############################################################################
print_header "CONFIGURING FISH SHELL"
###############################################################################
customize_fish


###############################################################################
print_header "REMOVING UNWANTED SOFTWARE"
###############################################################################
remove_software


###############################################################################
print_header "CLEANING UP"
###############################################################################
cleanup_installs


###############################################################################
print_header "ENABLING SYSTEM SERVICES"
###############################################################################
setup_services


##########################################################################
print_header "REBOOT REQUIRED"
##########################################################################

read -P (printf "$YELLOW""Reboot now? (Y/n): $NC") -n 1 response
echo ""
set response (string lower -- $response)

if test -z "$response"; or test "$response" = "y"
    echo -e "$CYAN""Rebooting system...$NC"
    sudo reboot
else
    echo -e "$GREEN""Reboot cancelled. Please reboot manually when ready.$NC"
end
