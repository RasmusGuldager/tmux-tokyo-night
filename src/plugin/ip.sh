#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load utility functions
. "$ROOT_DIR/../utils.sh"

plugin_ip_icon=$(get_tmux_option "@theme_plugin_ip_icon" "󰖩 ")
plugin_ip_accent_color=$(get_tmux_option "@theme_plugin_ip_accent_color" "blue7")
plugin_ip_accent_color_icon=$(get_tmux_option "@theme_plugin_ip_accent_color_icon" "blue0")
plugin_ip_interface=$(get_tmux_option "@theme_plugin_ip_interface" "")

# Set default if empty
if [[ -z "$plugin_ip_interface" ]]; then
    plugin_ip_interface=$(ip -o link show | awk -F': ' '/state UP/ && $2 != "lo" {print $2; exit}')
fi


export plugin_ip_icon plugin_ip_accent_color plugin_ip_accent_color_icon

get_ip_for_interface() {
    local iface="$1"

    if ip link show "$iface" 2>/dev/null | grep -q "state UP"; then
        ip -4 addr show "$iface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1
    fi
}

if command -v ip &>/dev/null; then
    ip_address=$(get_ip_for_interface "$plugin_ip_interface")

    # Fallback to loopback if primary interface failed
    if [[ -z "$ip_address" ]]; then
        ip_address=$(get_ip_for_interface "lo")
    fi

    if [[ -n "$ip_address" ]]; then
        echo "${ip_address}"
    else
        echo "127.0.0.1"
    fi
else
    echo "127.0.0.1"
fi
