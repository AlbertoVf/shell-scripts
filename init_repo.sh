#!/usr/bin/sh

# $1: repo name $2: gitignore languages ex: "python,go,JetBranins"
# Create a new repository.
# Create folder for test,assets and code
# Create a README, LICENSE and a .gitignore file with the code($2)
# Create a commit with a message.
# ex: init_repo.sh my_repo "python,JetBranins"
function init_repo() {
  mkdir -p $1/{src,test,assets/{img,docs}} && cd $1
  files=('README.md' '.gitignore' '.editorconfig' 'Makefile' 'Dockerfile' 'docker-compose.yml' 'LICENSE.md')
  git init
  echo "# $1" >>README.md
  if [ $2 ]; then
    gitignores="${2//" "/","}"
    curl -fLw '\n' https://www.gitignore.io/api/$gitignores >>.gitignore
  fi
  for i in "${files[@]}"; do
    if [ -s $i ]; then
      git add $i
    else
      touch $i && echo "Generate the $i file"
    fi
  done
  git commit -m "build: :hammer: Create proyect structure."
}