#!/bin/sh

# Build a sxhkdrc shortcut file with json file.
create_sxhkdrc() {
	input_file="$HOME/.dotfiles/doc/shortcuts.json"
	output_file="$HOME/.dotfiles/os/linux/sxhkd/sxhkdrc"

	cp -f $output_file $HOME/.config/sxhkd/sxhkdrc.old
	jq -r 'keys[] as $k | "\($k) \(.[$k] | to_entries[] | [.key, .value] | @tsv)"' "$input_file" >"$output_file"

	sed -i 's/^ //g' "$output_file"
	sed -i 's/\t/\n\t/g' "$output_file"

	sed -i "1i # Generated on $(date +'%Y-%m-%d %H:%M')" "$output_file"
	sed -i "1i #!/bin/sh" "$output_file"
	echo "Reiniciar sxhkd"
}
