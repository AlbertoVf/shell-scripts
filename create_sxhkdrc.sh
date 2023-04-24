#!/bin/sh

# build a sxhkdrc shortcut file with json file
create_sxhkdrc(){
    folder="$HOME/.config/sxhkd"
    input_file="$folder/shortcuts.json"
    output_file="$folder/sxhkdrc"

    cp -f $output_file $output_file.old
    jq -r 'keys[] as $k | "\($k) \(.[$k] | to_entries[] | [.key, .value] | @tsv)"' "$input_file" > "$output_file"

    sed -i 's/^ //g' "$output_file"
    sed -i 's/\t/\n\t/g' "$output_file"

    sed -i "1i # Generated on $(date +'%Y-%m-%d %H:%M')" "$output_file"
}
