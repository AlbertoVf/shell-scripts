#!/usr/bin/env sh
# ? description: Toggle picom compositor.
# ? usage      : picom_toggle [none]

pkill picom || picom -b --config ~/.config/picom/picom.conf
