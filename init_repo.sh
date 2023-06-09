#!/bin/sh

# init_repo -n "name" -l "license" -i "languages".
# Build project folder with git and open on vscode.
init_repo () {
    files=('LICENSE.md' 'README.md' '.gitignore' '.editorconfig' '.env' 'Makefile')
    while getopts ":n:l:i:" opt; do
    case $opt in
        n)
            name="$(echo $OPTARG | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')"
            mkdir $name && cd $name && git init

            alias_properties=$(awk '/^\[alias\]/ {p=1; next} /^\[.*\]/ {p=0} p' ~/.gitconfig)
            echo -e "\n[alias]\n$alias_properties" >> .git/config

            mkdir -p src test assets/{data,img,docs} .github/{ISSUE_TEMPLATE,workflows}
            echo "# $name" | sed 's/-/ /g' | tr '[:upper:]' '[:lower:]' | sed 's/\b[a-z]/\u&/g' >> README.md
            xdg-open . &
        ;;
        i)
            ignore="$OPTARG,visualstudiocode,$(uname -s)"
            if [ $ignore ]; then
                gitignores="${ignore//" "/","}"
                curl -fLw '\n' https://www.gitignore.io/api/$gitignores >>.gitignore
            fi
        ;;
        l)
            license=$OPTARG
            if [ $license ]; then
                response=$(curl -sLX GET "https://api.github.com/licenses/$license" | jq ".body")
                echo -en $response >LICENSE.md
                sed -Ee 's/(\\"|\")//g' \
                    -e s/"\[year\]"/"$(date +%Y)"/g \
                    -e s/"\[fullname\]"/"$(git config user.name)"/g \
                    -i LICENSE.md
            fi
        ;;
    esac
    done

    for i in "${files[@]}"; do
        if [ -s $i ]; then
            git add $i
        else
            echo "🧪 Generate $i" | tee -a todo.md
        fi
    done

    git commit -m "🎉 init(build): Set project environment."
    code . #//&& exit
}
