#!/usr/bin/env bash
## ? Help : Descarga el audio de un video.
## ? Usage:
## ?    yt-audio <url>

yt-audio() {
	yt-dlp -i --no-playlist \
		--embed-metadata --embed-thumbnail \
		--audio-quality 0 -f bestaudio -x --audio-format mp3 \
		-o "$(xdg-user-dir DOWNLOAD)/%(title)s.%(ext)s" $@
}
