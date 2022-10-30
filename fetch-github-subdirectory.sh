#!/bin/sh

URL="<github-repo>"
DIRECTORY="<path/to/directory>"
BRANCH="<branch-name>"
OUTPUT_DIR="<path/to/output/directory>"

START=$SECONDS

mkdir "fetch-files"
cd "fetch-files"

echo "Fetching files from ($BRANCH) $DIRECTORY in $URL"
git init
git remote add -f origin $URL

# fetch and checkout the subdirectory only
echo "Dumping files in $(pwd)/fetch-files"
git config core.sparseCheckout true
git sparse-checkout set $DIRECTORY

git pull origin $BRANCH
echo "subdirectory fetched"

echo "Copying files to $OUTPUT_DIR"
cd ..
cp -R "fetch-files/$DIRECTORY/." "$(pwd)/$OUTPUT_DIR"

echo "Cleaning up..." 
rm -r -f "fetch-files"

DURATION=$(( SECONDS - START ))
echo "Done in $DURATION seconds."
