for f in "$@"; do
  echo "#$f" >> purl.yt
  ffprobe -v quiet -show_entries format_tags -of json "$f" \
  | jq -r '.format.tags.purl'  >> purl.yt
done
