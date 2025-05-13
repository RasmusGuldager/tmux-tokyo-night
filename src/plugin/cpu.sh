#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$ROOT_DIR/../utils.sh"

plugin_cpu_icon=$(get_tmux_option "@theme_plugin_cpu_icon" " ")
plugin_cpu_accent_color=$(get_tmux_option "@theme_plugin_cpu_accent_color" "blue7")
plugin_cpu_accent_color_icon=$(get_tmux_option "@theme_plugin_cpu_accent_color_icon" "blue0")

export plugin_cpu_icon plugin_cpu_accent_color plugin_cpu_accent_color_icon

cpu_idle=$(mpstat 1 1 | awk '/Average/ && $NF ~ /[0-9.]+/ { print $NF }')
cpu_usage=$(awk -v idle="$cpu_idle" 'BEGIN { printf "%.1f", 100 - idle }')

echo "${cpu_usage}%"
