#!/bin/bash

src="app/src/main/res/values/strings.xml"
src_tmp="app/src/main/res/values/strings.xml.tmp"

mv $src $src_tmp

set -e
echo "Downloading recent sources"
crowdin download sources -c crowdin-ru.yml --no-progress
set +e

echo "Calculating diff:"
diff $src $src_tmp --old-line-format="---%L" --new-line-format="+++%L" --unchanged-line-format="" --ignore-blank-lines

deleted_lines=$(diff $src $src_tmp --old-line-format="---%L" --new-line-format="" --unchanged-line-format="" --ignore-blank-lines)
added_lines=$(diff $src $src_tmp --old-line-format="" --new-line-format="+++$L" --unchanged-line-format="" --ignore-blank-lines)

mv $src_tmp $src

if [ -n "$deleted_lines" ] && [ "$1" != "-f" ]
then
  tput setaf 1
  echo "Can not finish upload. Have deleted lines between recent sources and your version."
  echo "Download recent sources and add you lines again. Either use -f for force upload."
  tput sgr0
  exit 1
fi

if [ -z "$added_lines" ] && [ "$1" != "-f" ]
then
  tput setaf 1
  echo "Can not finish upload. Diff is empty. Use -f for force upload."
  tput sgr0
  exit 1
fi

set -e
echo "Uploading sources"
crowdin upload sources -c crowdin-ru.yml --no-progress
set +e