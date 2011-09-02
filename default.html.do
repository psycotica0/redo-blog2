
redo-ifchange "$1"
cat "$1" | while read line; do
	echo "$line" | sed '/^Content-Type:/s_text/plain_text/html_'
	if [ -z "$line" ]; then
		echo "<pre>"
	fi
done
echo "</pre>"
