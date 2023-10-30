#!/usr/bin/env bash
## ? Help : Descarga los videos de las url guardadas en un archivo.
## ? Usage:
## ?    yt-video-file <file>

yt-video-file() {
	yt-dlp --no-playlist \
		--embed-metadata \
		-f mp4 \
		-o "$(xdg-user-dir DOWNLOAD)/%(title)s.%(ext)s" \
		--batch-file $@
}
