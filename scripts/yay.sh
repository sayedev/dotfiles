function install_yay
    yay -S --needed --noconfirm \
        hyprshade \
        hyprshot \
        hypr-cycle \
        1password \
        cursor-bin \
        brave-bin \
        visual-studio-code-bin \
        razer-cli \
        waterfox-bin \
        librewolf-bin \
        kora-icon-theme \
        selectdefaultapplication-fork-git \
        postman-bin \
        themix-full-git; or begin
        print_error "[yay] can't install packages."
        exit 1
    end
end
