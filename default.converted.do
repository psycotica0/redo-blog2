
# This is meant to take the mime files and turn their bodies from whatever format they are, into html

redo-ifchange "$1.augmented"

# Pull the type out of the file to figure out how to build it
# Also, convert the / in the type into _ for filesystem niceness
type="$(sed -n '/^Content-Type:/s/^Content-Type:\(.*\)$/\1/p' < "$1.augmented" | tr -d ' ' | tr '/' '_')"
if [ -z "$type" ]; then
	echo "Warning: No Content Type. Assuming text/plain" >&2
	type="text_plain"
fi
# Output the headers of the augmented file, without Content-Type
sed '/^$/,$d' < "$1.augmented" | grep -v '^Content-Type:'
# We assume that it will turn into HTML, so we'll add that now
echo "Content-Type: text/html"
# Now, we're done with headers
echo

# Require the type-converter for this type
redo-ifchange "$type.typeconvert"

# Now run it with the body and let it output directly
sed '1,/^$/d' < "$1.augmented" | "./$type.typeconvert"
