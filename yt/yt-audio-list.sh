#!/usr/bin/env bash
## ? Help : Descarga una playlist.
## ? Usage:
## ?    yt-audio-list <url>

yt-audio-list() {
	yt-dlp -w -i \
		--embed-metadata --embed-thumbnail \
		--audio-quality 0 -f bestaudio -x --audio-format mp3 \
		-o "$(xdg-user-dir DOWNLOAD)/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" $@
}
