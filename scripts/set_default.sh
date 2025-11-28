function apply_default_applications
    # Web browser - WaterFox
    xdg-mime default waterfox.desktop x-scheme-handler/http
    xdg-mime default waterfox.desktop x-scheme-handler/https
    xdg-mime default waterfox.desktop text/html

    # PDF viewer - WaterFox
    xdg-mime default waterfox.desktop application/pdf

    # Image viewer - WaterFox
    for mime in image/jpeg image/png image/gif image/webp image/svg+xml image/bmp image/tiff
        xdg-mime default waterfox.desktop $mime
    end

    # File manager - Thunar
    xdg-mime default thunar.desktop inode/directory
    xdg-mime default thunar.desktop application/x-directory

    # Terminal - Alacritty
    xdg-mime default Alacritty.desktop x-scheme-handler/terminal

    # Archive manager - Xarchiver
    for mime in application/zip application/x-tar application/x-compressed-tar application/x-7z-compressed application/x-rar application/x-gzip application/x-bzip application/x-xz
        xdg-mime default xarchiver.desktop $mime
    end

    # Text editor - VS Code
    xdg-mime default code.desktop text/plain
    xdg-mime default code.desktop text/x-python
    xdg-mime default code.desktop text/x-script.python

    # Media player - VLC
    for mime in video/mp4 video/x-matroska video/webm video/mpeg video/x-msvideo video/x-flv video/quicktime video/x-ms-wmv audio/mpeg audio/ogg audio/x-wav audio/webm audio/flac audio/x-flac audio/mp4 audio/aac
        xdg-mime default vlc.desktop $mime
    end
end
