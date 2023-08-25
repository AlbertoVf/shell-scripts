#!/bin/sh

# init_repo -n "name" -l "license" -i "languages".
# Build project folder with git and open on vscode.
init_repo () {
    files=('LICENSE.md' 'README.md' '.gitignore' '.editorconfig' '.env' 'Makefile' '.vscode/settings.json' '.vscode/code.code-snippets' '.vscode/tasks.json')

    folder=$(basename "$(pwd)")
    name="$(echo $folder | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')"

    mkdir -p src test assets/{data,img,docs} .github/{ISSUE_TEMPLATE,workflows} .vscode && git init
    echo "# $name" | sed 's/-/ /g' | tr '[:upper:]' '[:lower:]' | sed 's/\b[a-z]/\u&/g' >> README.md

    while getopts ":l:i:" opt; do
    case $opt in
        i)
            alias_properties=$(awk '/^\[alias\]/ {p=1; next} /^\[.*\]/ {p=0} p' ~/.gitconfig)
            echo -e "\n[alias]\n$alias_properties" >> .git/config

            ignore="$OPTARG"
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
    code .
}
