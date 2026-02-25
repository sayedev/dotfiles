source (dirname (status --current-filename))/_.sh


function install_yay
    yay -S --needed --noconfirm \
        hyprshade \
        hyprshot \
        hypr-cycle \
        greetd-regreet-git \
        1password \
        cursor-bin \
        visual-studio-code-bin \
        razer-cli \
        polychromatic \
        kora-icon-theme \
        selectdefaultapplication-fork-git \
        themix-full-git; or begin
        print_error "[yay] can't install packages."
        exit 1
    end
end
