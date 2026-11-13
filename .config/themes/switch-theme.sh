#!/bin/sh

set -eu

themes_root="$HOME/.config/themes"
waybar_config_dir="$HOME/.config/waybar"

fail() {
    printf 'hypr-theme: %s\n' "$*" >&2
    exit 1
}

show_usage() {
    printf 'Uso: hypr-theme [nome-do-tema]\n' >&2
    exit 2
}

list_themes() {
    for theme_path in "$themes_root"/*; do
        [ -d "$theme_path" ] || continue
        [ -L "$theme_path" ] && continue
        printf '%s\n' "${theme_path##*/}"
    done | sort
}

select_theme() {
    case "$#" in
        1)
            selected_theme=$1
            ;;
        0)
            command -v rofi >/dev/null 2>&1 ||
                fail "Rofi não encontrado."

            available_themes=$(list_themes)
            [ -n "$available_themes" ] ||
                fail "Nenhum tema encontrado em $themes_root."

            selected_theme=$(printf '%s\n' "$available_themes" |
                rofi -dmenu -i -p "Tema") || exit 0

            [ -n "$selected_theme" ] || exit 0
            ;;
        *)
            show_usage
            ;;
    esac
}

validate_theme() {
    case "$selected_theme" in
        ''|*[!A-Za-z0-9_-]*)
            fail "Nome de tema inválido: $selected_theme"
            ;;
    esac

    selected_theme_dir="$themes_root/$selected_theme"
hypr_theme_config="$selected_theme_dir/hypr/theme.lua"
    waybar_theme_config="$selected_theme_dir/waybar/config.jsonc"
    waybar_theme_style="$selected_theme_dir/waybar/style.css"

    [ -f "$hypr_theme_config" ] ||
        fail "Módulo Lua do tema não encontrado: $hypr_theme_config"
    [ -f "$waybar_theme_config" ] ||
        fail "Configuração Waybar não encontrada: $waybar_theme_config"
}

activate_theme() {
    # O link current seleciona o pacote de tema para ambos os aplicativos.
    ln -sfnT "$selected_theme" "$themes_root/current"

    # O Waybar procura config.jsonc e style.css em ~/.config/waybar.
    ln -sfnT \
        "../themes/current/waybar/config.jsonc" \
        "$waybar_config_dir/config.jsonc"

    if [ -f "$waybar_theme_style" ]; then
        ln -sfnT \
            "../themes/current/waybar/style.css" \
            "$waybar_config_dir/style.css"
    else
        rm -f "$waybar_config_dir/style.css"
    fi
}

reload_desktop() {
    hyprctl reload

    if pgrep -x waybar >/dev/null 2>&1; then
        pkill -USR2 -x waybar || true
    else
        waybar >/dev/null 2>&1 &
    fi
}

main() {
    select_theme "$@"
    validate_theme
    activate_theme
    reload_desktop

    printf 'Tema aplicado: %s\n' "$selected_theme"
}

main "$@"
