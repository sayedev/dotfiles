source (dirname (status --current-filename))/_.sh


function cleanup_installs
    set orphans (pacman -Qtdq 2>/dev/null)
    if test -n "$orphans"
        sudo pacman -Rns --noconfirm $orphans
    end

    sudo pacman -Sc --noconfirm
    yay -Sc --noconfirm 2>/dev/null
end
