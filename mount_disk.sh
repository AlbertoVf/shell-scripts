#!/bin/sh

# Mount the partition with LABEL on the media folder.
mount_disk() {
    label=$(lsblk -o LABEL | grep "$1")
    device=$(blkid -l -o device -t LABEL="$label")
    d="/run/media/$USER/$label"
    sudo mkdir -p "$d" && sudo mount "$device" "$d"
    echo "[MOUNTED] $device --> $d"
}
