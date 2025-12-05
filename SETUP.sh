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

source (dirname (status --current-filename))/scripts/_.sh
source (dirname (status --current-filename))/scripts/pacman.sh
source (dirname (status --current-filename))/scripts/yay.sh
source (dirname (status --current-filename))/scripts/cleanup.sh
source (dirname (status --current-filename))/scripts/waterfox.sh
source (dirname (status --current-filename))/scripts/move_files.sh
source (dirname (status --current-filename))/scripts/rgb.sh
source (dirname (status --current-filename))/scripts/fish.sh
source (dirname (status --current-filename))/scripts/remove.sh
source (dirname (status --current-filename))/scripts/systemctl.sh



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
print_header "INSTALLING WATERFOX"
###############################################################################
install_waterfox


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
