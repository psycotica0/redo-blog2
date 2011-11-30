
# Generate a list of tags for each file, then use those to figure out what to build

redo-ifchange "tagindex"

sed 's/^\([^ ]*\) \(.*\)$/\2.\1.html/' < "tagindex" | xargs redo-ifchange

