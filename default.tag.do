
# This is meant to take the mime files and run them through this tag's template engine to get static html files

tag="${1##*.}"
dependedFile="${1%.*}"

redo-ifchange "$dependedFile" "$tag.tagtemplate"
sh "$tag.tagtemplate" < "$dependedFile"
