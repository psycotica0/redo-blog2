
# This takes all .html files and moves them into a folder based on their tag and with sensible file names

redo-ifchange all
cat *.mime | grep '^Tag:' | cut -d ':' -f 2- | sort | uniq | xargs mkdir -p
ls *.html | while read line; do
	tag="$(echo "$line" | sed 's/.*\.\([^.]*\)\.html$/\1/')"
	filename="$(basename "$line" ".$tag.html")"
	cp "$line" "$tag/$filename.html"
done
