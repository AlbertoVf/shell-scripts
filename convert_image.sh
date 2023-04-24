#!/bin/sh

# convert image to .png
convert_image() {
    image_extension="png"
    file=$1
    extension="$(echo $file | cut -d '.' -f2-)"
    name="$(echo $file | cut -d '.' -f1)"
    $name="$name.$image_extension"
    case $extension in
    jpg | jpeg) convert $file $name ;;
    webp) dwebp $file -o $name ;;
    bimp | bmp) mogrify -format $image_extension $file ;;
    esac
}
