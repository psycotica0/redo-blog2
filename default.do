
ls *.mime | while read file; do
	dependedFile="$file.augmented.html"
	sed -n '/^Tag:/s/^Tag:[^a-zA-Z0-9_-]*\([a-zA-Z0-9_-]*\).*/\1/p' < "$file" | while read tag; do echo "$dependedFile.$tag.tag"; done  | xargs redo-ifchange
done
