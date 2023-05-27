#!/bin/sh

# Convert images to pdf.
image_to_pdf() {
    files=()
    for parametro in "$@"; do
        files+=("$parametro")
    done
    for image_file in "${files[@]}"; do
        pdf_file="${image_file%.*}.pdf"
        convert "$image_file" "$pdf_file"
    done
}
