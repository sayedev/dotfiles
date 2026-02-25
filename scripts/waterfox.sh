source (dirname (status --current-filename))/_.sh


function install_waterfox
    set waterfox_url "https://cdn1.waterfox.net/waterfox/releases/latest/linux"
    set waterfox_file "/tmp/waterfox-latest.tar.bz2"

    curl -L -o $waterfox_file "$waterfox_url"; or begin
        print_warning "Failed to download WaterFox, continuing with installation..."
    end

    if not test -f $waterfox_file
        print_warning "WaterFox download file not found, skipping installation"
        return
    end

    sudo mkdir -p /opt/waterfox

    if not sudo tar xjf $waterfox_file -C /opt/waterfox --strip-components=1
        print_warning "Failed to extract WaterFox, skipping installation"
        rm -f $waterfox_file
        return
    end

    if not test -f /opt/waterfox/waterfox
        print_warning "WaterFox binary not found after extraction"
        rm -f $waterfox_file
        return
    end

    printf '%s\n' \
        '[Desktop Entry]' \
        'Version=1.0' \
        'Name=WaterFox' \
        'Comment=Browse the World Wide Web' \
        'GenericName=Web Browser' \
        'Keywords=Internet;WWW;Browser;Web;Explorer' \
        'Exec=/opt/waterfox/waterfox %u' \
        'Terminal=false' \
        'X-MultipleArgs=false' \
        'Type=Application' \
        'Icon=/opt/waterfox/browser/chrome/icons/default/default128.png' \
        'Categories=GNOME;GTK;Network;WebBrowser;' \
        'MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;' \
        'StartupNotify=true' \
        | sudo tee /usr/share/applications/waterfox.desktop > /dev/null

    printf '%s\n' \
        '[Desktop Entry]' \
        'Version=1.5' \
        'Version=1.5' \
        'Name=OpenRGB' \
        'Keywords=open;rgb' \
        'Exec=/home/diver/OpenRGB/bin/OpenRGB' \
        'Terminal=false' \
        'X-MultipleArgs=false' \
        'Type=Application' \
        'Icon=/home/diver/OpenRGB/usr/share/icons/hicolor/128x128/apps/org.openrgb.OpenRGB.png' \
        'StartupNotify=true' \
        'NoDisplay=false' \
        | sudo tee /usr/share/applications/waterfox-private.desktop > /dev/null

    rm -f $waterfox_file
end
