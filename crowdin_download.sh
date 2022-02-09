#!/bin/bash

set -e

echo "Downloading russian sources"
crowdin download sources -c crowdin-ru.yml --no-progress
echo "Downloading from russian project"
crowdin download -c crowdin-ru.yml --no-progress
echo "Downloading from english project"
crowdin download -c crowdin-en.yml --no-progress
