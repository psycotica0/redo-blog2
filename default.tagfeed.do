
# This file makes feed, for each tag, of recent articles, etc.

tag="$1"
author_name="Name"
author_email="email@domain.com"
icon="http://icon.com"
title="Tag: $tag"
home="http://example.com"
this_tag="$home/$tag"
this_feed="$this_tag/feed.atom"

atom_format="%Y-%m-%dT%H:%M:%SZ"

echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<feed xmlns="http://www.w3.org/2005/Atom">'
echo "	<title>$title</title>"
echo "	<link href='$this_feed' rel='self' />"
echo "	<link href='$home' />"
echo "	<id>$this_feed</id>"

echo "	<updated>$(date "+$atom_format")</updated>"
echo "	<author>
		<name>$author_name</name>
		<email>$author_email</email>
	</author>"
echo '	<generator uri="https://github.com/psycotica0/redo-blog2">Redo-Blog2</generator>'
echo "	<icon>$icon</icon>"

# Contents Go Here
redo-ifchange "tagindex"
grep "^$tag " < "tagindex" | cut -d ' ' -f 2- | tac | while read file; do
	redo-ifchange "$file.converted"
	title="$(sed -n 's/Title:[ 	]*\(.*\)/\1/p' < "$file.converted")"
	mod_date="$(sed -n 's/Date-Modified:[ 	]*\(.*\)/\1/p' < "$file.converted")"
	create_date="$(sed -n 's/Date-Created:[ 	]*\(.*\)/\1/p' < "$file.converted")"
	echo '	<entry>'
	echo "		<link rel='alternate' type='text/html' href='$this_tag/$file.html' />"
	echo "		<id>$this_tag/$file.html</id>"
	echo "		<title>$title</title>"
	echo "		<published>$create_date</published>"
	echo "		<updated>$mod_date</updated>"
	# Now spit out the body
	echo '		<content type="html">'
	sed '1,/^$/d' < "$file.converted" | sed 's/</\&lt;/g' | sed 's/>/\&gt;/g'
	echo '		</content>'
	echo '	</entry>'
done

echo '</feed>'
