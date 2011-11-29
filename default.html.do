
# This is meant to take the mime files and run them through this tag's template engine to get static html files
# It also fills in some per-tag info

tag="${1##*.}"
base="$(basename "$1" ".$tag")"
dependedFile="$base.converted"

redo-ifchange "$dependedFile" "$tag.tagtemplate" "$tag.tagindex"

# Find our position in the index
pos="$(grep -n "^$base" < "$tag.tagindex" | cut -d ':' -f 1)"

if [ "$pos" -gt 1 ]; then 
	prev="$(sed -n "$(expr "$pos" - 1)"p < "$tag.tagindex")"
else
	prev=""
fi

# Sed returns "" for me when I walk off the edge of the file
next="$(sed -n "$(expr "$pos" + 1)"p < "$tag.tagindex")"

(echo "Next-Link: $tag/$next"; echo "Previous-Link: $tag/$prev"; cat "$dependedFile") | sh "$tag.tagtemplate"
