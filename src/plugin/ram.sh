#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$ROOT_DIR/../utils.sh"

plugin_ram_icon=$(get_tmux_option "@theme_plugin_ram_icon" "󱤓 ")  # Define icon but do not echo it
plugin_ram_accent_color=$(get_tmux_option "@theme_plugin_ram_accent_color" "blue7")
plugin_ram_accent_color_icon=$(get_tmux_option "@theme_plugin_ram_accent_color_icon" "blue0")

export plugin_ram_icon plugin_ram_accent_color plugin_ram_accent_color_icon

if command -v free &>/dev/null; then
    mem_line=$(free -m | grep -i "^mem" || free -m | grep -i "^Mem:")
    if [[ -n "$mem_line" ]]; then
        total=$(echo "$mem_line" | awk '{print $2}')
        used=$(echo "$mem_line" | awk '{print $3}')
        if [[ -n "$total" && -n "$used" ]]; then
            used_gb=$(awk -v u="$used" 'BEGIN { printf "%.1f", u / 1024 }')
            total_gb=$(awk -v t="$total" 'BEGIN { printf "%.1f", t / 1024 }')
            # Only echo the RAM usage without the icon
            echo "${used_gb}GB"
        else
            echo "N/A"
        fi
    else
        echo "N/A"
    fi
else
    echo "N/A"
fi
