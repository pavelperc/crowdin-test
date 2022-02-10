#!/bin/bash

set -e

echo "Downloading russian sources"
crowdin download sources -c crowdin-ru.yml --no-progress
echo "Downloading russian translations"
crowdin download -c crowdin-ru.yml --skip-untranslated-strings --no-progress
echo "Downloading english translations"
crowdin download -c crowdin-en.yml --skip-untranslated-strings --no-progress