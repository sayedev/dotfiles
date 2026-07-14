#!/usr/bin/env bash
#
# ProtonVPN status reporter for a Noctalia `custom_button` bar widget.
#
# Emits a single JSON object that Noctalia parses when the widget is configured
# with `parseJson = true`. Recognised keys:
#   text        pill label (plain text, no markup)
#   icon        glyph name (Tabler icon name, Noctalia alias, or U+/0x codepoint)
#   iconColor   theme role: primary | secondary | tertiary | error | none
#   textColor   theme role: primary | secondary | tertiary | error | none
#   tooltip     hover text; "\n" becomes a line break
#
# Colors are theme roles (not hex) so the widget tracks the active Noctalia
# palette instead of hard-coded values.

cache="${XDG_RUNTIME_DIR:-/tmp}/noctalia-vpn-ip"
ttl=120

# Public IP is only used inside tooltips, so cache it (keyed by connection
# state) instead of hitting an external service on every refresh.
get_ip() {
    local sig=$1 now cached_sig cached_ts cached_ip ip
    now=$(date +%s)
    if [[ -f $cache ]]; then
        IFS='|' read -r cached_sig cached_ts cached_ip < "$cache"
        if [[ $cached_sig == "$sig" && $((now - cached_ts)) -lt $ttl ]]; then
            printf '%s' "$cached_ip"
            return
        fi
    fi
    ip=$(curl -s --max-time 2 https://ifconfig.me 2>/dev/null)
    printf '%s|%s|%s' "$sig" "$now" "$ip" > "$cache"
    printf '%s' "$ip"
}

emit() {
    # $1 text  $2 icon  $3 color role  $4 tooltip
    printf '{"text":"%s","icon":"%s","iconColor":"%s","textColor":"%s","tooltip":"%s"}\n' \
        "$1" "$2" "$3" "$3" "$4"
}

# Single nmcli call; derive VPN + kill-switch state from one snapshot.
vpn_line=""
ks_advanced=0
ks_standard=0
while IFS= read -r line; do
    name=${line%%:*}
    [[ $name == pvpn-killswitch-perm ]] && ((ks_advanced++))
    [[ $name == pvpn-killswitch ]] && ((ks_standard++))
    if [[ -z $vpn_line && $line == *[Pp]roton* && $line != *killswitch* ]]; then
        vpn_line=$line
    fi
done < <(nmcli -t -f NAME,TYPE,DEVICE connection show --active 2>/dev/null)

if [[ -n $vpn_line ]]; then
    IFS=: read -r server _ dev <<< "$vpn_line"
    server=${server#ProtonVPN }
    pub_ip=$(get_ip "$server")

    if [[ $ks_advanced -gt 0 ]]; then
        emit "$server" "shield-check" "primary" \
            "Server: $server\nIP: ${pub_ip:-N/A}\nInterface: $dev\nKill Switch: Advanced"
    elif [[ $ks_standard -gt 0 ]]; then
        emit "$server" "shield-half-filled" "tertiary" \
            "Server: $server\nIP: ${pub_ip:-N/A}\nInterface: $dev\nKill Switch: Standard"
    else
        emit "$server" "shield" "error" \
            "Server: $server\nIP: ${pub_ip:-N/A}\nInterface: $dev\nKill Switch: Off"
    fi
elif [[ $ks_advanced -gt 0 ]]; then
    emit "Ghost" "shield-lock" "secondary" \
        "VPN Disconnected\nKill Switch: Advanced\nInternet Blocked"
else
    pub_ip=$(get_ip public)
    emit "Public" "shield-off" "error" \
        "VPN Disconnected\nIP: ${pub_ip:-N/A}"
fi
