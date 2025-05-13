#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$ROOT_DIR/../utils.sh"

plugin_internet_icon=$(get_tmux_option "@theme_plugin_internet_icon" "🌐")
plugin_internet_accent_color=$(get_tmux_option "@theme_plugin_internet_accent_color" "blue7")
plugin_internet_accent_color_icon=$(get_tmux_option "@theme_plugin_internet_accent_color_icon" "blue0")

export plugin_internet_icon plugin_internet_accent_color plugin_internet_accent_color_icon

# Get the top active connection name (excluding lo and docker)
if command -v nmcli &>/dev/null; then
    connection_name=$(nmcli -t -f NAME,DEVICE,TYPE,STATE connection show --active | \
                      awk -F: '$2 != "lo" && $2 != "docker0" && $4 == "activated" { print $1; exit }')
    if [[ -n "$connection_name" ]]; then
        echo "${connection_name}"
    else
        echo "Disconnected"
    fi
else
    echo "Disconnected"
fi
