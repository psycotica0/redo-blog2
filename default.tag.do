
tag="${1##*.}"
dependedFile="${1%.*}"

redo-ifchange "$dependedFile" "$tag.tagtemplate"
sh "$tag.tagtemplate" < "$dependedFile"
