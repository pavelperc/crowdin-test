#!/bin/bash

set -e

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

echo "Downloading russian sources and translations"
crowdin download sources -c crowdin-ru.yml --no-progress &
crowdin download -c crowdin-ru.yml --no-progress &
wait
# english translations require english sources from russian project, so can not run in parallel.
echo "Downloading english translations"
crowdin download -c crowdin-en.yml --no-progress

echo "Caching crowdin status"
mv .crowdin-status.txt.tmp .crowdin-status.txt

