
echo '#!/bin/sh

contents="$(cat)"
title="$(echo "$contents" | sed -n "/^Title:/s/^Title:[ 	]//p")"
body="$(echo "$contents" | sed "1,/^$/d")"

echo "<html>
<head>
<title>$title</title>
</head>
<body>
	<h1> $title </h1>
	$body
</body>
</html>"
'
