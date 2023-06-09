#!/bin/sh

# Print shortcuts from kitty,qtile and sxhkd.
get_shortcuts() {
    # * kitty
    echo -e '\033[1;34m KITTY \033[37;0m'
    grep '^map' $HOME/.config/kitty/kitty.conf | awk '{for (i=2; i <= NF; i++) printf "%s ", $i; printf "\n"}'

    # * sxhkdrc
    echo -e '\033[1;34m SXHKDRC \033[37;0m'
    cat $HOME/.config/sxhkd/sxhkdrc | tail -n +2 | sed ':a;N;$!ba;s/\n\t/: /g'

    # * qtile
    echo -e '\033[1;34m QTILE \033[37;0m'
    grep '^[[:space:]]*\(Key\|Click\|Drag\)' $HOME/.config/qtile/settings/keys.py | sed 's/^[[:space:]]*//'
}
