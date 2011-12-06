
# This is meant to use metadata from git, or hg, or the filesystem, or whatever to augment the user-given metadata
# It's meant to fill in all the auto-generatable blanks
# This implementation gets data from git.

redo-ifchange "$1.mime"

times="$(git log --pretty=format:%at "$1.mime")"
# This is the last time a change was made
modify_time="$(echo "$times" | sed -n '1p')"
# This is the first time the file was added
create_time="$(echo "$times" | sed -n '$p')"

# This is the date format (iso8601)
date_format="%Y-%m-%dT%H:%M:%SZ"

# I don't know how standard the '@' to set based on epoch time is, but I know the -d isn't super standard
echo "Date-Created: $(date -ud "@$create_time" "+$date_format")"
echo "Date-Modified: $(date -ud "@$modify_time" "+$date_format")"
cat "$1.mime"
