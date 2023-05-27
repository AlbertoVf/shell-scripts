#!/usr/bin/sh

# Convert image to png format.
convert_image(){
    files=()
    for parametro in "$@"; do
        files+=("$parametro")
    done
    for f in "${files[@]}"; do
        name=$(basename "$f")
        name="${name%.*}"
        convert "$f" "$name.png"
        echo "Imagen convertida: $f -> $name.png"
    done
}
