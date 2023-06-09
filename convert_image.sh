#!/bin/sh

# Convert image to png format.
convert_image(){
    files=()
    for parametro in "$@"; do
        files+=("$parametro")
    done
    for f in "${files[@]}"; do
        name=$(basename "$f")
        folder=$(dirname "$f")
        name="${name%.*}"
        convert "$f" "$folder/$name.png"
        echo "Imagen convertida: $name -> $name.png"
    done
}
