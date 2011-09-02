
redo-ifchange all
cat *.mime | grep '^Tag:' | cut -d ':' -f 2- | sort | uniq | xargs mkdir -p
ls *.tag | while read line; do
	untag="${line%.tag}"
	tag="${untag##*.}"
	# The .*.tag is so that mime can be an accepted tag
	originalfile="${line%.mime.*.tag}"
	cp "$line" "$tag/$originalfile.html"
done
