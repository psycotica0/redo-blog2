
# This takes all .html files and moves them into a folder based on their tag and with sensible file names

redo-ifchange all

ls *.html | while read line; do
	tag="$(echo "$line" | sed 's/.*\.\([^.]*\)\.html$/\1/')"
	filename="$(basename "$line" ".$tag.html")"
	mkdir -p "$tag"
	cp "$line" "$tag/$filename.html"
done

# And move the index files in too
ls *.tagindex | while read line; do
	tag="$(basename "$line" ".tagindex")"
	# Just a precaution
	mkdir -p "$tag"
	cp "$line" "$tag/index.html"
done

# And move the feed files in too
ls *.tagfeed | while read line; do
	tag="$(basename "$line" ".tagfeed")"
	# Just a precaution
	mkdir -p "$tag"
	cp "$line" "$tag/feed.atom"
done
