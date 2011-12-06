
# This makes a list of files of the form:
#  tag1 filename1
#  tag2 filename1
#  tag1 filename2
# Where the files are ordered by creation date given in filename.augmented
# This can be used for a lot of things:
#  With grep '^tag1 ' | cut -d ' ' -f2- you can get all files for a tag
#  With grep ' filename1$' | cut -d ' ' -f1 you can get all tags for a file
#  With cut -d ' ' -f1 | sort | uniq you can get all tags in use.

# Always run to see if there's a new article to be added to the tagindex
redo-always
# I've chosen to just use a sorted list of mime files. If that changes, the taglist should be considered changed
ls *.mime | sort | redo-stamp

ls *.mime | sed 's/.mime$//' | while read file; do
	# Need augmented to get the ordering
	# If, though, a new tag was added, then augmented will be different, so we'll be rerun to regenerate the index
	redo-ifchange "$file.augmented"
	c_time="$(sed -n 's/Date-Created: *\(.*\)/\1/p' < "$file.augmented")"
	for tag in $(grep '^Tag:' < "$file.augmented" | sed 's/^Tag://'); do
		echo "$c_time $tag $file" >> $3
	done
done

# This hack variable gets around the biggest shell bug that prevents (sort < $3 | cut > $3)
# The -k in sort says "If two articles have the same date, sort the lines by filename"
# This keeps all tags for a given file together, which we use to establish ordering.
# Otherwise we end up with weird stuff where a1 comes before a2 sometimes, depending on tags.
hack="$(sort -k 1,1 -k 3,3  < $3 | cut -d ' ' -f 2-)"
echo "$hack" > $3
