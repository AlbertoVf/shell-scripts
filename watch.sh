#!/bin/sh

# Open a file in terminal view: bat/cat/less.
# If it is a web service open in explorer.
watch() {
    if [[ $1 =~ '^[https? | ftps?]' ]]; then
        xdg-open $1
    elif [[ $1 =~ ^[0-9]{1,5}$ ]]; then
        xdg-open "http://localhost:$1"
    else
        bat "./$1" || cat "./$1" || less "./$1"
    fi
}
