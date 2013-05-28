#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

SELF=`basename $0`
SOURCE_BRANCH="source"
DEST_BRANCH="master"
COPY_DIR="_copy_to_site"
TMP_DIR="tmp"

git checkout $SOURCE_BRANCH
git commit -am "Source updates"
jekyll build -d $TMP_DIR
cp -r $COPY_DIR/* $TMP_DIR
git checkout $DEST_BRANCH
git rm -qr .
cp -r $TMP_DIR/. .
# Delete this script from the output
rm ./$SELF
rm -r $TMP_DIR
git add -A
git commit -m "Published updates"
# May not want to push straight away
# git push origin master
git checkout $SOURCE_BRANCH
