
# This is meant to use metadata from git, or hg, or the filesystem, or whatever to augment the user-given metadata
# It's meant to fill in all the auto-generatable blanks

redo-ifchange "$1.mime"
echo "ID: blah"
echo "Date-Created: YYYY-MM-DD"
echo "Date-Modified: YYYY-MM-DD"
cat "$1.mime"
