function customize_fish
    mkdir -p ~/.config/fish
    if not test -f ~/.config/fish/config.fish
        echo "# Fish shell configuration" > ~/.config/fish/config.fish
    end

    if not grep -q "^function fish_greeting" ~/.config/fish/config.fish
        echo "" >> ~/.config/fish/config.fish
        echo "# Override fish_greeting to disable fastfetch/system info" >> ~/.config/fish/config.fish
        echo "function fish_greeting" >> ~/.config/fish/config.fish
        echo "    # Disabled - no greeting message" >> ~/.config/fish/config.fish
        echo "end" >> ~/.config/fish/config.fish
    end
end
