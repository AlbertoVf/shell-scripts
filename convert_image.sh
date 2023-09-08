#!/bin/sh

# Convert image to png format.
to_png(){
    for f in "$@"; do
        name=$(basename "$f")
        folder=$(dirname "$f")
        name="${name%.*}"
        convert "$f" -background white "$folder/$name.png"
        echo "Imagen convertida: $name -> $name.png"
    done
}

# Convert image to jpg format.
to_jpg(){
    for f in "$@"; do
        name=$(basename "$f")
        folder=$(dirname "$f")
        name="${name%.*}"
        convert -quality 100 "$f" "$folder/$name.jpg"
        echo "Imagen convertida: $name -> $name.jpg"
    done
}
