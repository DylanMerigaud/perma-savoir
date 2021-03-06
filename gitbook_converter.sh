# #!/bin/bash

GITBOOK_REP=$PWD
SUMMARY_FILE="SUMMARY.md"
echo $OUTPUT_FILE

if [ -d "$GITBOOK_REP" ]; then

  echo "Entering directory '$GITBOOK_REP'..."
  cd $GITBOOK_REP
  if [ -f "$SUMMARY_FILE" ]; then
    pandoc $SUMMARY_FILE -t html |
      cat
    # read summary and get texts by order in a single big file
    pandoc $SUMMARY_FILE -t html | \
      grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
      sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'| \
      xargs cat | \
      pandoc -f markdown --toc -o book.epub
    pandoc $SUMMARY_FILE -t html | \
      grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
      sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'| \
      xargs cat | \
      pandoc -f markdown --toc -o book.pdf
    echo "Done"
  else
    echo "File '$SUMMARY_FILE' does not exist"
  fi
else
echo "Directory '$GITBOOK_REP' does not exist"
fi
