#!/bin/bash

## This should be launched on ci by timer

set -e

echo "Downloading english from russian project"
crowdin download -c crowdin-ru.yml --skip-untranslated-strings -l en --no-progress
echo "Uploading sources to english project"
crowdin upload sources -c crowdin-en.yml --no-progress
