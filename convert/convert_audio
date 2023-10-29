#!/bin/sh

# Convert audio to m4a/mp4 format.
to_m4a() {
	for f in "$@"; do
		name=$(basename "$f")
		folder=$(dirname "$f")
		filename="${name%.*}"
		ffmpeg -i "$f" -c:v copy -c:a aac -strict experimental -b:a 192k "$folder/$filename.m4a"

		if [ $? -eq 0 ]; then
			echo "Convertido: $f -> $folder/$filename.m4a"
		else
			echo "Error al convertir: $f"
		fi
	done
}

# Convert audio to mp3 format.
to_mp3() {
	for f in "$@"; do
		name=$(basename "$f")
		folder=$(dirname "$f")
		filename="${name%.*}"
		ffmpeg -i "$f" -codec:v copy -codec:a mp3 -q:a 0 "$folder/$filename.mp3"
		if [ $? -eq 0 ]; then
			echo "Convertido: $f -> $folder/$filename.mp3"
		else
			echo "Error al convertir: $f"
		fi
	done
}
