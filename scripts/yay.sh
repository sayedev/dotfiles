source (dirname (status --current-filename))/_.sh


function install_yay
    yay -S --needed --noconfirm \
        hyprshade \
        hyprlock \
        hyprpaper \
        hyprshot \
        greetd-regreet-git \
        visual-studio-code-bin \
        cursor-bin \
        1password \
        dualsensectl \
        razer-cli \
        polychromatic \
        kora-icon-theme \
        themix-full-git; or begin
        print_error "[yay] can't install packages."
        exit 1
    end
end
