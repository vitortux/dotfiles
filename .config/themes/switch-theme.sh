#!/bin/sh

set -eu

themes_dir="$HOME/.config/themes"
waybar_dir="$HOME/.config/waybar"

if [ "$#" -eq 0 ]; then
    if ! command -v rofi >/dev/null 2>&1; then
        echo "Rofi não encontrado; informe o tema como argumento." >&2
        exit 1
    fi

    themes=$(find "$themes_dir" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
    if [ -z "$themes" ]; then
        echo "Nenhum tema encontrado em $themes_dir" >&2
        exit 1
    fi

    theme=$(printf '%s\n' "$themes" | rofi -dmenu -i -p "Tema") || exit 0
    [ -n "$theme" ] || exit 0
elif [ "$#" -eq 1 ]; then
    theme=$1
else
    echo "Uso: hypr-theme [nome-do-tema]" >&2
    exit 2
fi

case "$theme" in
    ''|*[!A-Za-z0-9_-]*)
        echo "Nome de tema inválido: $theme" >&2
        exit 2
        ;;
esac

theme_dir="$themes_dir/$theme"
hypr_config="$theme_dir/hypr/theme.conf"
waybar_config="$theme_dir/waybar/config.jsonc"
waybar_style="$theme_dir/waybar/style.css"

if [ ! -f "$hypr_config" ]; then
    echo "Configuração Hyprland não encontrada: $hypr_config" >&2
    exit 1
fi

if [ ! -f "$waybar_config" ]; then
    echo "Configuração Waybar não encontrada: $waybar_config" >&2
    exit 1
fi

# O link current seleciona um pacote de tema para Hyprland e Waybar.
ln -sfnT "$theme" "$themes_dir/current"

# O Waybar procura esses nomes fixos em ~/.config/waybar.
ln -sfnT "../themes/current/waybar/config.jsonc" "$waybar_dir/config.jsonc"
if [ -f "$waybar_style" ]; then
    ln -sfnT "../themes/current/waybar/style.css" "$waybar_dir/style.css"
else
    rm -f "$waybar_dir/style.css"
fi

hyprctl reload

if pgrep -x waybar >/dev/null 2>&1; then
    pkill -USR2 -x waybar || true
else
    waybar >/dev/null 2>&1 &
fi

echo "Tema aplicado: $theme"
