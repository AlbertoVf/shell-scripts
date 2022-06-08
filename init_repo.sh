#!/usr/bin/sh

# $1: repo name $2: gitignore languages ex: "python,go,JetBranins"
# Create a new repository.
# Create folder for test,assets and code
# Create a README, LICENSE and a .gitignore file with the code($2)
# Create a commit with a message.
# ex: init_repo.sh my_repo "python,JetBranins"
function init_repo() {
  mkdir -p $1/{src,test,assets/{img,fonts,js,css,docs}}
  cd $1
  touch LICENSE Makefile
  echo "# $1" >>README.md
  if [ $2 ]; then
    gitignores="${2//" "/","}"
    curl -fLw '\n' https://www.gitignore.io/api/$gitignores >>.gitignore
  fi
  git init && git add -A
  git commit -m "build: :hammer: Create proyect structure."
}