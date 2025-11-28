source (dirname (status --current-filename))/_.sh


function install_yay
    yay -S --needed --noconfirm \
        dualsensectl \
        hyprshade \
        hyprlock \
        hyprpaper \
        greetd-regreet-git \
        visual-studio-code-bin \
        cursor-bin \
        hyprshot \
        themix-full-git \
        1password \
        razer-cli \
        polychromatic; or begin
        print_error "[yay] can't install packages."
        exit 1
    end
end
