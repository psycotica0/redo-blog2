
# This is meant to take the mime files and turn their bodies from whatever format they are, into html

redo-ifchange "$1"
cat "$1" | while read line; do
	echo "$line" | sed '/^Content-Type:/s_text/plain_text/html_'
	if [ -z "$line" ]; then
		echo "<pre>"
	fi
done
echo "</pre>"
