#!/bin/sh

# Convert images to pdf.
image_to_pdf() {
    for image_file in "$@"; do
        pdf_file="${image_file%.*}.pdf"
        convert "$image_file" "$pdf_file"
    done
}
