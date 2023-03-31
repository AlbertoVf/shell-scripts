#!/bin/sh


# init_repo "name" "language1 language2..." "license"
# Build project folder with git and open on vscode
function init_repo() {

	name="$(echo $1 | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')"
	ignore="$2,visualstudiocode,$(uname -s)"
	license=$3
	files=('LICENSE.md' 'README.md' '.gitignore' '.editorconfig' '.env' 'Makefile')

	mkdir -p $name/{src,test,dist,assets/{img,docs},.github/workflows,.settings,.devcontainer} && cd $name && git init

	echo "# $name" | sed 's/-/ /g' | tr '[:upper:]' '[:lower:]' | sed 's/\b[a-z]/\u&/g' >> README.md
	if [ $ignore ]; then
		gitignores="${ignore//" "/","}"
		curl -fLw '\n' https://www.gitignore.io/api/$gitignores >>.gitignore
	fi

	if [ $license ]; then
		response=$(curl -sLX GET "https://api.github.com/licenses/$license" | jq ".body")
		echo -en $response >LICENSE.md
		sed -Ee 's/(\\"|\")//g' \
			-e s/"\[year\]"/"$(date +%Y)"/g \
			-e s/"\[fullname\]"/"$(git config user.name)"/g \
			-i LICENSE.md
	fi

	for i in "${files[@]}"; do
		if [ -s $i ]; then
			git add $i
		else
			echo "🧪 Generate $i"
		fi
	done

	git commit -m "🎉 init(build): Set project environment."
	code . #//&& exit
}
