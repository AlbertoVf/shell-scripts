#!/bin/sh

# Move files to folder by MIME.
refactor_files() {
    # logfile="refactor_files-$(date +'%Y%m%d_%H%M%S').log"

    for archivo in *; do
        mimetype=$(file -b --mime-type "$archivo")
        mime=$(echo $mimetype | cut -d '/' -f1)
        type=$(echo $mimetype | cut -d '/' -f2)

        case $mime in
        audio) mv -v $archivo "$(xdg-user-dir MUSIC)/" ;;
        font) mv $archivo "$(xdg-user-dir USERFONTS)" ;;
        image) mv -v $archivo "$(xdg-user-dir PICTURES)/" ;;
        video) mv -v $archivo "$(xdg-user-dir VIDEOS)/" ;;
        esac

        case $type in
        pdf | *opendocument*) mv -v $archivo "$(xdg-user-dir DOCUMENTS)/" ;;
        *template) mv -v $archivo "$(xdg-user-dir TEMPLATES)/" ;;
        *rom | octet-stream) mv -v $archivo "$HOME/Games/" ;;
        # *) echo "$archivo: no se ha movido" ;;
        esac
    done
}
