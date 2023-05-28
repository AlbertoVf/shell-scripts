#!/bin/sh

# Find git repository folders.
find_repos() {
	fd -sHapL -d 2 --regex '\.git$' "$1/" -x echo {//}
}
