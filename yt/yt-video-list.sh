#!/usr/bin/env bash
## ? Help : Descarga una playlist.
## ? Usage:
## ?    yt-video-list <url>

yt-video-list() {
	yt-dlp -w \
		--embed-metadata \
		-f mp4 \
		-o "$(xdg-user-dir DOWNLOAD)/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" $@
}
