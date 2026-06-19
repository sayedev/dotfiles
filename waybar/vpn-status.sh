#!/usr/bin/env bash

vpn_line=$(nmcli -t -f NAME,TYPE,DEVICE connection show --active 2>/dev/null \
    | grep -i 'protonvpn' \
    | grep -v 'killswitch' \
    | head -1)

active_conns=$(nmcli -t -f NAME connection show --active 2>/dev/null)
ks_advanced=$(echo "$active_conns" | grep -c 'pvpn-killswitch-perm')
ks_standard=$(echo "$active_conns" | grep -cx 'pvpn-killswitch')

GRN='#50FA7B'
YLW='#FFE08F'
RED='#BF1A1A'
BLU='#8BE9FD'

if [[ -n "$vpn_line" ]]; then
    server=$(echo "$vpn_line" | cut -d: -f1 | sed 's/^ProtonVPN //')
    dev=$(echo "$vpn_line" | cut -d: -f3)
    pub_ip=$(curl -s --max-time 2 https://ifconfig.me 2>/dev/null)

    if [[ "$ks_advanced" -gt 0 ]]; then
        text="<span color='${GRN}'>󰕥</span> ${server}"
        tooltip="Server: $server\nIP: ${pub_ip:-N/A}\nInterface: $dev\nKill Switch: Advanced"
    elif [[ "$ks_standard" -gt 0 ]]; then
        text="<span color='${YLW}'>󰕥</span> ${server}"
        tooltip="Server: $server\nIP: ${pub_ip:-N/A}\nInterface: $dev\nKill Switch: Standard"
    else
        text="<span color='${RED}'>󰒃</span> ${server}"
        tooltip="Server: $server\nIP: ${pub_ip:-N/A}\nInterface: $dev"
    fi

    printf '{"text":"%s","tooltip":"%s","class":"connected"}\n' "$text" "$tooltip"
elif [[ "$ks_advanced" -gt 0 ]]; then
    text="<span color='${BLU}'>󰕥</span> Ghost"
    tooltip="VPN Disconnected\nKill Switch: Advanced\nInternet Blocked"

    printf '{"text":"%s","tooltip":"%s","class":"blocked"}\n' "$text" "$tooltip"
else
    pub_ip=$(curl -s --max-time 2 https://ifconfig.me 2>/dev/null)
    text="<span color='${RED}'>󰕤</span> Public"
    tooltip="VPN Disconnected\nIP: ${pub_ip:-N/A}"

    printf '{"text":"%s","tooltip":"%s","class":"disconnected"}\n' "$text" "$tooltip"
fi
