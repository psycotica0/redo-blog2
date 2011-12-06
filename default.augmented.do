
# This is meant to use metadata from git, or hg, or the filesystem, or whatever to augment the user-given metadata
# It's meant to fill in all the auto-generatable blanks
# Here we're reading fake data from the file metadata

redo-ifchange "$1.mime"

# I don't know how standard the -c option is
modify_time="$(stat -c "%Y" "$1.mime")"
# I can't get creation time from the system reliably
create_time="$modify_time"

# This is the date format (iso8601)
date_format="%Y-%m-%dT%H:%M:%SZ"

# I don't know how standard the '@' to set based on epoch time is, but I know the -d isn't super standard
echo "Date-Created: $(date -ud "@$create_time" "+$date_format")"
echo "Date-Modified: $(date -ud "@$modify_time" "+$date_format")"
cat "$1.mime"
