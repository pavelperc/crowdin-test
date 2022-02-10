#!/bin/bash

sources=(
  "app/src/main/res/values/strings.xml"
  "module/src/main/res/values/strings.xml"
)

for src in "${sources[@]}"
do
  mv "$src" "${src}.tmp"
done

set -e
echo "Downloading recent sources"
crowdin download sources -c crowdin-ru.yml --no-progress
set +e

echo "Calculating diff"
deleted_lines=""
added_lines=""
for src in "${sources[@]}"
do
  echo "${src}:"
  diff "$src" "${src}.tmp" --old-line-format="---%L" --new-line-format="+++%L" --unchanged-line-format="" --ignore-blank-lines

  deleted_lines+=$(diff "$src" "${src}.tmp" --old-line-format="---%L" --new-line-format="" --unchanged-line-format="" --ignore-blank-lines)
  added_lines+=$(diff "$src" "${src}.tmp" --old-line-format="" --new-line-format="+++$L" --unchanged-line-format="" --ignore-blank-lines)

  mv "${src}.tmp" "$src"
done

if [ -n "$deleted_lines" ] && [ "$1" != "-f" ]
then
  tput setaf 1 # red
  echo "Can not finish upload. Have deleted lines between recent sources and your version."
  echo "Download recent sources and add you lines again. Either use -f for force upload."
  tput sgr0
  exit 1
fi

if [ -z "$added_lines" ] && [ "$1" != "-f" ]
then
  tput setaf 1 # red
  echo "Can not finish upload. Diff is empty. Use -f for force upload."
  tput sgr0
  exit 1
fi

set -e
echo "Uploading sources"
crowdin upload sources -c crowdin-ru.yml --no-progress
set +e