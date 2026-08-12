# AUR packages via yay (edit freely). yay itself ships in the CachyOS repo,
# so no manual AUR bootstrap is needed.
function setup_yay_packages
    sudo pacman -S --needed --noconfirm yay; or begin
        print_error "[yay] can't install yay."
        exit 1
    end

    set packages hyprshade onset visual-studio-code-bin

    yay -S --needed --noconfirm $packages; or begin
        print_error "[yay] can't install packages."
        exit 1
    end
end
