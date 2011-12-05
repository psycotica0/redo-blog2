
# This generates the default template script used by any tag without a special one

echo '#!/bin/sh

contents="$(cat)"
title="$(echo "$contents" | sed -n "/^Title:/s/^Title:[ 	]//p")"
body="$(echo "$contents" | sed "1,/^$/d")"
next="$(echo "$contents" | sed -n "/^Next-Link:/s/^Next-Link:[ 	]*//p")"
prev="$(echo "$contents" | sed -n "/^Previous-Link:/s/^Previous-Link:[ 	]*//p")"

echo "<html>
<head>
<title>$title</title>
</head>
<body>"
if [ -n "$prev" ]; then
	echo "<a href=\"$prev.html\" rel="prev"> Prev </a>"
fi
if [ -n "$next" ]; then
	echo "<a href=\"$next.html\" rel="next"> Next </a>"
fi
echo " <h1> $title </h1>
	$body
</body>
</html>"
' > "$3"
chmod a+x "$3"
