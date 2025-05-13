#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=src/utils.sh
. "$ROOT_DIR/../utils.sh"

plugin_hello_icon=$(get_tmux_option "@theme_plugin_cpu_icon" "a")
plugin_hello_accent_color=$(get_tmux_option "@theme_plugin_cpu_accent_color" "blue7")
plugin_hello_accent_color_icon=$(get_tmux_option "@theme_plugin_cpu_accent_color_icon" "blue0")

export plugin_hello_icon plugin_hello_accent_color plugin_hello_accent_color_icon

echo "Hello"
