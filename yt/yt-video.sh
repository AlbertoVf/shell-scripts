#!/usr/bin/env bash
## ? Help : Descarga un video desde la url.
## ? Usage:
## ?    yt-video <url>

yt-video() {
	yt-dlp --no-playlist --embed-metadata \
		-f mp4 \
		-o "$(xdg-user-dir DOWNLOAD)/%(title)s.%(ext)s" $@
}
