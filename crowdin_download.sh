#!/bin/bash

set -e

echo "Fetching crowdin status"
mkdir -p build
crowdin status -v -c crowdin-ru.yml --no-progress > build/crowdin-status.tmp &
crowdin status -v -c crowdin-en.yml --no-progress > build/crowdin-status-en.tmp &
wait

cat build/crowdin-status-en.tmp >> build/crowdin-status.tmp
rm build/crowdin-status-en.tmp

if cmp -s build/crowdin-status.txt build/crowdin-status.tmp && [ "$1" != "-f" ]; then
  rm build/crowdin-status.tmp
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
mv build/crowdin-status.tmp build/crowdin-status.txt

