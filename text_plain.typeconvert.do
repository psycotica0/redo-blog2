
# Build the script required for outputting text/plain files.
# In this case we want it to be executable, so we have to use $3.
echo '
# Output <pre> before and after body (on stdin)
echo "<pre>"
cat
echo "</pre>"' > "$3"

chmod a+x "$3"

