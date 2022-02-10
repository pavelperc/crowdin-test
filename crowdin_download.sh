#!/bin/bash

set -e

#### status check time:	0m5.561s (maybe disable?)

echo "Fetching crowdin status"
crowdin status -v -c crowdin-ru.yml --no-progress > .crowdin-status.txt.tmp &
crowdin status -v -c crowdin-en.yml --no-progress > .crowdin-status-en.txt.tmp &
wait

cat .crowdin-status-en.txt.tmp >> .crowdin-status.txt.tmp
rm .crowdin-status-en.txt.tmp

if cmp -s .crowdin-status.txt .crowdin-status.txt.tmp && [ "$1" != "-f" ]; then
  rm .crowdin-status.txt.tmp
  echo "No changes in crowdin status, skip. Use -f for force download."
  exit 1
fi

### parallel download time: 0m7.956s, in bookmate: 0m8.946s

echo "Downloading all in parallel"
crowdin download sources -c crowdin-ru.yml --no-progress &
crowdin download -c crowdin-ru.yml --no-progress &
crowdin download -c crowdin-en.yml --no-progress &
wait

echo "Caching crowdin status"
mv .crowdin-status.txt.tmp .crowdin-status.txt

