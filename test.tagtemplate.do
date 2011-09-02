
echo '#!/bin/sh

contents="$(cat)"
title="$(echo "$contents" | sed -n "/^Title:/s/^Title:[ 	]//p")"
body="$(echo "$contents" | sed "1,/^$/d")"

echo "<html>
<head>
<title>A TEST -  $title</title>
</head>
<body>
	<span class="example"> This is an example of a special template used for tests </span>
	<h1> $title </h1>
	$body
</body>
</html>"
'
