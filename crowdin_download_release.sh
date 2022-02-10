#!/bin/bash

set -e

echo "Downloading all in parallel"
crowdin download sources -c crowdin-ru.yml --skip-untranslated-strings --no-progress &
crowdin download -c crowdin-ru.yml --skip-untranslated-strings --no-progress &
crowdin download -c crowdin-en.yml --skip-untranslated-strings --no-progress &
wait