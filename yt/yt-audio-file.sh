#!/usr/bin/env bash
## ? Help : Descarga el audio de las url guardadas en un archivo.
## ? Usage:
## ?    yt-audio-file <file>

yt-audio-file() {
	yt-dlp -i --no-playlist \
		--embed-metadata --embed-thumbnail \
		--audio-quality 0 -f bestaudio -x --audio-format mp3 \
		-o "$(xdg-user-dir DOWNLOAD)/%(title)s.%(ext)s" \
		--batch-file $@
}
