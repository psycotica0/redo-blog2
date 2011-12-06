
# Generate a list of tags for each file, then use those to figure out what to build

redo-ifchange "tagindex"

sed 's/^\([^ ]*\) \(.*\)$/\2.\1.html/' < "tagindex" | xargs redo-ifchange

# And make a tagindex for each tag
sed 's/^\([^ ]*\) .*/\1.tagindex/' < "tagindex" | sort | uniq | xargs redo-ifchange
sed 's/^\([^ ]*\) .*/\1.tagfeed/' < "tagindex" | sort | uniq | xargs redo-ifchange
