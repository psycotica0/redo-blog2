
# This generate a file that contains (in order of creation from earliest to latest) a list of all files for a given tag.

tag="$1"
find . -name '*.mime' -exec grep -q "^Tag:.*\<$1\>" '{}' ';'  -print | sed 's_^\./__' | sed 's/.mime$//' | while read file; do
	# Need this to get ordering
	redo-ifchange "$file.augmented"
	c_time="$(sed -n 's/Date-Created: *\(.*\)/\1/p' < "$file.augmented")"
	echo "$c_time $file" >> $3
done

hack="$(sort < $3 | cut -d ' ' -f 2-)"
echo "$hack" > $3
