#!/usr/bin/env bash

GRN='#50FA7B'
YLW='#FFE08F'
RED='#BF1A1A'
BLU='#8BE9FD'

cache="${XDG_RUNTIME_DIR:-/tmp}/waybar-vpn-ip"
ttl=120

# Public IP is only used inside tooltips, so cache it (keyed by connection
# state) instead of hitting an external service on every 5s refresh.
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
        text="<span color='${GRN}'>󰕥</span> ${server}"
        tooltip="Server: $server\nIP: ${pub_ip:-N/A}\nInterface: $dev\nKill Switch: Advanced"
    elif [[ $ks_standard -gt 0 ]]; then
        text="<span color='${YLW}'>󰕥</span> ${server}"
        tooltip="Server: $server\nIP: ${pub_ip:-N/A}\nInterface: $dev\nKill Switch: Standard"
    else
        text="<span color='${RED}'>󰒃</span> ${server}"
        tooltip="Server: $server\nIP: ${pub_ip:-N/A}\nInterface: $dev"
    fi

    printf '{"text":"%s","tooltip":"%s","class":"connected"}\n' "$text" "$tooltip"
elif [[ $ks_advanced -gt 0 ]]; then
    text="<span color='${BLU}'>󰕥</span> Ghost"
    tooltip="VPN Disconnected\nKill Switch: Advanced\nInternet Blocked"

    printf '{"text":"%s","tooltip":"%s","class":"blocked"}\n' "$text" "$tooltip"
else
    pub_ip=$(get_ip public)
    text="<span color='${RED}'>󰕤</span> Public"
    tooltip="VPN Disconnected\nIP: ${pub_ip:-N/A}"

    printf '{"text":"%s","tooltip":"%s","class":"disconnected"}\n' "$text" "$tooltip"
fi
